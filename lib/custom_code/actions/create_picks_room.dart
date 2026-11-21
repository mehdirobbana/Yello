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
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Creates a Movie Match room whose deck is the given movie ids.
/// Returns the 6-digit room code, or 'error:<message>'.
Future<String> createPicksRoom(List<int>? movieIds) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return 'error:Please log in first.';
  final deck = <int>{...?movieIds?.where((id) => id > 0)}.take(20).toList();
  if (deck.length < 3) return 'error:Get at least 3 movie picks first.';
  final rooms = FirebaseFirestore.instance.collection('rooms');
  final rng = Random.secure();
  try {
    for (var attempt = 0; attempt < 5; attempt++) {
      final code = (100000 + rng.nextInt(900000)).toString();
      final taken = await rooms
          .where('code', isEqualTo: code)
          .limit(1)
          .get()
          .timeout(const Duration(seconds: 10));
      if (taken.docs.isNotEmpty) continue;
      await rooms.add({
        'code': code,
        'hostId': uid,
        'status': 'waiting',
        'round': 1,
        'matchedMovieId': 0,
        'createdAt': Timestamp.now(),
        'memberIds': [uid],
        'invitedIds': <String>[],
        'deckMovieIds': deck,
      }).timeout(const Duration(seconds: 10));
      return code;
    }
    return "error:Couldn't create a room code. Please try again.";
  } on TimeoutException {
    return 'error:Connection timed out. Please try again.';
  } catch (_) {
    return "error:Couldn't create the room. Please try again.";
  }
}
