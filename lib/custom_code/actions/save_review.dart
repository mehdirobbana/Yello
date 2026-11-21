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

Future<String> saveReview(
  int tmdbId,
  String mediaType,
  String title,
  String posterPath,
  double rating,
  String comment,
  bool containsSpoilers,
  String userName,
  String userPhotoUrl,
) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return 'Please log in to rate and review.';
  }
  if (mediaType != 'movie' && mediaType != 'tv') {
    return 'Unknown title type.';
  }
  if (rating < 0.5 ||
      rating > 5 ||
      (rating * 2) != (rating * 2).roundToDouble()) {
    return 'Please choose a rating between 0.5 and 5 stars.';
  }
  final text = comment.trim();
  if (text.length > 1000) {
    return 'Reviews can be at most 1000 characters.';
  }
  final mediaKey = '${mediaType}_$tmdbId';
  final emailName = (user.email ?? '').split('@').first;
  final name = userName.trim().isNotEmpty
      ? userName.trim()
      : (emailName.isNotEmpty ? emailName : 'Yello user');
  var photoUrl = userPhotoUrl;
  if (photoUrl.isEmpty) {
    try {
      final profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .timeout(const Duration(seconds: 10));
      photoUrl = (profile.data()?['photo_url'] as String?) ?? '';
    } catch (_) {
      photoUrl = '';
    }
  }
  if (photoUrl.isEmpty) {
    photoUrl = 'https://api.dicebear.com/9.x/adventurer/png?seed=Felix';
  }
  final reviews = FirebaseFirestore.instance.collection('reviews');
  final data = <String, dynamic>{
    'userId': user.uid,
    'userName': name,
    'userPhotoUrl': photoUrl,
    'tmdbId': tmdbId,
    'mediaType': mediaType,
    'mediaKey': mediaKey,
    'title': title,
    'posterPath': posterPath,
    'rating': rating,
    'comment': text,
    'containsSpoilers': containsSpoilers,
    'updatedAt': FieldValue.serverTimestamp(),
  };
  const timeout = Duration(seconds: 15);
  try {
    final existing = await reviews
        .where('userId', isEqualTo: user.uid)
        .where('mediaKey', isEqualTo: mediaKey)
        .limit(10)
        .get()
        .timeout(timeout);
    if (existing.docs.isNotEmpty) {
      // Update the user's existing review (also covers older documents) and
      // clean up any legacy duplicates.
      await existing.docs.first.reference.update(data).timeout(timeout);
      for (final extra in existing.docs.skip(1)) {
        await extra.reference.delete().timeout(timeout);
      }
    } else {
      // Deterministic id => at most one review per user and title.
      await reviews.doc('${user.uid}_$mediaKey').set({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      }).timeout(timeout);
    }
    return '';
  } on TimeoutException {
    return 'The connection timed out. Please try again.';
  } on FirebaseException catch (e) {
    if (e.code == 'permission-denied') {
      return 'You do not have permission to save this review.';
    }
    if (e.code == 'unavailable') {
      return 'You seem to be offline. Please try again.';
    }
    return 'Could not save your review (${e.code}). Please try again.';
  } catch (_) {
    return 'Something went wrong. Please try again.';
  }
}
