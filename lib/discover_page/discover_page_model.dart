import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/backdrop_card_widget.dart';
import '/components/media_card_widget.dart';
import '/components/username_gate_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'discover_page_widget.dart' show DiscoverPageWidget;
import 'package:flutter/material.dart';

class DiscoverPageModel extends FlutterFlowModel<DiscoverPageWidget> {
  ///  Local state fields for this page.

  List<MediaItemStruct> trendingMovies = [];
  void addToTrendingMovies(MediaItemStruct item) => trendingMovies.add(item);
  void removeFromTrendingMovies(MediaItemStruct item) =>
      trendingMovies.remove(item);
  void removeAtIndexFromTrendingMovies(int index) =>
      trendingMovies.removeAt(index);
  void insertAtIndexInTrendingMovies(int index, MediaItemStruct item) =>
      trendingMovies.insert(index, item);
  void updateTrendingMoviesAtIndex(
          int index, Function(MediaItemStruct) updateFn) =>
      trendingMovies[index] = updateFn(trendingMovies[index]);

  List<MediaItemStruct> trendingTv = [];
  void addToTrendingTv(MediaItemStruct item) => trendingTv.add(item);
  void removeFromTrendingTv(MediaItemStruct item) => trendingTv.remove(item);
  void removeAtIndexFromTrendingTv(int index) => trendingTv.removeAt(index);
  void insertAtIndexInTrendingTv(int index, MediaItemStruct item) =>
      trendingTv.insert(index, item);
  void updateTrendingTvAtIndex(int index, Function(MediaItemStruct) updateFn) =>
      trendingTv[index] = updateFn(trendingTv[index]);

  List<MediaItemStruct> popularMovies = [];
  void addToPopularMovies(MediaItemStruct item) => popularMovies.add(item);
  void removeFromPopularMovies(MediaItemStruct item) =>
      popularMovies.remove(item);
  void removeAtIndexFromPopularMovies(int index) =>
      popularMovies.removeAt(index);
  void insertAtIndexInPopularMovies(int index, MediaItemStruct item) =>
      popularMovies.insert(index, item);
  void updatePopularMoviesAtIndex(
          int index, Function(MediaItemStruct) updateFn) =>
      popularMovies[index] = updateFn(popularMovies[index]);

  List<MediaItemStruct> popularTv = [];
  void addToPopularTv(MediaItemStruct item) => popularTv.add(item);
  void removeFromPopularTv(MediaItemStruct item) => popularTv.remove(item);
  void removeAtIndexFromPopularTv(int index) => popularTv.removeAt(index);
  void insertAtIndexInPopularTv(int index, MediaItemStruct item) =>
      popularTv.insert(index, item);
  void updatePopularTvAtIndex(int index, Function(MediaItemStruct) updateFn) =>
      popularTv[index] = updateFn(popularTv[index]);

  int? newFollowers = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (TmdbTrendingMovies)] action in DiscoverPage widget.
  ApiCallResponse? trendingMoviesRes;
  // Stores action output result for [Backend Call - API (TmdbTrendingTV)] action in DiscoverPage widget.
  ApiCallResponse? trendingTvRes;
  // Stores action output result for [Backend Call - API (TmdbPopularMovies)] action in DiscoverPage widget.
  ApiCallResponse? popularMoviesRes;
  // Stores action output result for [Backend Call - API (TmdbPopularTV)] action in DiscoverPage widget.
  ApiCallResponse? popularTvRes;
  // Stores action output result for [Custom Action - countNewFollowers] action in DiscoverPage widget.
  int? newFollowersRes;
  // Model for UsernameGateInstance.
  late UsernameGateModel usernameGateInstanceModel;
  // Models for BackdropCard.
  late FlutterFlowDynamicModels<BackdropCardModel> backdropCardModels;
  // Models for MediaCard.
  late FlutterFlowDynamicModels<MediaCardModel> mediaCardModels1;
  // Models for MediaCard.
  late FlutterFlowDynamicModels<MediaCardModel> mediaCardModels2;
  // Models for MediaCard.
  late FlutterFlowDynamicModels<MediaCardModel> mediaCardModels3;

  @override
  void initState(BuildContext context) {
    usernameGateInstanceModel = createModel(context, () => UsernameGateModel());
    backdropCardModels = FlutterFlowDynamicModels(() => BackdropCardModel());
    mediaCardModels1 = FlutterFlowDynamicModels(() => MediaCardModel());
    mediaCardModels2 = FlutterFlowDynamicModels(() => MediaCardModel());
    mediaCardModels3 = FlutterFlowDynamicModels(() => MediaCardModel());
  }

  @override
  void dispose() {
    usernameGateInstanceModel.dispose();
    backdropCardModels.dispose();
    mediaCardModels1.dispose();
    mediaCardModels2.dispose();
    mediaCardModels3.dispose();
  }
}
