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

import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> getYelloRatingCount(String mediaKey) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('reviews')
        .where('mediaKey', isEqualTo: mediaKey)
        .count()
        .get()
        .timeout(const Duration(seconds: 15));
    return snapshot.count ?? 0;
  } catch (_) {
    return -1;
  }
}
