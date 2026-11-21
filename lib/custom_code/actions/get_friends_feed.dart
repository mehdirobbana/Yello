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

import 'package:firebase_auth/firebase_auth.dart';

import '/backend/backend.dart';

Future<List<ReviewsRecord>> getFriendsFeed() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) {
    return [];
  }
  const timeout = Duration(seconds: 15);
  try {
    final follows = await FollowsRecord.collection
        .where('followerId', isEqualTo: uid)
        .limit(200)
        .get()
        .timeout(timeout);
    final ids = follows.docs
        .map((d) => FollowsRecord.fromSnapshot(d).followingId)
        .where((id) => id.isNotEmpty)
        .toSet()
        .toList();
    if (ids.isEmpty) {
      return [];
    }
    final reviews = <ReviewsRecord>[];
    // Firestore "in" queries accept at most 30 values per query.
    for (var i = 0; i < ids.length; i += 30) {
      final chunk = ids.sublist(i, i + 30 > ids.length ? ids.length : i + 30);
      final snap = await ReviewsRecord.collection
          .where('userId', whereIn: chunk)
          .limit(100)
          .get()
          .timeout(timeout);
      reviews.addAll(snap.docs.map((d) => ReviewsRecord.fromSnapshot(d)));
    }
    // Newest first (sorted here, so no composite index is needed).
    reviews.sort((a, b) {
      final at = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bt = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bt.compareTo(at);
    });
    return reviews.take(50).toList();
  } catch (_) {
    return [];
  }
}
