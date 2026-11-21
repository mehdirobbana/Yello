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

import 'package:http/http.dart' as http;

import '/app_constants.dart';
import '/backend/schema/structs/index.dart';

// Genre name -> [movie genre id, tv genre id].
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
};

/// One page of TMDB results honoring every filter. Returns page = 0 on error.
Future<MediaListResponseStruct> fetchTitles(
  String? queryArg,
  String? mediaTypeArg,
  String? genreArg,
  int? yearArg,
  double? minRatingArg,
  String? sortByArg,
  int? pageArg,
) async {
  final query = queryArg ?? '';
  final mediaType = mediaTypeArg ?? 'movie';
  final genre = genreArg ?? 'All';
  final year = yearArg ?? 0;
  final minRating = minRatingArg ?? 0;
  final sortBy = sortByArg ?? 'popular';
  final page = pageArg ?? 1;
  final isTv = mediaType == 'tv';
  final q = query.trim();
  final genreId = _genreIds[genre]?[isTv ? 1 : 0];
  final params = <String, String>{
    'api_key': FFAppConstants.tmdbApiKey,
    'page': '${page < 1 ? 1 : page}',
    'include_adult': 'false',
    'language': 'en-US',
  };
  final Uri uri;
  if (q.isEmpty) {
    // Discover: every filter and sort is applied by TMDB across all results.
    final today = DateTime.now().toIso8601String().substring(0, 10);
    params['sort_by'] = sortBy == 'rating'
        ? 'vote_average.desc'
        : sortBy == 'newest'
            ? (isTv ? 'first_air_date.desc' : 'primary_release_date.desc')
            : 'popularity.desc';
    if (sortBy == 'rating') params['vote_count.gte'] = '300';
    if (sortBy == 'newest') {
      params[isTv ? 'first_air_date.lte' : 'primary_release_date.lte'] = today;
      params['vote_count.gte'] = '20';
    }
    if (genreId != null) params['with_genres'] = '$genreId';
    if (year > 0) {
      params[isTv ? 'first_air_date_year' : 'primary_release_year'] = '$year';
    }
    if (minRating > 0) {
      params['vote_average.gte'] = minRating.toStringAsFixed(1);
      params.putIfAbsent('vote_count.gte', () => '50');
    }
    uri = Uri.https(
        'api.themoviedb.org', '/3/discover/${isTv ? 'tv' : 'movie'}', params);
  } else {
    // Search by title (+ year on TMDB); genre/rating/sort applied per page.
    params['query'] = q;
    if (year > 0) {
      params[isTv ? 'first_air_date_year' : 'primary_release_year'] = '$year';
    }
    uri = Uri.https(
        'api.themoviedb.org', '/3/search/${isTv ? 'tv' : 'movie'}', params);
  }

  final failed = MediaListResponseStruct(
      page: 0, results: [], totalPages: 0, totalResults: 0);
  try {
    final res = await http.get(uri).timeout(const Duration(seconds: 15));
    if (res.statusCode != 200) {
      return failed;
    }
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    var items = (json['results'] as List? ?? const [])
        .whereType<Map<String, dynamic>>()
        .toList();
    if (q.isNotEmpty) {
      if (genreId != null) {
        items = items
            .where(
                (m) => (m['genre_ids'] as List? ?? const []).contains(genreId))
            .toList();
      }
      if (minRating > 0) {
        items = items
            .where((m) => ((m['vote_average'] as num?) ?? 0) >= minRating)
            .toList();
      }
      String date(Map<String, dynamic> m) =>
          ((isTv ? m['first_air_date'] : m['release_date']) as String?) ?? '';
      if (sortBy == 'rating') {
        items.sort((a, b) => ((b['vote_average'] as num?) ?? 0)
            .compareTo((a['vote_average'] as num?) ?? 0));
      } else if (sortBy == 'newest') {
        items.sort((a, b) => date(b).compareTo(date(a)));
      }
    }
    return MediaListResponseStruct(
      page: (json['page'] as num?)?.toInt() ?? page,
      results: items.map((m) => MediaItemStruct.fromMap(m)).toList(),
      totalPages: (json['total_pages'] as num?)?.toInt() ?? 0,
      totalResults: (json['total_results'] as num?)?.toInt() ?? 0,
    );
  } catch (_) {
    return failed;
  }
}
