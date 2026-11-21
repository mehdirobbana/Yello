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

Future<List<FollowsRecord>> getMyFollowers() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) {
    return [];
  }
  try {
    final snapshot = await FollowsRecord.collection
        .where('followingId', isEqualTo: uid)
        .limit(200)
        .get()
        .timeout(const Duration(seconds: 15));
    final items =
        snapshot.docs.map((d) => FollowsRecord.fromSnapshot(d)).toList();
    // Newest first, sorted here so no composite index is needed.
    items.sort((a, b) {
      final at = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bt = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bt.compareTo(at);
    });
    return items;
  } catch (_) {
    return [];
  }
}
