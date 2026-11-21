// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '/app_constants.dart';
import '/backend/schema/structs/index.dart';

// Mood -> [movie genre ids, tv genre ids].
const _moodGenres = <String, List<List<int>>>{
  'Feel-good': [
    [35, 10751, 16, 10749],
    [35, 10751, 16]
  ],
  'Thrilling': [
    [28, 53, 80],
    [10759, 80, 9648]
  ],
  'Mind-bending': [
    [878, 9648],
    [10765, 9648]
  ],
  'Emotional': [
    [18, 10749],
    [18]
  ],
  'Scary': [
    [27, 53],
    [9648, 10765]
  ],
  'Epic': [
    [12, 14, 10752],
    [10759, 10765, 10768]
  ],
  'Chill': [
    [99, 16, 10402],
    [99, 16]
  ],
};

// Genre name -> [movie id, tv id].
const _genreIds = <String, List<int>>{
  'Action': [28, 10759],
  'Comedy': [35, 35],
  'Drama': [18, 18],
  'Sci-Fi': [878, 10765],
  'Animation': [16, 16],
  'Crime': [80, 80],
  'Mystery': [9648, 9648],
  'Documentary': [99, 99],
  'Family': [10751, 10751],
  'Fantasy': [14, 10765],
  'Horror': [27, 9648],
  'Romance': [10749, 18],
};

Future<Map<String, dynamic>?> _tmdb(
    String path, Map<String, String> query) async {
  try {
    final uri = Uri.https('api.themoviedb.org', '/3$path', {
      'api_key': FFAppConstants.tmdbApiKey,
      'language': 'en-US',
      ...query,
    });
    final res = await http.get(uri).timeout(const Duration(seconds: 12));
    if (res.statusCode != 200) return null;
    return jsonDecode(res.body) as Map<String, dynamic>;
  } catch (_) {
    return null;
  }
}

String _compact(int n) =>
    n >= 1000 ? '${(n / 1000).toStringAsFixed(n >= 10000 ? 0 : 1)}k' : '$n';

/// Rule-based recommendations from real TMDB data + the user's library.
/// On API failure returns a single item with tmdbId = -1 and the message in
/// `reason`. Returns [] when nothing matches.
Future<List<PickItemStruct>> getYelloPicks(
  String? moodArg,
  List<String>? genresArg,
  String? mediaTypeArg,
  int? maxMinutesArg,
  double? minRatingArg,
  bool? includeSavedArg,
  bool? surpriseArg,
  List<String>? excludeKeysArg,
  int? roundArg,
) async {
  final rng = Random();
  final surprise = surpriseArg ?? false;
  final isTv = (mediaTypeArg ?? 'movie') == 'tv';
  final type = isTv ? 'tv' : 'movie';
  final idx = isTv ? 1 : 0;
  var mood = moodArg ?? '';
  var genres = <String>[...?genresArg];
  var maxMinutes = maxMinutesArg ?? 0;
  var minRating = minRatingArg ?? 0;
  if (surprise) {
    mood = _moodGenres.keys.elementAt(rng.nextInt(_moodGenres.length));
    genres = [];
    maxMinutes = 0;
    minRating = 6.5;
  }
  final round = (roundArg ?? 0) < 0 ? 0 : (roundArg ?? 0);
  final exclude = <String>{...?excludeKeysArg};
  final includeSaved = includeSavedArg ?? false;

  // 1) The user's library (own documents only).
  final saved = <String>{};
  final liked = <Map<String, Object>>[];
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid != null) {
    try {
      final db = FirebaseFirestore.instance;
      final snaps = await Future.wait([
        db
            .collection('favorites')
            .where('userId', isEqualTo: uid)
            .limit(60)
            .get(),
        db
            .collection('watchlist')
            .where('userId', isEqualTo: uid)
            .limit(60)
            .get(),
        db
            .collection('reviews')
            .where('userId', isEqualTo: uid)
            .limit(60)
            .get(),
      ]).timeout(const Duration(seconds: 12));
      for (var i = 0; i < snaps.length; i++) {
        for (final doc in snaps[i].docs) {
          final m = doc.data();
          final key = (m['mediaKey'] ?? '').toString();
          if (key.isNotEmpty) saved.add(key);
          final positive =
              i == 0 || (i == 2 && ((m['rating'] as num?) ?? 0) >= 4);
          if (positive && m['mediaType'] == type && m['tmdbId'] is num) {
            liked.add({
              'id': (m['tmdbId'] as num).toInt(),
              'title': (m['title'] ?? '').toString(),
            });
          }
        }
      }
    } catch (_) {
      // Personal signals are optional; continue with filters only.
    }
  }

  // 2) Target genres from mood + selection.
  final moodIds = <int>{...?_moodGenres[mood]?[idx]};
  final selected = <int>{
    for (final g in genres)
      if (_genreIds[g] != null) _genreIds[g]![idx],
  };
  final target = <int>{...moodIds, ...selected};

  // 3) Genre affinity from liked titles (real TMDB genres).
  liked.shuffle(rng);
  final seeds = liked.take(6).toList();
  final affinity = <int, int>{};
  final seedDetails =
      await Future.wait(seeds.map((s) => _tmdb('/$type/${s['id']}', {})));
  for (final d in seedDetails) {
    for (final g in (d?['genres'] as List? ?? const [])) {
      final id = ((g as Map)['id'] as num).toInt();
      affinity[id] = (affinity[id] ?? 0) + 1;
    }
  }

  // 4) Candidate pool.
  final runtimeCap = maxMinutes <= 0
      ? 0
      : isTv
          ? (maxMinutes <= 90
              ? 45
              : maxMinutes <= 120
                  ? 60
                  : 75)
          : maxMinutes;
  final startPage = 1 + round * 2 + (surprise ? rng.nextInt(4) : 0);
  final discover = <String, String>{
    'sort_by': 'popularity.desc',
    'vote_count.gte': '150',
    'include_adult': 'false',
  };
  if (target.isNotEmpty) discover['with_genres'] = target.join('|');
  if (minRating > 0)
    discover['vote_average.gte'] = minRating.toStringAsFixed(1);
  if (runtimeCap > 0) discover['with_runtime.lte'] = '$runtimeCap';
  final seed = seeds.isNotEmpty ? seeds[round % seeds.length] : null;
  final calls = <Future<Map<String, dynamic>?>>[
    _tmdb('/discover/$type', {...discover, 'page': '$startPage'}),
    _tmdb('/discover/$type', {...discover, 'page': '${startPage + 1}'}),
    if (seed != null)
      _tmdb('/$type/${seed['id']}/recommendations', {'page': '${1 + round}'}),
  ];
  final responses = await Future.wait(calls);
  if (responses.every((r) => r == null)) {
    return [
      PickItemStruct(
        tmdbId: -1,
        reason:
            "Couldn't reach the movie database. Check your connection and try again.",
      ),
    ];
  }
  final candidates = <int, Map<String, dynamic>>{};
  final fromSeed = <int, String>{};
  for (var i = 0; i < responses.length; i++) {
    for (final m in (responses[i]?['results'] as List? ?? const [])
        .whereType<Map<String, dynamic>>()) {
      final id = (m['id'] as num?)?.toInt();
      if (id == null) continue;
      candidates.putIfAbsent(id, () => m);
      if (i == 2 && seed != null) fromSeed[id] = seed['title'] as String;
    }
  }

  // 5) Score.
  final scored = <MapEntry<Map<String, dynamic>, double>>[];
  for (final m in candidates.values) {
    final id = (m['id'] as num).toInt();
    final key = '${type}_$id';
    if (exclude.contains(key)) continue;
    if (!includeSaved && saved.contains(key)) continue;
    if ((m['poster_path'] ?? '').toString().isEmpty) continue;
    final vote = ((m['vote_average'] as num?) ?? 0).toDouble();
    final votes = ((m['vote_count'] as num?) ?? 0).toInt();
    if (minRating > 0 && vote < minRating) continue;
    final gids = ((m['genre_ids'] as List?) ?? const [])
        .map((e) => (e as num).toInt())
        .toSet();
    final selHits = gids.intersection(selected).length;
    if (selected.isNotEmpty && selHits == 0 && !fromSeed.containsKey(id))
      continue;
    final moodHits = gids.intersection(moodIds).length;
    var aff = 0;
    for (final g in gids) {
      aff += affinity[g] ?? 0;
    }
    final pop = log(((m['popularity'] as num?) ?? 1).toDouble() + 1);
    var score = selHits * 3.0 +
        moodHits * 2.0 +
        min(aff, 6) * 0.8 +
        vote * 0.6 +
        pop * 0.5 +
        (fromSeed.containsKey(id) ? 3.0 : 0) +
        (votes > 1000 ? 0.5 : 0);
    if (surprise) score += rng.nextDouble() * 4;
    scored.add(MapEntry(m, score));
  }
  scored.sort((a, b) => b.value.compareTo(a.value));
  final top = scored.take(14).toList();
  if (top.isEmpty) return [];

  // 6) Real details (runtime, genre names) + reasons.
  final details =
      await Future.wait(top.map((e) => _tmdb('/$type/${e.key['id']}', {})));
  final out = <PickItemStruct>[];
  for (var i = 0; i < top.length && out.length < 10; i++) {
    final m = top[i].key;
    final d = details[i];
    final id = (m['id'] as num).toInt();
    var runtime = 0;
    if (d != null) {
      if (isTv) {
        final eps = d['episode_run_time'] as List?;
        runtime = (eps != null && eps.isNotEmpty)
            ? (eps.first as num).toInt()
            : (((d['last_episode_to_air'] as Map?)?['runtime'] as num?)
                    ?.toInt() ??
                (((d['next_episode_to_air'] as Map?)?['runtime'] as num?)
                        ?.toInt() ??
                    0));
      } else {
        runtime = (d['runtime'] as num?)?.toInt() ?? 0;
      }
    }
    if (runtimeCap > 0 && runtime > runtimeCap) continue;
    final genreNames = d == null
        ? ''
        : ((d['genres'] as List?) ?? const [])
            .map((g) => (g as Map)['name'].toString())
            .take(3)
            .join(', ');
    final title = ((isTv ? m['name'] : m['title']) ?? '').toString();
    final date =
        ((isTv ? m['first_air_date'] : m['release_date']) ?? '').toString();
    final vote = ((m['vote_average'] as num?) ?? 0).toDouble();
    final votes = ((m['vote_count'] as num?) ?? 0).toInt();
    final gids = ((m['genre_ids'] as List?) ?? const [])
        .map((e) => (e as num).toInt())
        .toSet();

    final reasons = <String>[];
    if (fromSeed.containsKey(id))
      reasons.add('Because you liked ${fromSeed[id]}');
    final selNames = genres.where((g) {
      final ids = _genreIds[g];
      return ids != null && gids.contains(ids[idx]);
    }).toList();
    if (selNames.isNotEmpty) reasons.add('Matches ${selNames.join(' & ')}');
    if (mood.isNotEmpty && gids.intersection(moodIds).isNotEmpty) {
      reasons.add('Fits your ${mood.toLowerCase()} mood');
    }
    var aff = 0;
    for (final g in gids) {
      aff += affinity[g] ?? 0;
    }
    if (aff >= 2 && !fromSeed.containsKey(id))
      reasons.add('Similar to titles you love');
    if (runtimeCap > 0 && runtime > 0) {
      reasons.add(isTv
          ? '${runtime}m episodes'
          : 'Fits your time (${runtime >= 60 ? '${runtime ~/ 60}h ${runtime % 60}m' : '${runtime}m'})');
    }
    if (vote >= 7.5 && votes >= 500) {
      reasons
          .add('Rated ${vote.toStringAsFixed(1)} by ${_compact(votes)} people');
    }
    if (reasons.isEmpty) {
      reasons.add(
          surprise ? 'A surprise pick' : 'Popular and well rated right now');
    }

    out.add(PickItemStruct(
      tmdbId: id,
      mediaType: type,
      mediaKey: '${type}_$id',
      title: title,
      posterPath: (m['poster_path'] ?? '').toString(),
      year: date.length >= 4 ? date.substring(0, 4) : '',
      rating: vote,
      voteCount: votes,
      genres: genreNames,
      runtime: runtime,
      reason: reasons.take(2).join(' · '),
      score: top[i].value,
    ));
  }
  return out;
}
