import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// One review per user and title: 0.5–5 star rating, optional comment (max
/// 1000), spoiler flag.
class ReviewsRecord extends FirestoreRecord {
  ReviewsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "userName" field.
  String? _userName;
  String get userName => _userName ?? '';
  bool hasUserName() => _userName != null;

  // "tmdbId" field.
  int? _tmdbId;
  int get tmdbId => _tmdbId ?? 0;
  bool hasTmdbId() => _tmdbId != null;

  // "mediaType" field.
  String? _mediaType;
  String get mediaType => _mediaType ?? '';
  bool hasMediaType() => _mediaType != null;

  // "mediaKey" field.
  String? _mediaKey;
  String get mediaKey => _mediaKey ?? '';
  bool hasMediaKey() => _mediaKey != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "posterPath" field.
  String? _posterPath;
  String get posterPath => _posterPath ?? '';
  bool hasPosterPath() => _posterPath != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  bool hasComment() => _comment != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "containsSpoilers" field.
  bool? _containsSpoilers;
  bool get containsSpoilers => _containsSpoilers ?? false;
  bool hasContainsSpoilers() => _containsSpoilers != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "userPhotoUrl" field.
  String? _userPhotoUrl;
  String get userPhotoUrl => _userPhotoUrl ?? '';
  bool hasUserPhotoUrl() => _userPhotoUrl != null;

  void _initializeFields() {
    _userId = snapshotData['userId'] as String?;
    _userName = snapshotData['userName'] as String?;
    _tmdbId = castToType<int>(snapshotData['tmdbId']);
    _mediaType = snapshotData['mediaType'] as String?;
    _mediaKey = snapshotData['mediaKey'] as String?;
    _title = snapshotData['title'] as String?;
    _posterPath = snapshotData['posterPath'] as String?;
    _rating = castToType<double>(snapshotData['rating']);
    _comment = snapshotData['comment'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _containsSpoilers = snapshotData['containsSpoilers'] as bool?;
    _updatedAt = snapshotData['updatedAt'] as DateTime?;
    _userPhotoUrl = snapshotData['userPhotoUrl'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reviews');

  static Stream<ReviewsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReviewsRecord.fromSnapshot(s));

  static Future<ReviewsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReviewsRecord.fromSnapshot(s));

  static ReviewsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReviewsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReviewsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReviewsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReviewsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReviewsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createReviewsRecordData({
  String? userId,
  String? userName,
  int? tmdbId,
  String? mediaType,
  String? mediaKey,
  String? title,
  String? posterPath,
  double? rating,
  String? comment,
  DateTime? createdAt,
  bool? containsSpoilers,
  DateTime? updatedAt,
  String? userPhotoUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'tmdbId': tmdbId,
      'mediaType': mediaType,
      'mediaKey': mediaKey,
      'title': title,
      'posterPath': posterPath,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt,
      'containsSpoilers': containsSpoilers,
      'updatedAt': updatedAt,
      'userPhotoUrl': userPhotoUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReviewsRecordDocumentEquality implements Equality<ReviewsRecord> {
  const ReviewsRecordDocumentEquality();

  @override
  bool equals(ReviewsRecord? e1, ReviewsRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.userName == e2?.userName &&
        e1?.tmdbId == e2?.tmdbId &&
        e1?.mediaType == e2?.mediaType &&
        e1?.mediaKey == e2?.mediaKey &&
        e1?.title == e2?.title &&
        e1?.posterPath == e2?.posterPath &&
        e1?.rating == e2?.rating &&
        e1?.comment == e2?.comment &&
        e1?.createdAt == e2?.createdAt &&
        e1?.containsSpoilers == e2?.containsSpoilers &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.userPhotoUrl == e2?.userPhotoUrl;
  }

  @override
  int hash(ReviewsRecord? e) => const ListEquality().hash([
        e?.userId,
        e?.userName,
        e?.tmdbId,
        e?.mediaType,
        e?.mediaKey,
        e?.title,
        e?.posterPath,
        e?.rating,
        e?.comment,
        e?.createdAt,
        e?.containsSpoilers,
        e?.updatedAt,
        e?.userPhotoUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is ReviewsRecord;
}
