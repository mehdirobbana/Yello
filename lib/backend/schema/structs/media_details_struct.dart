// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct MediaDetails
class MediaDetailsStruct extends FFFirebaseStruct {
  MediaDetailsStruct({
    /// MediaDetails.id
    int? id,

    /// MediaDetails.title
    String? title,

    /// MediaDetails.name
    String? name,

    /// MediaDetails.overview
    String? overview,

    /// MediaDetails.tagline
    String? tagline,

    /// MediaDetails.poster_path
    String? posterPath,

    /// MediaDetails.backdrop_path
    String? backdropPath,

    /// MediaDetails.vote_average
    double? voteAverage,

    /// MediaDetails.vote_count
    int? voteCount,

    /// MediaDetails.release_date
    String? releaseDate,

    /// MediaDetails.first_air_date
    String? firstAirDate,

    /// MediaDetails.runtime
    int? runtime,

    /// MediaDetails.number_of_seasons
    int? numberOfSeasons,

    /// MediaDetails.status
    String? status,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _title = title,
        _name = name,
        _overview = overview,
        _tagline = tagline,
        _posterPath = posterPath,
        _backdropPath = backdropPath,
        _voteAverage = voteAverage,
        _voteCount = voteCount,
        _releaseDate = releaseDate,
        _firstAirDate = firstAirDate,
        _runtime = runtime,
        _numberOfSeasons = numberOfSeasons,
        _status = status,
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

  // "tagline" field.
  String? _tagline;
  String get tagline => _tagline ?? '';
  set tagline(String? val) => _tagline = val;

  bool hasTagline() => _tagline != null;

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

  // "vote_count" field.
  int? _voteCount;
  int get voteCount => _voteCount ?? 0;
  set voteCount(int? val) => _voteCount = val;

  void incrementVoteCount(int amount) => voteCount = voteCount + amount;

  bool hasVoteCount() => _voteCount != null;

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

  // "runtime" field.
  int? _runtime;
  int get runtime => _runtime ?? 0;
  set runtime(int? val) => _runtime = val;

  void incrementRuntime(int amount) => runtime = runtime + amount;

  bool hasRuntime() => _runtime != null;

  // "number_of_seasons" field.
  int? _numberOfSeasons;
  int get numberOfSeasons => _numberOfSeasons ?? 0;
  set numberOfSeasons(int? val) => _numberOfSeasons = val;

  void incrementNumberOfSeasons(int amount) =>
      numberOfSeasons = numberOfSeasons + amount;

  bool hasNumberOfSeasons() => _numberOfSeasons != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  static MediaDetailsStruct fromMap(Map<String, dynamic> data) =>
      MediaDetailsStruct(
        id: castToType<int>(data['id']),
        title: data['title'] as String?,
        name: data['name'] as String?,
        overview: data['overview'] as String?,
        tagline: data['tagline'] as String?,
        posterPath: data['poster_path'] as String?,
        backdropPath: data['backdrop_path'] as String?,
        voteAverage: castToType<double>(data['vote_average']),
        voteCount: castToType<int>(data['vote_count']),
        releaseDate: data['release_date'] as String?,
        firstAirDate: data['first_air_date'] as String?,
        runtime: castToType<int>(data['runtime']),
        numberOfSeasons: castToType<int>(data['number_of_seasons']),
        status: data['status'] as String?,
      );

  static MediaDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? MediaDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'name': _name,
        'overview': _overview,
        'tagline': _tagline,
        'poster_path': _posterPath,
        'backdrop_path': _backdropPath,
        'vote_average': _voteAverage,
        'vote_count': _voteCount,
        'release_date': _releaseDate,
        'first_air_date': _firstAirDate,
        'runtime': _runtime,
        'number_of_seasons': _numberOfSeasons,
        'status': _status,
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
        'tagline': serializeParam(
          _tagline,
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
        'vote_count': serializeParam(
          _voteCount,
          ParamType.int,
        ),
        'release_date': serializeParam(
          _releaseDate,
          ParamType.String,
        ),
        'first_air_date': serializeParam(
          _firstAirDate,
          ParamType.String,
        ),
        'runtime': serializeParam(
          _runtime,
          ParamType.int,
        ),
        'number_of_seasons': serializeParam(
          _numberOfSeasons,
          ParamType.int,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
      }.withoutNulls;

  static MediaDetailsStruct fromSerializableMap(Map<String, dynamic> data) =>
      MediaDetailsStruct(
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
        tagline: deserializeParam(
          data['tagline'],
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
        voteCount: deserializeParam(
          data['vote_count'],
          ParamType.int,
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
        runtime: deserializeParam(
          data['runtime'],
          ParamType.int,
          false,
        ),
        numberOfSeasons: deserializeParam(
          data['number_of_seasons'],
          ParamType.int,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MediaDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MediaDetailsStruct &&
        id == other.id &&
        title == other.title &&
        name == other.name &&
        overview == other.overview &&
        tagline == other.tagline &&
        posterPath == other.posterPath &&
        backdropPath == other.backdropPath &&
        voteAverage == other.voteAverage &&
        voteCount == other.voteCount &&
        releaseDate == other.releaseDate &&
        firstAirDate == other.firstAirDate &&
        runtime == other.runtime &&
        numberOfSeasons == other.numberOfSeasons &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        title,
        name,
        overview,
        tagline,
        posterPath,
        backdropPath,
        voteAverage,
        voteCount,
        releaseDate,
        firstAirDate,
        runtime,
        numberOfSeasons,
        status
      ]);
}

MediaDetailsStruct createMediaDetailsStruct({
  int? id,
  String? title,
  String? name,
  String? overview,
  String? tagline,
  String? posterPath,
  String? backdropPath,
  double? voteAverage,
  int? voteCount,
  String? releaseDate,
  String? firstAirDate,
  int? runtime,
  int? numberOfSeasons,
  String? status,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MediaDetailsStruct(
      id: id,
      title: title,
      name: name,
      overview: overview,
      tagline: tagline,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      releaseDate: releaseDate,
      firstAirDate: firstAirDate,
      runtime: runtime,
      numberOfSeasons: numberOfSeasons,
      status: status,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MediaDetailsStruct? updateMediaDetailsStruct(
  MediaDetailsStruct? mediaDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    mediaDetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMediaDetailsStructData(
  Map<String, dynamic> firestoreData,
  MediaDetailsStruct? mediaDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (mediaDetails == null) {
    return;
  }
  if (mediaDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && mediaDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final mediaDetailsData =
      getMediaDetailsFirestoreData(mediaDetails, forFieldValue);
  final nestedData =
      mediaDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = mediaDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMediaDetailsFirestoreData(
  MediaDetailsStruct? mediaDetails, [
  bool forFieldValue = false,
]) {
  if (mediaDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(mediaDetails.toMap());

  // Add any Firestore field values
  mapToFirestore(mediaDetails.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMediaDetailsListFirestoreData(
  List<MediaDetailsStruct>? mediaDetailss,
) =>
    mediaDetailss?.map((e) => getMediaDetailsFirestoreData(e, true)).toList() ??
    [];
