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

Future<String> deleteMyReview(int tmdbId, String mediaType) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return 'Please log in first.';
  }
  final mediaKey = '${mediaType}_$tmdbId';
  const timeout = Duration(seconds: 15);
  try {
    final mine = await FirebaseFirestore.instance
        .collection('reviews')
        .where('userId', isEqualTo: user.uid)
        .where('mediaKey', isEqualTo: mediaKey)
        .get()
        .timeout(timeout);
    for (final doc in mine.docs) {
      await doc.reference.delete().timeout(timeout);
    }
    return '';
  } on TimeoutException {
    return 'The connection timed out. Please try again.';
  } on FirebaseException catch (e) {
    if (e.code == 'unavailable') {
      return 'You seem to be offline. Please try again.';
    }
    return 'Could not delete your review (${e.code}).';
  } catch (_) {
    return 'Something went wrong. Please try again.';
  }
}
