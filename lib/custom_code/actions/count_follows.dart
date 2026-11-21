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

Future<int> countFollows(String field) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) {
    return 0;
  }
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('follows')
        .where(field, isEqualTo: uid)
        .count()
        .get()
        .timeout(const Duration(seconds: 15));
    return snapshot.count ?? 0;
  } catch (_) {
    return 0;
  }
}
