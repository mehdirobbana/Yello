// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct MediaListResponse
class MediaListResponseStruct extends FFFirebaseStruct {
  MediaListResponseStruct({
    /// MediaListResponse.page
    int? page,

    /// MediaListResponse.results
    List<MediaItemStruct>? results,

    /// MediaListResponse.total_pages
    int? totalPages,

    /// MediaListResponse.total_results
    int? totalResults,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _page = page,
        _results = results,
        _totalPages = totalPages,
        _totalResults = totalResults,
        super(firestoreUtilData);

  // "page" field.
  int? _page;
  int get page => _page ?? 0;
  set page(int? val) => _page = val;

  void incrementPage(int amount) => page = page + amount;

  bool hasPage() => _page != null;

  // "results" field.
  List<MediaItemStruct>? _results;
  List<MediaItemStruct> get results => _results ?? const [];
  set results(List<MediaItemStruct>? val) => _results = val;

  void updateResults(Function(List<MediaItemStruct>) updateFn) {
    updateFn(_results ??= []);
  }

  bool hasResults() => _results != null;

  // "total_pages" field.
  int? _totalPages;
  int get totalPages => _totalPages ?? 0;
  set totalPages(int? val) => _totalPages = val;

  void incrementTotalPages(int amount) => totalPages = totalPages + amount;

  bool hasTotalPages() => _totalPages != null;

  // "total_results" field.
  int? _totalResults;
  int get totalResults => _totalResults ?? 0;
  set totalResults(int? val) => _totalResults = val;

  void incrementTotalResults(int amount) =>
      totalResults = totalResults + amount;

  bool hasTotalResults() => _totalResults != null;

  static MediaListResponseStruct fromMap(Map<String, dynamic> data) =>
      MediaListResponseStruct(
        page: castToType<int>(data['page']),
        results: getStructList(
          data['results'],
          MediaItemStruct.fromMap,
        ),
        totalPages: castToType<int>(data['total_pages']),
        totalResults: castToType<int>(data['total_results']),
      );

  static MediaListResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? MediaListResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'page': _page,
        'results': _results?.map((e) => e.toMap()).toList(),
        'total_pages': _totalPages,
        'total_results': _totalResults,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'page': serializeParam(
          _page,
          ParamType.int,
        ),
        'results': serializeParam(
          _results,
          ParamType.DataStruct,
          isList: true,
        ),
        'total_pages': serializeParam(
          _totalPages,
          ParamType.int,
        ),
        'total_results': serializeParam(
          _totalResults,
          ParamType.int,
        ),
      }.withoutNulls;

  static MediaListResponseStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      MediaListResponseStruct(
        page: deserializeParam(
          data['page'],
          ParamType.int,
          false,
        ),
        results: deserializeStructParam<MediaItemStruct>(
          data['results'],
          ParamType.DataStruct,
          true,
          structBuilder: MediaItemStruct.fromSerializableMap,
        ),
        totalPages: deserializeParam(
          data['total_pages'],
          ParamType.int,
          false,
        ),
        totalResults: deserializeParam(
          data['total_results'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'MediaListResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is MediaListResponseStruct &&
        page == other.page &&
        listEquality.equals(results, other.results) &&
        totalPages == other.totalPages &&
        totalResults == other.totalResults;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [page, const ListEquality().hash(results), totalPages, totalResults]);
}

MediaListResponseStruct createMediaListResponseStruct({
  int? page,
  int? totalPages,
  int? totalResults,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MediaListResponseStruct(
      page: page,
      totalPages: totalPages,
      totalResults: totalResults,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MediaListResponseStruct? updateMediaListResponseStruct(
  MediaListResponseStruct? mediaListResponse, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    mediaListResponse
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMediaListResponseStructData(
  Map<String, dynamic> firestoreData,
  MediaListResponseStruct? mediaListResponse,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (mediaListResponse == null) {
    return;
  }
  if (mediaListResponse.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && mediaListResponse.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final mediaListResponseData =
      getMediaListResponseFirestoreData(mediaListResponse, forFieldValue);
  final nestedData =
      mediaListResponseData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = mediaListResponse.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMediaListResponseFirestoreData(
  MediaListResponseStruct? mediaListResponse, [
  bool forFieldValue = false,
]) {
  if (mediaListResponse == null) {
    return {};
  }
  final firestoreData = mapToFirestore(mediaListResponse.toMap());

  // Add any Firestore field values
  mapToFirestore(mediaListResponse.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMediaListResponseListFirestoreData(
  List<MediaListResponseStruct>? mediaListResponses,
) =>
    mediaListResponses
        ?.map((e) => getMediaListResponseFirestoreData(e, true))
        .toList() ??
    [];
