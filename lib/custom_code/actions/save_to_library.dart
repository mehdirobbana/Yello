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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Adds a title to favorites or watchlist once. Returns 'added', 'exists' or
/// 'error:<message>'.
Future<String> saveToLibrary(
  String? collection,
  int? tmdbId,
  String? mediaType,
  String? title,
  String? posterPath,
  double? voteAverage,
) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return 'error:Please log in first.';
  final col = collection ?? '';
  if (col != 'favorites' && col != 'watchlist') return 'error:Unknown list.';
  final type = mediaType == 'tv' ? 'tv' : 'movie';
  final id = tmdbId ?? 0;
  if (id <= 0) return 'error:Unknown title.';
  final key = '${type}_$id';
  try {
    final ref = FirebaseFirestore.instance.collection(col);
    final existing = await ref
        .where('userId', isEqualTo: uid)
        .where('mediaKey', isEqualTo: key)
        .limit(1)
        .get()
        .timeout(const Duration(seconds: 12));
    if (existing.docs.isNotEmpty) return 'exists';
    await ref.add({
      'userId': uid,
      'tmdbId': id,
      'mediaType': type,
      'mediaKey': key,
      'title': title ?? '',
      'posterPath': posterPath ?? '',
      'voteAverage': voteAverage ?? 0,
      'createdAt': FieldValue.serverTimestamp(),
    }).timeout(const Duration(seconds: 12));
    return 'added';
  } on TimeoutException {
    return 'error:Connection timed out. Please try again.';
  } catch (_) {
    return "error:Couldn't save. Please try again.";
  }
}
