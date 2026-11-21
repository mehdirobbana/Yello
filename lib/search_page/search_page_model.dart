import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/empty_state_widget.dart';
import '/components/loading_state_widget.dart';
import '/components/media_list_tile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_page_widget.dart' show SearchPageWidget;
import 'package:flutter/material.dart';

class SearchPageModel extends FlutterFlowModel<SearchPageWidget> {
  ///  Local state fields for this page.

  List<MediaItemStruct> movieResults = [];
  void addToMovieResults(MediaItemStruct item) => movieResults.add(item);
  void removeFromMovieResults(MediaItemStruct item) =>
      movieResults.remove(item);
  void removeAtIndexFromMovieResults(int index) => movieResults.removeAt(index);
  void insertAtIndexInMovieResults(int index, MediaItemStruct item) =>
      movieResults.insert(index, item);
  void updateMovieResultsAtIndex(
          int index, Function(MediaItemStruct) updateFn) =>
      movieResults[index] = updateFn(movieResults[index]);

  List<MediaItemStruct> tvResults = [];
  void addToTvResults(MediaItemStruct item) => tvResults.add(item);
  void removeFromTvResults(MediaItemStruct item) => tvResults.remove(item);
  void removeAtIndexFromTvResults(int index) => tvResults.removeAt(index);
  void insertAtIndexInTvResults(int index, MediaItemStruct item) =>
      tvResults.insert(index, item);
  void updateTvResultsAtIndex(int index, Function(MediaItemStruct) updateFn) =>
      tvResults[index] = updateFn(tvResults[index]);

  bool? hasSearched = false;

  String? query = '';

  String? mediaType = 'movie';

  String? sortBy = 'popular';

  String? genre = 'All';

  int? year = 0;

  double? minRating = 0.0;

  List<MediaItemStruct> results = [];
  void addToResults(MediaItemStruct item) => results.add(item);
  void removeFromResults(MediaItemStruct item) => results.remove(item);
  void removeAtIndexFromResults(int index) => results.removeAt(index);
  void insertAtIndexInResults(int index, MediaItemStruct item) =>
      results.insert(index, item);
  void updateResultsAtIndex(int index, Function(MediaItemStruct) updateFn) =>
      results[index] = updateFn(results[index]);

  int? page = 0;

  int? totalPages = 0;

  bool? isLoading = false;

  String? loadError = '';

  bool? showFilters = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - fetchTitles] action in SearchPage widget.
  MediaListResponseStruct? initialPage;
  // State field(s) for searchQueryField widget.
  FocusNode? searchQueryFieldFocusNode;
  TextEditingController? searchQueryFieldTextController;
  String? Function(BuildContext, String?)?
      searchQueryFieldTextControllerValidator;
  // Stores action output result for [Custom Action - fetchTitles] action in searchQueryField widget.
  MediaListResponseStruct? firstPage;
  // Stores action output result for [Custom Action - fetchTitles] action in searchQueryField widget.
  MediaListResponseStruct? firstPage2;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage3;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage4;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage5;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage6;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage7;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage8;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage9;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage10;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage11;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage12;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage13;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage14;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage15;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage16;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage17;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage18;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage19;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage20;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage21;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage22;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage23;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage24;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage25;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage26;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage27;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage28;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage29;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage30;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage31;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage32;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage33;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage34;
  // Stores action output result for [Custom Action - fetchTitles] action in Container widget.
  MediaListResponseStruct? firstPage35;
  // Stores action output result for [Custom Action - fetchTitles] action in ClearFiltersButton widget.
  MediaListResponseStruct? firstPage36;
  // Model for LoadingState.
  late LoadingStateModel loadingStateModel;
  // Stores action output result for [Custom Action - fetchTitles] action in RetrySearchButton widget.
  MediaListResponseStruct? firstPage37;
  // Model for EmptyState.
  late EmptyStateModel emptyStateModel;
  // Stores action output result for [Custom Action - fetchTitles] action in SearchResultsList widget.
  MediaListResponseStruct? nextPage;
  // Models for MediaListTile.
  late FlutterFlowDynamicModels<MediaListTileModel> mediaListTileModels;
  // Stores action output result for [Custom Action - fetchTitles] action in RetryMoreButton widget.
  MediaListResponseStruct? nextPage2;

  @override
  void initState(BuildContext context) {
    loadingStateModel = createModel(context, () => LoadingStateModel());
    emptyStateModel = createModel(context, () => EmptyStateModel());
    mediaListTileModels = FlutterFlowDynamicModels(() => MediaListTileModel());
  }

  @override
  void dispose() {
    searchQueryFieldFocusNode?.dispose();
    searchQueryFieldTextController?.dispose();

    loadingStateModel.dispose();
    emptyStateModel.dispose();
    mediaListTileModels.dispose();
  }
}
