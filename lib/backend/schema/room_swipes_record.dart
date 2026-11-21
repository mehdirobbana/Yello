import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL collection roomSwipes
class RoomSwipesRecord extends FirestoreRecord {
  RoomSwipesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "roomId" field.
  String? _roomId;
  String get roomId => _roomId ?? '';
  bool hasRoomId() => _roomId != null;

  // "round" field.
  int? _round;
  int get round => _round ?? 0;
  bool hasRound() => _round != null;

  // "movieId" field.
  int? _movieId;
  int get movieId => _movieId ?? 0;
  bool hasMovieId() => _movieId != null;

  // "liked" field.
  bool? _liked;
  bool get liked => _liked ?? false;
  bool hasLiked() => _liked != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _userId = snapshotData['userId'] as String?;
    _roomId = snapshotData['roomId'] as String?;
    _round = castToType<int>(snapshotData['round']);
    _movieId = castToType<int>(snapshotData['movieId']);
    _liked = snapshotData['liked'] as bool?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('roomSwipes');

  static Stream<RoomSwipesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RoomSwipesRecord.fromSnapshot(s));

  static Future<RoomSwipesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RoomSwipesRecord.fromSnapshot(s));

  static RoomSwipesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RoomSwipesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RoomSwipesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RoomSwipesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RoomSwipesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RoomSwipesRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createRoomSwipesRecordData({
  String? userId,
  String? roomId,
  int? round,
  int? movieId,
  bool? liked,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userId': userId,
      'roomId': roomId,
      'round': round,
      'movieId': movieId,
      'liked': liked,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class RoomSwipesRecordDocumentEquality implements Equality<RoomSwipesRecord> {
  const RoomSwipesRecordDocumentEquality();

  @override
  bool equals(RoomSwipesRecord? e1, RoomSwipesRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.roomId == e2?.roomId &&
        e1?.round == e2?.round &&
        e1?.movieId == e2?.movieId &&
        e1?.liked == e2?.liked &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(RoomSwipesRecord? e) => const ListEquality().hash(
      [e?.userId, e?.roomId, e?.round, e?.movieId, e?.liked, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is RoomSwipesRecord;
}
