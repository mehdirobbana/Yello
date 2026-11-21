import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL collection reviewLikes
class ReviewLikesRecord extends FirestoreRecord {
  ReviewLikesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "reviewId" field.
  String? _reviewId;
  String get reviewId => _reviewId ?? '';
  bool hasReviewId() => _reviewId != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _userId = snapshotData['userId'] as String?;
    _reviewId = snapshotData['reviewId'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reviewLikes');

  static Stream<ReviewLikesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReviewLikesRecord.fromSnapshot(s));

  static Future<ReviewLikesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReviewLikesRecord.fromSnapshot(s));

  static ReviewLikesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReviewLikesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReviewLikesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReviewLikesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReviewLikesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReviewLikesRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createReviewLikesRecordData({
  String? userId,
  String? reviewId,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userId': userId,
      'reviewId': reviewId,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReviewLikesRecordDocumentEquality implements Equality<ReviewLikesRecord> {
  const ReviewLikesRecordDocumentEquality();

  @override
  bool equals(ReviewLikesRecord? e1, ReviewLikesRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.reviewId == e2?.reviewId &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(ReviewLikesRecord? e) =>
      const ListEquality().hash([e?.userId, e?.reviewId, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is ReviewLikesRecord;
}
