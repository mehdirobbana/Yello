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

/// Validates a scanned friend QR code.
/// Returns 'ok:<userId>' or 'error:<message for the user>'.
Future<String> resolveFriendQr(String? scanned) async {
  final raw = (scanned ?? '').trim();
  // The scanner returns '-1' (or nothing) when cancelled or when the camera
  // permission was denied.
  if (raw.isEmpty || raw == '-1') {
    return 'error:Scan cancelled. If the camera did not open, allow camera access for Yello in your phone settings.';
  }

  String? userId;
  final uri = Uri.tryParse(raw);
  if (uri != null && uri.queryParameters['userId'] != null) {
    userId = uri.queryParameters['userId'];
  } else if (raw.startsWith('yello:user:')) {
    userId = raw.substring('yello:user:'.length);
  }
  userId = userId?.trim();
  final validId = RegExp(r'^[A-Za-z0-9]{10,64}$');
  if (userId == null || !validId.hasMatch(userId)) {
    return 'error:This is not a Yello friend code.';
  }

  final me = FirebaseAuth.instance.currentUser?.uid;
  if (me == null) {
    return 'error:Please log in first.';
  }
  if (userId == me) {
    return "error:That's your own code";
  }

  try {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .timeout(const Duration(seconds: 10));
    if (!doc.exists) {
      return 'error:This Yello profile no longer exists.';
    }
    return 'ok:$userId';
  } on TimeoutException {
    return "error:Couldn't check this code. Check your connection and try again.";
  } on FirebaseException catch (e) {
    if (e.code == 'permission-denied') {
      return "error:Couldn't open this profile (permission denied).";
    }
    return "error:Couldn't check this code. Check your connection and try again.";
  } catch (_) {
    return "error:Couldn't check this code. Please try again.";
  }
}
