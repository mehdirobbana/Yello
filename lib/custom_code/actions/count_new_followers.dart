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

Future<int> countNewFollowers() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) {
    return 0;
  }
  try {
    final db = FirebaseFirestore.instance;
    final me = await db
        .collection('users')
        .doc(uid)
        .get()
        .timeout(const Duration(seconds: 10));
    final seenRaw = me.data()?['notificationsSeenAt'];
    final seen = seenRaw is Timestamp ? seenRaw.toDate() : null;
    final follows = await db
        .collection('follows')
        .where('followingId', isEqualTo: uid)
        .limit(500)
        .get()
        .timeout(const Duration(seconds: 10));
    return follows.docs.where((doc) {
      final created = doc.data()['createdAt'];
      if (created is! Timestamp) {
        return false;
      }
      return seen == null || created.toDate().isAfter(seen);
    }).length;
  } catch (_) {
    return 0;
  }
}
