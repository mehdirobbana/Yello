import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/empty_state_widget.dart';
import '/components/review_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'movie_details_page_widget.dart' show MovieDetailsPageWidget;
import 'package:flutter/material.dart';

class MovieDetailsPageModel extends FlutterFlowModel<MovieDetailsPageWidget> {
  ///  Local state fields for this page.

  MediaDetailsStruct? details;
  void updateDetailsStruct(Function(MediaDetailsStruct) updateFn) {
    updateFn(details ??= MediaDetailsStruct());
  }

  String? displayTitle = '';

  String? displayDate = '';

  bool? isFavorite = false;

  bool? inWatchlist = false;

  double? yelloAvg = 0.0;

  int? yelloCount = 0;

  bool? hasMyReview = false;

  double? myRating = 0.0;

  String? myComment = '';

  bool? mySpoiler = false;

  double? draftRating = 0.0;

  bool? draftSpoiler = false;

  bool? isEditing = false;

  bool? isSubmitting = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (TmdbTVDetails)] action in MovieDetailsPage widget.
  ApiCallResponse? tvDetailsRes;
  // Stores action output result for [Backend Call - API (TmdbMovieDetails)] action in MovieDetailsPage widget.
  ApiCallResponse? movieDetailsRes;
  // Stores action output result for [Firestore Query - Query a collection] action in MovieDetailsPage widget.
  List<FavoritesRecord>? favMatches;
  // Stores action output result for [Firestore Query - Query a collection] action in MovieDetailsPage widget.
  List<WatchlistRecord>? watchMatches;
  // Stores action output result for [Firestore Query - Query a collection] action in MovieDetailsPage widget.
  List<ReviewsRecord>? myReviewMatches2;
  // Stores action output result for [Firestore Query - Query a collection] action in MovieDetailsPage widget.
  ReviewsRecord? myReviewDoc2;
  // Stores action output result for [Custom Action - getYelloAverage] action in MovieDetailsPage widget.
  double? yAvg3;
  // Stores action output result for [Custom Action - getYelloRatingCount] action in MovieDetailsPage widget.
  int? yCount3;
  // Model for MissingTitleEmptyState.
  late EmptyStateModel missingTitleEmptyStateModel;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  FavoritesRecord? favToRemove;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  FavoritesRecord? document;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  WatchlistRecord? watchToRemove;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  WatchlistRecord? document2;
  // State field(s) for reviewComment widget.
  FocusNode? reviewCommentFocusNode;
  TextEditingController? reviewCommentTextController;
  String? Function(BuildContext, String?)? reviewCommentTextControllerValidator;
  // Stores action output result for [Custom Action - saveReview] action in SubmitReviewButton widget.
  String? saveResult;
  // Stores action output result for [Firestore Query - Query a collection] action in SubmitReviewButton widget.
  List<ReviewsRecord>? myReviewMatches;
  // Stores action output result for [Firestore Query - Query a collection] action in SubmitReviewButton widget.
  ReviewsRecord? myReviewDoc;
  // Stores action output result for [Custom Action - getYelloAverage] action in SubmitReviewButton widget.
  double? yAvg;
  // Stores action output result for [Custom Action - getYelloRatingCount] action in SubmitReviewButton widget.
  int? yCount;
  // Models for ReviewCard.
  late FlutterFlowDynamicModels<ReviewCardModel> reviewCardModels;

  @override
  void initState(BuildContext context) {
    missingTitleEmptyStateModel = createModel(context, () => EmptyStateModel());
    reviewCardModels = FlutterFlowDynamicModels(() => ReviewCardModel());
  }

  @override
  void dispose() {
    missingTitleEmptyStateModel.dispose();
    reviewCommentFocusNode?.dispose();
    reviewCommentTextController?.dispose();

    reviewCardModels.dispose();
  }

  /// Action blocks.
  /// DSL action block deleteMyReviewFlow
  Future deleteMyReviewFlow(BuildContext context) async {
    String? deleteReviewResult;
    double? avgAfterDelete;
    int? countAfterDelete;

    isSubmitting = true;
    updatePage(() {});
    deleteReviewResult = await actions.deleteMyReview(
      widget!.movieId,
      widget!.mediaType,
    );
    isSubmitting = false;
    updatePage(() {});
    if (deleteReviewResult == '') {
      hasMyReview = false;
      updatePage(() {});
      myRating = 0.0;
      updatePage(() {});
      myComment = '';
      updatePage(() {});
      mySpoiler = false;
      updatePage(() {});
      draftRating = 0.0;
      updatePage(() {});
      draftSpoiler = false;
      updatePage(() {});
      isEditing = false;
      updatePage(() {});
      avgAfterDelete = await actions.getYelloAverage(
        (String? t, int? id) {
          return '${t ?? 'movie'}_${id}';
        }(widget!.mediaType, widget!.movieId),
      );
      yelloAvg = avgAfterDelete;
      updatePage(() {});
      countAfterDelete = await actions.getYelloRatingCount(
        (String? t, int? id) {
          return '${t ?? 'movie'}_${id}';
        }(widget!.mediaType, widget!.movieId),
      );
      yelloCount = countAfterDelete;
      updatePage(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Review deleted',
            style: TextStyle(),
          ),
          duration: Duration(milliseconds: 4000),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            deleteReviewResult,
            style: TextStyle(),
          ),
          duration: Duration(milliseconds: 4000),
        ),
      );
    }
  }
}
