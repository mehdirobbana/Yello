// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct PickItem
class PickItemStruct extends FFFirebaseStruct {
  PickItemStruct({
    /// PickItem.tmdbId
    int? tmdbId,

    /// PickItem.mediaType
    String? mediaType,

    /// PickItem.mediaKey
    String? mediaKey,

    /// PickItem.title
    String? title,

    /// PickItem.posterPath
    String? posterPath,

    /// PickItem.year
    String? year,

    /// PickItem.rating
    double? rating,

    /// PickItem.voteCount
    int? voteCount,

    /// PickItem.genres
    String? genres,

    /// PickItem.runtime
    int? runtime,

    /// PickItem.reason
    String? reason,

    /// PickItem.score
    double? score,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _tmdbId = tmdbId,
        _mediaType = mediaType,
        _mediaKey = mediaKey,
        _title = title,
        _posterPath = posterPath,
        _year = year,
        _rating = rating,
        _voteCount = voteCount,
        _genres = genres,
        _runtime = runtime,
        _reason = reason,
        _score = score,
        super(firestoreUtilData);

  // "tmdbId" field.
  int? _tmdbId;
  int get tmdbId => _tmdbId ?? 0;
  set tmdbId(int? val) => _tmdbId = val;

  void incrementTmdbId(int amount) => tmdbId = tmdbId + amount;

  bool hasTmdbId() => _tmdbId != null;

  // "mediaType" field.
  String? _mediaType;
  String get mediaType => _mediaType ?? '';
  set mediaType(String? val) => _mediaType = val;

  bool hasMediaType() => _mediaType != null;

  // "mediaKey" field.
  String? _mediaKey;
  String get mediaKey => _mediaKey ?? '';
  set mediaKey(String? val) => _mediaKey = val;

  bool hasMediaKey() => _mediaKey != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "posterPath" field.
  String? _posterPath;
  String get posterPath => _posterPath ?? '';
  set posterPath(String? val) => _posterPath = val;

  bool hasPosterPath() => _posterPath != null;

  // "year" field.
  String? _year;
  String get year => _year ?? '';
  set year(String? val) => _year = val;

  bool hasYear() => _year != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  set rating(double? val) => _rating = val;

  void incrementRating(double amount) => rating = rating + amount;

  bool hasRating() => _rating != null;

  // "voteCount" field.
  int? _voteCount;
  int get voteCount => _voteCount ?? 0;
  set voteCount(int? val) => _voteCount = val;

  void incrementVoteCount(int amount) => voteCount = voteCount + amount;

  bool hasVoteCount() => _voteCount != null;

  // "genres" field.
  String? _genres;
  String get genres => _genres ?? '';
  set genres(String? val) => _genres = val;

  bool hasGenres() => _genres != null;

  // "runtime" field.
  int? _runtime;
  int get runtime => _runtime ?? 0;
  set runtime(int? val) => _runtime = val;

  void incrementRuntime(int amount) => runtime = runtime + amount;

  bool hasRuntime() => _runtime != null;

  // "reason" field.
  String? _reason;
  String get reason => _reason ?? '';
  set reason(String? val) => _reason = val;

  bool hasReason() => _reason != null;

  // "score" field.
  double? _score;
  double get score => _score ?? 0.0;
  set score(double? val) => _score = val;

  void incrementScore(double amount) => score = score + amount;

  bool hasScore() => _score != null;

  static PickItemStruct fromMap(Map<String, dynamic> data) => PickItemStruct(
        tmdbId: castToType<int>(data['tmdbId']),
        mediaType: data['mediaType'] as String?,
        mediaKey: data['mediaKey'] as String?,
        title: data['title'] as String?,
        posterPath: data['posterPath'] as String?,
        year: data['year'] as String?,
        rating: castToType<double>(data['rating']),
        voteCount: castToType<int>(data['voteCount']),
        genres: data['genres'] as String?,
        runtime: castToType<int>(data['runtime']),
        reason: data['reason'] as String?,
        score: castToType<double>(data['score']),
      );

  static PickItemStruct? maybeFromMap(dynamic data) =>
      data is Map ? PickItemStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'tmdbId': _tmdbId,
        'mediaType': _mediaType,
        'mediaKey': _mediaKey,
        'title': _title,
        'posterPath': _posterPath,
        'year': _year,
        'rating': _rating,
        'voteCount': _voteCount,
        'genres': _genres,
        'runtime': _runtime,
        'reason': _reason,
        'score': _score,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'tmdbId': serializeParam(
          _tmdbId,
          ParamType.int,
        ),
        'mediaType': serializeParam(
          _mediaType,
          ParamType.String,
        ),
        'mediaKey': serializeParam(
          _mediaKey,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'posterPath': serializeParam(
          _posterPath,
          ParamType.String,
        ),
        'year': serializeParam(
          _year,
          ParamType.String,
        ),
        'rating': serializeParam(
          _rating,
          ParamType.double,
        ),
        'voteCount': serializeParam(
          _voteCount,
          ParamType.int,
        ),
        'genres': serializeParam(
          _genres,
          ParamType.String,
        ),
        'runtime': serializeParam(
          _runtime,
          ParamType.int,
        ),
        'reason': serializeParam(
          _reason,
          ParamType.String,
        ),
        'score': serializeParam(
          _score,
          ParamType.double,
        ),
      }.withoutNulls;

  static PickItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      PickItemStruct(
        tmdbId: deserializeParam(
          data['tmdbId'],
          ParamType.int,
          false,
        ),
        mediaType: deserializeParam(
          data['mediaType'],
          ParamType.String,
          false,
        ),
        mediaKey: deserializeParam(
          data['mediaKey'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        posterPath: deserializeParam(
          data['posterPath'],
          ParamType.String,
          false,
        ),
        year: deserializeParam(
          data['year'],
          ParamType.String,
          false,
        ),
        rating: deserializeParam(
          data['rating'],
          ParamType.double,
          false,
        ),
        voteCount: deserializeParam(
          data['voteCount'],
          ParamType.int,
          false,
        ),
        genres: deserializeParam(
          data['genres'],
          ParamType.String,
          false,
        ),
        runtime: deserializeParam(
          data['runtime'],
          ParamType.int,
          false,
        ),
        reason: deserializeParam(
          data['reason'],
          ParamType.String,
          false,
        ),
        score: deserializeParam(
          data['score'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'PickItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PickItemStruct &&
        tmdbId == other.tmdbId &&
        mediaType == other.mediaType &&
        mediaKey == other.mediaKey &&
        title == other.title &&
        posterPath == other.posterPath &&
        year == other.year &&
        rating == other.rating &&
        voteCount == other.voteCount &&
        genres == other.genres &&
        runtime == other.runtime &&
        reason == other.reason &&
        score == other.score;
  }

  @override
  int get hashCode => const ListEquality().hash([
        tmdbId,
        mediaType,
        mediaKey,
        title,
        posterPath,
        year,
        rating,
        voteCount,
        genres,
        runtime,
        reason,
        score
      ]);
}

PickItemStruct createPickItemStruct({
  int? tmdbId,
  String? mediaType,
  String? mediaKey,
  String? title,
  String? posterPath,
  String? year,
  double? rating,
  int? voteCount,
  String? genres,
  int? runtime,
  String? reason,
  double? score,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PickItemStruct(
      tmdbId: tmdbId,
      mediaType: mediaType,
      mediaKey: mediaKey,
      title: title,
      posterPath: posterPath,
      year: year,
      rating: rating,
      voteCount: voteCount,
      genres: genres,
      runtime: runtime,
      reason: reason,
      score: score,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PickItemStruct? updatePickItemStruct(
  PickItemStruct? pickItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    pickItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPickItemStructData(
  Map<String, dynamic> firestoreData,
  PickItemStruct? pickItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (pickItem == null) {
    return;
  }
  if (pickItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && pickItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final pickItemData = getPickItemFirestoreData(pickItem, forFieldValue);
  final nestedData = pickItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = pickItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPickItemFirestoreData(
  PickItemStruct? pickItem, [
  bool forFieldValue = false,
]) {
  if (pickItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(pickItem.toMap());

  // Add any Firestore field values
  mapToFirestore(pickItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPickItemListFirestoreData(
  List<PickItemStruct>? pickItems,
) =>
    pickItems?.map((e) => getPickItemFirestoreData(e, true)).toList() ?? [];
