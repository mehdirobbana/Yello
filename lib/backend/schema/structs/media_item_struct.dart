// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct MediaItem
class MediaItemStruct extends FFFirebaseStruct {
  MediaItemStruct({
    /// MediaItem.id
    int? id,

    /// MediaItem.title
    String? title,

    /// MediaItem.name
    String? name,

    /// MediaItem.overview
    String? overview,

    /// MediaItem.poster_path
    String? posterPath,

    /// MediaItem.backdrop_path
    String? backdropPath,

    /// MediaItem.vote_average
    double? voteAverage,

    /// MediaItem.release_date
    String? releaseDate,

    /// MediaItem.first_air_date
    String? firstAirDate,

    /// MediaItem.media_type
    String? mediaType,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _title = title,
        _name = name,
        _overview = overview,
        _posterPath = posterPath,
        _backdropPath = backdropPath,
        _voteAverage = voteAverage,
        _releaseDate = releaseDate,
        _firstAirDate = firstAirDate,
        _mediaType = mediaType,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "overview" field.
  String? _overview;
  String get overview => _overview ?? '';
  set overview(String? val) => _overview = val;

  bool hasOverview() => _overview != null;

  // "poster_path" field.
  String? _posterPath;
  String get posterPath => _posterPath ?? '';
  set posterPath(String? val) => _posterPath = val;

  bool hasPosterPath() => _posterPath != null;

  // "backdrop_path" field.
  String? _backdropPath;
  String get backdropPath => _backdropPath ?? '';
  set backdropPath(String? val) => _backdropPath = val;

  bool hasBackdropPath() => _backdropPath != null;

  // "vote_average" field.
  double? _voteAverage;
  double get voteAverage => _voteAverage ?? 0.0;
  set voteAverage(double? val) => _voteAverage = val;

  void incrementVoteAverage(double amount) =>
      voteAverage = voteAverage + amount;

  bool hasVoteAverage() => _voteAverage != null;

  // "release_date" field.
  String? _releaseDate;
  String get releaseDate => _releaseDate ?? '';
  set releaseDate(String? val) => _releaseDate = val;

  bool hasReleaseDate() => _releaseDate != null;

  // "first_air_date" field.
  String? _firstAirDate;
  String get firstAirDate => _firstAirDate ?? '';
  set firstAirDate(String? val) => _firstAirDate = val;

  bool hasFirstAirDate() => _firstAirDate != null;

  // "media_type" field.
  String? _mediaType;
  String get mediaType => _mediaType ?? '';
  set mediaType(String? val) => _mediaType = val;

  bool hasMediaType() => _mediaType != null;

  static MediaItemStruct fromMap(Map<String, dynamic> data) => MediaItemStruct(
        id: castToType<int>(data['id']),
        title: data['title'] as String?,
        name: data['name'] as String?,
        overview: data['overview'] as String?,
        posterPath: data['poster_path'] as String?,
        backdropPath: data['backdrop_path'] as String?,
        voteAverage: castToType<double>(data['vote_average']),
        releaseDate: data['release_date'] as String?,
        firstAirDate: data['first_air_date'] as String?,
        mediaType: data['media_type'] as String?,
      );

  static MediaItemStruct? maybeFromMap(dynamic data) => data is Map
      ? MediaItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'name': _name,
        'overview': _overview,
        'poster_path': _posterPath,
        'backdrop_path': _backdropPath,
        'vote_average': _voteAverage,
        'release_date': _releaseDate,
        'first_air_date': _firstAirDate,
        'media_type': _mediaType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'overview': serializeParam(
          _overview,
          ParamType.String,
        ),
        'poster_path': serializeParam(
          _posterPath,
          ParamType.String,
        ),
        'backdrop_path': serializeParam(
          _backdropPath,
          ParamType.String,
        ),
        'vote_average': serializeParam(
          _voteAverage,
          ParamType.double,
        ),
        'release_date': serializeParam(
          _releaseDate,
          ParamType.String,
        ),
        'first_air_date': serializeParam(
          _firstAirDate,
          ParamType.String,
        ),
        'media_type': serializeParam(
          _mediaType,
          ParamType.String,
        ),
      }.withoutNulls;

  static MediaItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      MediaItemStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        overview: deserializeParam(
          data['overview'],
          ParamType.String,
          false,
        ),
        posterPath: deserializeParam(
          data['poster_path'],
          ParamType.String,
          false,
        ),
        backdropPath: deserializeParam(
          data['backdrop_path'],
          ParamType.String,
          false,
        ),
        voteAverage: deserializeParam(
          data['vote_average'],
          ParamType.double,
          false,
        ),
        releaseDate: deserializeParam(
          data['release_date'],
          ParamType.String,
          false,
        ),
        firstAirDate: deserializeParam(
          data['first_air_date'],
          ParamType.String,
          false,
        ),
        mediaType: deserializeParam(
          data['media_type'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MediaItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MediaItemStruct &&
        id == other.id &&
        title == other.title &&
        name == other.name &&
        overview == other.overview &&
        posterPath == other.posterPath &&
        backdropPath == other.backdropPath &&
        voteAverage == other.voteAverage &&
        releaseDate == other.releaseDate &&
        firstAirDate == other.firstAirDate &&
        mediaType == other.mediaType;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        title,
        name,
        overview,
        posterPath,
        backdropPath,
        voteAverage,
        releaseDate,
        firstAirDate,
        mediaType
      ]);
}

MediaItemStruct createMediaItemStruct({
  int? id,
  String? title,
  String? name,
  String? overview,
  String? posterPath,
  String? backdropPath,
  double? voteAverage,
  String? releaseDate,
  String? firstAirDate,
  String? mediaType,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MediaItemStruct(
      id: id,
      title: title,
      name: name,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      firstAirDate: firstAirDate,
      mediaType: mediaType,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MediaItemStruct? updateMediaItemStruct(
  MediaItemStruct? mediaItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    mediaItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMediaItemStructData(
  Map<String, dynamic> firestoreData,
  MediaItemStruct? mediaItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (mediaItem == null) {
    return;
  }
  if (mediaItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && mediaItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final mediaItemData = getMediaItemFirestoreData(mediaItem, forFieldValue);
  final nestedData = mediaItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = mediaItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMediaItemFirestoreData(
  MediaItemStruct? mediaItem, [
  bool forFieldValue = false,
]) {
  if (mediaItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(mediaItem.toMap());

  // Add any Firestore field values
  mapToFirestore(mediaItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMediaItemListFirestoreData(
  List<MediaItemStruct>? mediaItems,
) =>
    mediaItems?.map((e) => getMediaItemFirestoreData(e, true)).toList() ?? [];
