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

/// Average star rating of every Yello review for one title.
/// Reads the reviews and averages `rating` here, so no composite index is needed.
/// Returns 0 when nobody rated yet and -1 when the read failed (the screen shows N/A).
Future<double> getYelloAverage(String mediaKey) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('reviews')
        .where('mediaKey', isEqualTo: mediaKey)
        .limit(500)
        .get()
        .timeout(const Duration(seconds: 15));
    var sum = 0.0;
    var count = 0;
    for (final doc in snapshot.docs) {
      final rating = doc.data()['rating'];
      if (rating is num) {
        sum += rating.toDouble();
        count++;
      }
    }
    return count == 0 ? 0.0 : sum / count;
  } catch (_) {
    return -1.0;
  }
}
