import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL collection follows
class FollowsRecord extends FirestoreRecord {
  FollowsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "followerId" field.
  String? _followerId;
  String get followerId => _followerId ?? '';
  bool hasFollowerId() => _followerId != null;

  // "followingId" field.
  String? _followingId;
  String get followingId => _followingId ?? '';
  bool hasFollowingId() => _followingId != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _followerId = snapshotData['followerId'] as String?;
    _followingId = snapshotData['followingId'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('follows');

  static Stream<FollowsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FollowsRecord.fromSnapshot(s));

  static Future<FollowsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FollowsRecord.fromSnapshot(s));

  static FollowsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FollowsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FollowsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FollowsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FollowsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FollowsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createFollowsRecordData({
  String? followerId,
  String? followingId,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'followerId': followerId,
      'followingId': followingId,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class FollowsRecordDocumentEquality implements Equality<FollowsRecord> {
  const FollowsRecordDocumentEquality();

  @override
  bool equals(FollowsRecord? e1, FollowsRecord? e2) {
    return e1?.followerId == e2?.followerId &&
        e1?.followingId == e2?.followingId &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(FollowsRecord? e) =>
      const ListEquality().hash([e?.followerId, e?.followingId, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is FollowsRecord;
}
