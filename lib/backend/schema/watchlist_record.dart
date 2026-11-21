import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Movies and TV shows a user wants to watch later.
class WatchlistRecord extends FirestoreRecord {
  WatchlistRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

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

  // "voteAverage" field.
  double? _voteAverage;
  double get voteAverage => _voteAverage ?? 0.0;
  bool hasVoteAverage() => _voteAverage != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _userId = snapshotData['userId'] as String?;
    _tmdbId = castToType<int>(snapshotData['tmdbId']);
    _mediaType = snapshotData['mediaType'] as String?;
    _mediaKey = snapshotData['mediaKey'] as String?;
    _title = snapshotData['title'] as String?;
    _posterPath = snapshotData['posterPath'] as String?;
    _voteAverage = castToType<double>(snapshotData['voteAverage']);
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('watchlist');

  static Stream<WatchlistRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WatchlistRecord.fromSnapshot(s));

  static Future<WatchlistRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WatchlistRecord.fromSnapshot(s));

  static WatchlistRecord fromSnapshot(DocumentSnapshot snapshot) =>
      WatchlistRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WatchlistRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WatchlistRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WatchlistRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WatchlistRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createWatchlistRecordData({
  String? userId,
  int? tmdbId,
  String? mediaType,
  String? mediaKey,
  String? title,
  String? posterPath,
  double? voteAverage,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userId': userId,
      'tmdbId': tmdbId,
      'mediaType': mediaType,
      'mediaKey': mediaKey,
      'title': title,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class WatchlistRecordDocumentEquality implements Equality<WatchlistRecord> {
  const WatchlistRecordDocumentEquality();

  @override
  bool equals(WatchlistRecord? e1, WatchlistRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.tmdbId == e2?.tmdbId &&
        e1?.mediaType == e2?.mediaType &&
        e1?.mediaKey == e2?.mediaKey &&
        e1?.title == e2?.title &&
        e1?.posterPath == e2?.posterPath &&
        e1?.voteAverage == e2?.voteAverage &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(WatchlistRecord? e) => const ListEquality().hash([
        e?.userId,
        e?.tmdbId,
        e?.mediaType,
        e?.mediaKey,
        e?.title,
        e?.posterPath,
        e?.voteAverage,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is WatchlistRecord;
}
