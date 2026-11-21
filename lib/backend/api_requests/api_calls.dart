import 'dart:convert';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Color, DateTimeRange;
// Redundant when the data-type schema export already re-exports it.
// ignore: unnecessary_import
import 'package:from_css_color/from_css_color.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start TMDBApi Group Code

class TMDBApiGroup {
  static String getBaseUrl({
    String? tmdbApiKey = '32cdc7ea95368926414e27d2b350ce89',
  }) =>
      'https://api.themoviedb.org/3';
  static Map<String, String> headers = {
    'Accept': 'application/json',
  };
  static TmdbTrendingMoviesCall tmdbTrendingMoviesCall =
      TmdbTrendingMoviesCall();
  static TmdbTrendingTVCall tmdbTrendingTVCall = TmdbTrendingTVCall();
  static TmdbPopularMoviesCall tmdbPopularMoviesCall = TmdbPopularMoviesCall();
  static TmdbPopularTVCall tmdbPopularTVCall = TmdbPopularTVCall();
  static TmdbSearchMoviesCall tmdbSearchMoviesCall = TmdbSearchMoviesCall();
  static TmdbSearchTVCall tmdbSearchTVCall = TmdbSearchTVCall();
  static TmdbMovieDetailsCall tmdbMovieDetailsCall = TmdbMovieDetailsCall();
  static TmdbTVDetailsCall tmdbTVDetailsCall = TmdbTVDetailsCall();
}

class TmdbTrendingMoviesCall {
  Future<ApiCallResponse> call({
    String? tmdbApiKey = '32cdc7ea95368926414e27d2b350ce89',
  }) async {
    final baseUrl = TMDBApiGroup.getBaseUrl(
      tmdbApiKey: tmdbApiKey,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'TmdbTrendingMovies',
      apiUrl: '${baseUrl}/trending/movie/week?api_key=${tmdbApiKey}',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TmdbTrendingTVCall {
  Future<ApiCallResponse> call({
    String? tmdbApiKey = '32cdc7ea95368926414e27d2b350ce89',
  }) async {
    final baseUrl = TMDBApiGroup.getBaseUrl(
      tmdbApiKey: tmdbApiKey,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'TmdbTrendingTV',
      apiUrl: '${baseUrl}/trending/tv/week?api_key=${tmdbApiKey}',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TmdbPopularMoviesCall {
  Future<ApiCallResponse> call({
    String? tmdbApiKey = '32cdc7ea95368926414e27d2b350ce89',
  }) async {
    final baseUrl = TMDBApiGroup.getBaseUrl(
      tmdbApiKey: tmdbApiKey,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'TmdbPopularMovies',
      apiUrl: '${baseUrl}/movie/popular?api_key=${tmdbApiKey}&page=1',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TmdbPopularTVCall {
  Future<ApiCallResponse> call({
    String? tmdbApiKey = '32cdc7ea95368926414e27d2b350ce89',
  }) async {
    final baseUrl = TMDBApiGroup.getBaseUrl(
      tmdbApiKey: tmdbApiKey,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'TmdbPopularTV',
      apiUrl: '${baseUrl}/tv/popular?api_key=${tmdbApiKey}&page=1',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TmdbSearchMoviesCall {
  Future<ApiCallResponse> call({
    String? query = '',
    String? tmdbApiKey = '32cdc7ea95368926414e27d2b350ce89',
  }) async {
    final baseUrl = TMDBApiGroup.getBaseUrl(
      tmdbApiKey: tmdbApiKey,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'TmdbSearchMovies',
      apiUrl: '${baseUrl}/search/movie?api_key=${tmdbApiKey}&query=${query}',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TmdbSearchTVCall {
  Future<ApiCallResponse> call({
    String? query = '',
    String? tmdbApiKey = '32cdc7ea95368926414e27d2b350ce89',
  }) async {
    final baseUrl = TMDBApiGroup.getBaseUrl(
      tmdbApiKey: tmdbApiKey,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'TmdbSearchTV',
      apiUrl: '${baseUrl}/search/tv?api_key=${tmdbApiKey}&query=${query}',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TmdbMovieDetailsCall {
  Future<ApiCallResponse> call({
    int? id,
    String? tmdbApiKey = '32cdc7ea95368926414e27d2b350ce89',
  }) async {
    final baseUrl = TMDBApiGroup.getBaseUrl(
      tmdbApiKey: tmdbApiKey,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'TmdbMovieDetails',
      apiUrl: '${baseUrl}/movie/${id}?api_key=${tmdbApiKey}',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TmdbTVDetailsCall {
  Future<ApiCallResponse> call({
    int? id,
    String? tmdbApiKey = '32cdc7ea95368926414e27d2b350ce89',
  }) async {
    final baseUrl = TMDBApiGroup.getBaseUrl(
      tmdbApiKey: tmdbApiKey,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'TmdbTVDetails',
      apiUrl: '${baseUrl}/tv/${id}?api_key=${tmdbApiKey}',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End TMDBApi Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  if (item is DateTime) {
    return item.toIso8601String();
  }
  if (item is Color) {
    return item.toCssString();
  }
  if (item is LatLng) {
    return item.serialize();
  }
  if (item is DateTimeRange) {
    String millis(DateTime d) =>
        '${d.isUtc ? 'u' : 'l'}${d.millisecondsSinceEpoch}';
    return '${millis(item.start)}|${millis(item.end)}';
  }
  if (item is FFPlace) {
    return jsonEncode({
      'latLng': item.latLng.serialize(),
      'name': item.name,
      'address': item.address,
      'city': item.city,
      'state': item.state,
      'country': item.country,
      'zipCode': item.zipCode,
    });
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
