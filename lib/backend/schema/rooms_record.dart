import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL collection rooms
class RoomsRecord extends FirestoreRecord {
  RoomsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "code" field.
  String? _code;
  String get code => _code ?? '';
  bool hasCode() => _code != null;

  // "hostId" field.
  String? _hostId;
  String get hostId => _hostId ?? '';
  bool hasHostId() => _hostId != null;

  // "memberIds" field.
  List<String>? _memberIds;
  List<String> get memberIds => _memberIds ?? const [];
  bool hasMemberIds() => _memberIds != null;

  // "invitedIds" field.
  List<String>? _invitedIds;
  List<String> get invitedIds => _invitedIds ?? const [];
  bool hasInvitedIds() => _invitedIds != null;

  // "deckMovieIds" field.
  List<int>? _deckMovieIds;
  List<int> get deckMovieIds => _deckMovieIds ?? const [];
  bool hasDeckMovieIds() => _deckMovieIds != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "round" field.
  int? _round;
  int get round => _round ?? 0;
  bool hasRound() => _round != null;

  // "matchedMovieId" field.
  int? _matchedMovieId;
  int get matchedMovieId => _matchedMovieId ?? 0;
  bool hasMatchedMovieId() => _matchedMovieId != null;

  // "matchedTitle" field.
  String? _matchedTitle;
  String get matchedTitle => _matchedTitle ?? '';
  bool hasMatchedTitle() => _matchedTitle != null;

  // "matchedPosterPath" field.
  String? _matchedPosterPath;
  String get matchedPosterPath => _matchedPosterPath ?? '';
  bool hasMatchedPosterPath() => _matchedPosterPath != null;

  // "matchedBackdropPath" field.
  String? _matchedBackdropPath;
  String get matchedBackdropPath => _matchedBackdropPath ?? '';
  bool hasMatchedBackdropPath() => _matchedBackdropPath != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _code = snapshotData['code'] as String?;
    _hostId = snapshotData['hostId'] as String?;
    _memberIds = getDataList(snapshotData['memberIds']);
    _invitedIds = getDataList(snapshotData['invitedIds']);
    _deckMovieIds = getDataList(snapshotData['deckMovieIds']);
    _status = snapshotData['status'] as String?;
    _round = castToType<int>(snapshotData['round']);
    _matchedMovieId = castToType<int>(snapshotData['matchedMovieId']);
    _matchedTitle = snapshotData['matchedTitle'] as String?;
    _matchedPosterPath = snapshotData['matchedPosterPath'] as String?;
    _matchedBackdropPath = snapshotData['matchedBackdropPath'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('rooms');

  static Stream<RoomsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RoomsRecord.fromSnapshot(s));

  static Future<RoomsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RoomsRecord.fromSnapshot(s));

  static RoomsRecord fromSnapshot(DocumentSnapshot snapshot) => RoomsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RoomsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RoomsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RoomsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RoomsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createRoomsRecordData({
  String? code,
  String? hostId,
  String? status,
  int? round,
  int? matchedMovieId,
  String? matchedTitle,
  String? matchedPosterPath,
  String? matchedBackdropPath,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'code': code,
      'hostId': hostId,
      'status': status,
      'round': round,
      'matchedMovieId': matchedMovieId,
      'matchedTitle': matchedTitle,
      'matchedPosterPath': matchedPosterPath,
      'matchedBackdropPath': matchedBackdropPath,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class RoomsRecordDocumentEquality implements Equality<RoomsRecord> {
  const RoomsRecordDocumentEquality();

  @override
  bool equals(RoomsRecord? e1, RoomsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.code == e2?.code &&
        e1?.hostId == e2?.hostId &&
        listEquality.equals(e1?.memberIds, e2?.memberIds) &&
        listEquality.equals(e1?.invitedIds, e2?.invitedIds) &&
        listEquality.equals(e1?.deckMovieIds, e2?.deckMovieIds) &&
        e1?.status == e2?.status &&
        e1?.round == e2?.round &&
        e1?.matchedMovieId == e2?.matchedMovieId &&
        e1?.matchedTitle == e2?.matchedTitle &&
        e1?.matchedPosterPath == e2?.matchedPosterPath &&
        e1?.matchedBackdropPath == e2?.matchedBackdropPath &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(RoomsRecord? e) => const ListEquality().hash([
        e?.code,
        e?.hostId,
        const ListEquality().hash(e?.memberIds),
        const ListEquality().hash(e?.invitedIds),
        const ListEquality().hash(e?.deckMovieIds),
        e?.status,
        e?.round,
        e?.matchedMovieId,
        e?.matchedTitle,
        e?.matchedPosterPath,
        e?.matchedBackdropPath,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is RoomsRecord;
}
