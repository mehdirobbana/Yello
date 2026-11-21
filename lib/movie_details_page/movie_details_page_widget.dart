import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/delete_review_dialog_widget.dart';
import '/components/empty_state_widget.dart';
import '/components/loading_state_widget.dart';
import '/components/review_card_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'movie_details_page_model.dart';
export 'movie_details_page_model.dart';

/// Details of one movie, opened with a TMDB movieId
class MovieDetailsPageWidget extends StatefulWidget {
  const MovieDetailsPageWidget({
    super.key,
    int? movieId,
    String? mediaType,
  })  : this.movieId = movieId ?? 0,
        this.mediaType = mediaType ?? 'movie';

  final int movieId;

  /// movie or tv
  final String mediaType;

  static String routeName = 'MovieDetailsPage';
  static String routePath = '/movie-details';

  @override
  State<MovieDetailsPageWidget> createState() => _MovieDetailsPageWidgetState();
}

class _MovieDetailsPageWidgetState extends State<MovieDetailsPageWidget> {
  late MovieDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MovieDetailsPageModel());
    _model.setOnUpdate(onUpdate: () => safeSetState(() {}));

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.mediaType == 'tv') {
        _model.tvDetailsRes = await TMDBApiGroup.tmdbTVDetailsCall.call(
          id: widget.movieId,
        );

        if ((_model.tvDetailsRes?.succeeded ?? true)) {
          _model.details = MediaDetailsStruct.maybeFromMap(
              (_model.tvDetailsRes?.jsonBody ?? ''));
          safeSetState(() {});
          _model.displayTitle = (String? v) {
            return v ?? '';
          }(MediaDetailsStruct.maybeFromMap(
                  (_model.tvDetailsRes?.jsonBody ?? ''))
              ?.name);
          safeSetState(() {});
          _model.displayDate = (String? v) {
            return v ?? '';
          }(MediaDetailsStruct.maybeFromMap(
                  (_model.tvDetailsRes?.jsonBody ?? ''))
              ?.firstAirDate);
          safeSetState(() {});
        }
      } else {
        _model.movieDetailsRes = await TMDBApiGroup.tmdbMovieDetailsCall.call(
          id: widget.movieId,
        );

        if ((_model.movieDetailsRes?.succeeded ?? true)) {
          _model.details = MediaDetailsStruct.maybeFromMap(
              (_model.movieDetailsRes?.jsonBody ?? ''));
          safeSetState(() {});
          _model.displayTitle = (String? v) {
            return v ?? '';
          }(MediaDetailsStruct.maybeFromMap(
                  (_model.movieDetailsRes?.jsonBody ?? ''))
              ?.title);
          safeSetState(() {});
          _model.displayDate = (String? v) {
            return v ?? '';
          }(MediaDetailsStruct.maybeFromMap(
                  (_model.movieDetailsRes?.jsonBody ?? ''))
              ?.releaseDate);
          safeSetState(() {});
        }
      }

      await Future.wait([
        Future(() async {
          _model.favMatches = await queryFavoritesRecordOnce(
            queryBuilder: (favoritesRecord) => favoritesRecord
                .where(
                  'userId',
                  isEqualTo: currentUserUid,
                )
                .where(
                  'mediaKey',
                  isEqualTo: (String? t, int? id) {
                    return '${t ?? 'movie'}_${id}';
                  }(widget.mediaType, widget.movieId),
                ),
            limit: 1,
          );
          _model.isFavorite = !(_model.favMatches?.length == 0);
          safeSetState(() {});
        }),
        Future(() async {
          _model.watchMatches = await queryWatchlistRecordOnce(
            queryBuilder: (watchlistRecord) => watchlistRecord
                .where(
                  'userId',
                  isEqualTo: currentUserUid,
                )
                .where(
                  'mediaKey',
                  isEqualTo: (String? t, int? id) {
                    return '${t ?? 'movie'}_${id}';
                  }(widget.mediaType, widget.movieId),
                ),
            limit: 1,
          );
          _model.inWatchlist = !(_model.watchMatches?.length == 0);
          safeSetState(() {});
        }),
        Future(() async {
          _model.myReviewMatches2 = await queryReviewsRecordOnce(
            queryBuilder: (reviewsRecord) => reviewsRecord
                .where(
                  'userId',
                  isEqualTo: currentUserUid,
                )
                .where(
                  'mediaKey',
                  isEqualTo: (String? t, int? id) {
                    return '${t ?? 'movie'}_${id}';
                  }(widget.mediaType, widget.movieId),
                ),
            limit: 1,
          );
          _model.hasMyReview = !(_model.myReviewMatches2?.length == 0);
          safeSetState(() {});
          _model.myReviewDoc2 = await queryReviewsRecordOnce(
            queryBuilder: (reviewsRecord) => reviewsRecord
                .where(
                  'userId',
                  isEqualTo: currentUserUid,
                )
                .where(
                  'mediaKey',
                  isEqualTo: (String? t, int? id) {
                    return '${t ?? 'movie'}_${id}';
                  }(widget.mediaType, widget.movieId),
                ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          _model.myRating = _model.myReviewDoc2?.rating ?? 0.0;
          safeSetState(() {});
          _model.myComment = (String? v) {
            return v ?? '';
          }(_model.myReviewDoc2?.comment);
          safeSetState(() {});
          _model.mySpoiler = _model.myReviewDoc2?.containsSpoilers ?? false;
          safeSetState(() {});
          _model.draftRating = _model.myReviewDoc2?.rating ?? 0.0;
          safeSetState(() {});
          _model.draftSpoiler = _model.myReviewDoc2?.containsSpoilers ?? false;
          safeSetState(() {});
          safeSetState(() {
            _model.reviewCommentTextController?.text = ((String? c) {
              return c ?? '';
            }(_model.myComment));
          });
        }),
        Future(() async {
          _model.yAvg3 = await actions.getYelloAverage(
            (String? t, int? id) {
              return '${t ?? 'movie'}_${id}';
            }(widget.mediaType, widget.movieId),
          );
          _model.yelloAvg = _model.yAvg3;
          safeSetState(() {});
          _model.yCount3 = await actions.getYelloRatingCount(
            (String? t, int? id) {
              return '${t ?? 'movie'}_${id}';
            }(widget.mediaType, widget.movieId),
          );
          _model.yelloCount = _model.yCount3;
          safeSetState(() {});
        }),
      ]);
    });

    _model.reviewCommentTextController ??= TextEditingController();
    _model.reviewCommentFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Stack(
                    alignment: AlignmentDirectional(-1.0, -1.0),
                    children: [
                      if (((int? id) {
                            return id != null && id > 0;
                          }(widget.movieId)) ??
                          true)
                        CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 500),
                          fadeOutDuration: Duration(milliseconds: 500),
                          imageUrl: ((String? p) {
                            return 'https://image.tmdb.org/t/p/w780${p}';
                          }(_model.details?.backdropPath)),
                          width: double.infinity,
                          height: 260.0,
                          fit: BoxFit.cover,
                        ),
                      if (((int? id) {
                            return id != null && id > 0;
                          }(widget.movieId)) ??
                          true)
                        Container(
                          width: double.infinity,
                          height: 260.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                FlutterFlowTheme.of(context).accent4,
                                Colors.transparent,
                                FlutterFlowTheme.of(context).primaryBackground
                              ],
                              stops: [0.0, 0.4, 1.0],
                              begin: AlignmentDirectional(1.0, 0.0),
                              end: AlignmentDirectional(-1.0, 0),
                            ),
                          ),
                        ),
                      Container(
                        child: AlignedTooltip(
                          content: Text(
                            FFLocalizations.of(context).getText(
                              'ttback01' /* Back */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).info,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                          ),
                          preferredDirection: AxisDirection.down,
                          borderRadius: BorderRadius.circular(8.0),
                          backgroundColor:
                              FlutterFlowTheme.of(context).primaryText,
                          elevation: 0.0,
                          tailBaseWidth: 0.0,
                          tailLength: 0.0,
                          waitDuration: Duration(milliseconds: 0),
                          showDuration: Duration(milliseconds: 0),
                          triggerMode: TooltipTriggerMode.longPress,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: FlutterFlowIconButton(
                              borderRadius: 24.0,
                              buttonSize: 48.0,
                              fillColor: FlutterFlowTheme.of(context).accent4,
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: FlutterFlowTheme.of(context).info,
                                size: 24.0,
                              ),
                              onPressed: () async {
                                context.safePop();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (((int? id) {
                        return id == null || id <= 0;
                      }(widget.movieId)) ??
                      true)
                    wrapWithModel(
                      model: _model.missingTitleEmptyStateModel,
                      updateCallback: () => safeSetState(() {}),
                      child: EmptyStateWidget(
                        message:
                            'We couldn\'t find this title. Go back and pick another one.',
                      ),
                    ),
                  if (((int? id) {
                        return id != null && id > 0;
                      }(widget.movieId)) ??
                      true)
                    Container(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment:
                              (FFMainAxisAlignment.start).flutterValue,
                          crossAxisAlignment:
                              (FFCrossAxisAlignment.start).flutterValue,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                                  (FFMainAxisAlignment.start).flutterValue,
                              crossAxisAlignment:
                                  (FFCrossAxisAlignment.end).flutterValue,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 20.0,
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        offset: Offset(
                                          0.0,
                                          10.0,
                                        ),
                                        spreadRadius: 0.0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: CachedNetworkImage(
                                      fadeInDuration:
                                          Duration(milliseconds: 500),
                                      fadeOutDuration:
                                          Duration(milliseconds: 500),
                                      imageUrl: ((String? p) {
                                        return 'https://image.tmdb.org/t/p/w342${p}';
                                      }(_model.details?.posterPath)),
                                      width: 112.0,
                                      height: 168.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        (FFMainAxisAlignment.start)
                                            .flutterValue,
                                    crossAxisAlignment:
                                        (FFCrossAxisAlignment.start)
                                            .flutterValue,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            (FFMainAxisAlignment.start)
                                                .flutterValue,
                                        crossAxisAlignment:
                                            (FFCrossAxisAlignment.center)
                                                .flutterValue,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 4.0, 8.0, 4.0),
                                              child: Text(
                                                widget.mediaType == 'tv'
                                                    ? 'TV SHOW'
                                                    : 'MOVIE',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelSmall
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            ((String? d) {
                                              return (d ?? '').length >= 4
                                                  ? (d ?? '').substring(0, 4)
                                                  : '';
                                            }(_model.displayDate)),
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                      Text(
                                        _model.displayTitle!,
                                        maxLines: 3,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              font: GoogleFonts.sora(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .fontStyle,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            (FFMainAxisAlignment.start)
                                                .flutterValue,
                                        crossAxisAlignment:
                                            (FFCrossAxisAlignment.center)
                                                .flutterValue,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Icon(
                                            Icons.star_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 22.0,
                                          ),
                                          Text(
                                            ((_model.details?.voteAverage ?? 0)
                                                .toStringAsFixed(1)),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  font: GoogleFonts.sora(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '5u3xqgpr' /* /10 · TMDB */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                    ].divide(SizedBox(height: 8.0)),
                                  ),
                                ),
                              ].divide(SizedBox(width: 16.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                                  (FFMainAxisAlignment.start).flutterValue,
                              crossAxisAlignment:
                                  (FFCrossAxisAlignment.center).flutterValue,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        (FFMainAxisAlignment.start)
                                            .flutterValue,
                                    crossAxisAlignment:
                                        (FFCrossAxisAlignment.center)
                                            .flutterValue,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      if (_model.isFavorite ?? true)
                                        FFButtonWidget(
                                          onPressed: () async {
                                            _model.isFavorite = false;
                                            safeSetState(() {});
                                            _model.favToRemove =
                                                await queryFavoritesRecordOnce(
                                              queryBuilder: (favoritesRecord) =>
                                                  favoritesRecord
                                                      .where(
                                                        'userId',
                                                        isEqualTo:
                                                            currentUserUid,
                                                      )
                                                      .where(
                                                        'mediaKey',
                                                        isEqualTo: (String? t,
                                                                int? id) {
                                                          return '${t ?? 'movie'}_${id}';
                                                        }(widget.mediaType,
                                                            widget.movieId),
                                                      ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            await _model.favToRemove!.reference
                                                .delete();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Removed from favorites',
                                                  style: TextStyle(),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                              ),
                                            );

                                            safeSetState(() {});
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'n0z79wu7' /* Favorited */,
                                          ),
                                          icon: Icon(
                                            Icons.favorite_rounded,
                                            size: 20.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 48.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .tertiary,
                                            color: FlutterFlowTheme.of(context)
                                                .accent3,
                                            textStyle: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                        ),
                                      if (!_model.isFavorite!)
                                        FFButtonWidget(
                                          onPressed: () async {
                                            _model.isFavorite = true;
                                            safeSetState(() {});

                                            var favoritesRecordReference =
                                                FavoritesRecord.collection
                                                    .doc();
                                            await favoritesRecordReference
                                                .set(createFavoritesRecordData(
                                              userId: currentUserUid,
                                              tmdbId: widget.movieId,
                                              mediaType:
                                                  widget.mediaType == 'tv'
                                                      ? 'tv'
                                                      : 'movie',
                                              mediaKey: (String? t, int? id) {
                                                return '${t ?? 'movie'}_${id}';
                                              }(widget.mediaType,
                                                  widget.movieId),
                                              title: _model.displayTitle,
                                              posterPath:
                                                  _model.details?.posterPath,
                                              voteAverage:
                                                  _model.details?.voteAverage,
                                              createdAt: getCurrentTimestamp,
                                            ));
                                            _model.document = FavoritesRecord
                                                .getDocumentFromData(
                                                    createFavoritesRecordData(
                                                      userId: currentUserUid,
                                                      tmdbId: widget.movieId,
                                                      mediaType:
                                                          widget.mediaType ==
                                                                  'tv'
                                                              ? 'tv'
                                                              : 'movie',
                                                      mediaKey:
                                                          (String? t, int? id) {
                                                        return '${t ?? 'movie'}_${id}';
                                                      }(widget.mediaType,
                                                              widget.movieId),
                                                      title:
                                                          _model.displayTitle,
                                                      posterPath: _model
                                                          .details?.posterPath,
                                                      voteAverage: _model
                                                          .details?.voteAverage,
                                                      createdAt:
                                                          getCurrentTimestamp,
                                                    ),
                                                    favoritesRecordReference);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Added to your favorites',
                                                  style: TextStyle(),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                              ),
                                            );

                                            safeSetState(() {});
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'zb6exn2k' /* Favorite */,
                                          ),
                                          icon: Icon(
                                            Icons.favorite_border_rounded,
                                            size: 20.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 48.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            color: Colors.transparent,
                                            textStyle: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent2,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        (FFMainAxisAlignment.start)
                                            .flutterValue,
                                    crossAxisAlignment:
                                        (FFCrossAxisAlignment.center)
                                            .flutterValue,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      if (_model.inWatchlist ?? true)
                                        FFButtonWidget(
                                          onPressed: () async {
                                            _model.inWatchlist = false;
                                            safeSetState(() {});
                                            _model.watchToRemove =
                                                await queryWatchlistRecordOnce(
                                              queryBuilder: (watchlistRecord) =>
                                                  watchlistRecord
                                                      .where(
                                                        'userId',
                                                        isEqualTo:
                                                            currentUserUid,
                                                      )
                                                      .where(
                                                        'mediaKey',
                                                        isEqualTo: (String? t,
                                                                int? id) {
                                                          return '${t ?? 'movie'}_${id}';
                                                        }(widget.mediaType,
                                                            widget.movieId),
                                                      ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            await _model
                                                .watchToRemove!.reference
                                                .delete();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Removed from watchlist',
                                                  style: TextStyle(),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                              ),
                                            );

                                            safeSetState(() {});
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'nz4wvw20' /* In watchlist */,
                                          ),
                                          icon: Icon(
                                            Icons.bookmark_rounded,
                                            size: 20.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 48.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .tertiary,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                        ),
                                      if (!_model.inWatchlist!)
                                        FFButtonWidget(
                                          onPressed: () async {
                                            _model.inWatchlist = true;
                                            safeSetState(() {});

                                            var watchlistRecordReference =
                                                WatchlistRecord.collection
                                                    .doc();
                                            await watchlistRecordReference
                                                .set(createWatchlistRecordData(
                                              userId: currentUserUid,
                                              tmdbId: widget.movieId,
                                              mediaType:
                                                  widget.mediaType == 'tv'
                                                      ? 'tv'
                                                      : 'movie',
                                              mediaKey: (String? t, int? id) {
                                                return '${t ?? 'movie'}_${id}';
                                              }(widget.mediaType,
                                                  widget.movieId),
                                              title: _model.displayTitle,
                                              posterPath:
                                                  _model.details?.posterPath,
                                              voteAverage:
                                                  _model.details?.voteAverage,
                                              createdAt: getCurrentTimestamp,
                                            ));
                                            _model.document2 = WatchlistRecord
                                                .getDocumentFromData(
                                                    createWatchlistRecordData(
                                                      userId: currentUserUid,
                                                      tmdbId: widget.movieId,
                                                      mediaType:
                                                          widget.mediaType ==
                                                                  'tv'
                                                              ? 'tv'
                                                              : 'movie',
                                                      mediaKey:
                                                          (String? t, int? id) {
                                                        return '${t ?? 'movie'}_${id}';
                                                      }(widget.mediaType,
                                                              widget.movieId),
                                                      title:
                                                          _model.displayTitle,
                                                      posterPath: _model
                                                          .details?.posterPath,
                                                      voteAverage: _model
                                                          .details?.voteAverage,
                                                      createdAt:
                                                          getCurrentTimestamp,
                                                    ),
                                                    watchlistRecordReference);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Added to your watchlist',
                                                  style: TextStyle(),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                              ),
                                            );

                                            safeSetState(() {});
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'ke7b5ylb' /* Watchlist */,
                                          ),
                                          icon: Icon(
                                            Icons.bookmark_border_rounded,
                                            size: 20.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 48.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            color: Colors.transparent,
                                            textStyle: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent2,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ].divide(SizedBox(width: 12.0)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment:
                                  (FFMainAxisAlignment.start).flutterValue,
                              crossAxisAlignment:
                                  (FFCrossAxisAlignment.start).flutterValue,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'h5piwrea' /* Overview */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.sora(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                ),
                                Text(
                                  ((MediaDetailsStruct? d) {
                                    return (d?.tagline ?? '').trim();
                                  }(_model.details)),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                Text(
                                  ((MediaDetailsStruct? d) {
                                    return (d?.overview ?? '').trim().isEmpty
                                        ? 'No overview available yet.'
                                        : d!.overview;
                                  }(_model.details)),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.6,
                                      ),
                                ),
                              ].divide(SizedBox(height: 8.0)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment:
                                  (FFMainAxisAlignment.start).flutterValue,
                              crossAxisAlignment:
                                  (FFCrossAxisAlignment.start).flutterValue,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'vtzgdtlg' /* Ratings & reviews */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        font: GoogleFonts.sora(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleLarge
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      (FFMainAxisAlignment.start).flutterValue,
                                  crossAxisAlignment:
                                      (FFCrossAxisAlignment.center)
                                          .flutterValue,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                (FFMainAxisAlignment.start)
                                                    .flutterValue,
                                            crossAxisAlignment:
                                                (FFCrossAxisAlignment.start)
                                                    .flutterValue,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '3ho96sox' /* YELLO RATING */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelSmall
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    (FFMainAxisAlignment.start)
                                                        .flutterValue,
                                                crossAxisAlignment:
                                                    (FFCrossAxisAlignment
                                                            .center)
                                                        .flutterValue,
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: [
                                                  Icon(
                                                    Icons.star_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 22.0,
                                                  ),
                                                  Text(
                                                    ((double? a, int? c) {
                                                      return (c ?? 0) <= 0 ||
                                                              (a ?? 0) <= 0
                                                          ? 'N/A'
                                                          : (a ?? 0)
                                                              .toStringAsFixed(
                                                                  1);
                                                    }(_model.yelloAvg,
                                                        _model.yelloCount)),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.sora(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmall
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                              Text(
                                                ((int? c) {
                                                  return (c ?? 0) < 0
                                                      ? 'Could not load'
                                                      : (c ?? 0) == 0
                                                          ? 'No ratings yet'
                                                          : '${c} rating' +
                                                              (c == 1
                                                                  ? ''
                                                                  : 's') +
                                                              ' · out of 5';
                                                }(_model.yelloCount)),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelSmall
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                (FFMainAxisAlignment.start)
                                                    .flutterValue,
                                            crossAxisAlignment:
                                                (FFCrossAxisAlignment.start)
                                                    .flutterValue,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '2ee9nuwp' /* TMDB RATING */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelSmall
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    (FFMainAxisAlignment.start)
                                                        .flutterValue,
                                                crossAxisAlignment:
                                                    (FFCrossAxisAlignment
                                                            .center)
                                                        .flutterValue,
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: [
                                                  Icon(
                                                    Icons.star_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 22.0,
                                                  ),
                                                  Text(
                                                    ((_model.details
                                                                ?.voteAverage ??
                                                            0)
                                                        .toStringAsFixed(1)),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineSmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.sora(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmall
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                              Text(
                                                ((int? n) {
                                                  return '${n ?? 0} votes · out of 10';
                                                }(_model.details?.voteCount)),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelSmall
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                                if ((!(_model.hasMyReview ?? false) ||
                                        (_model.isEditing ?? false)) ??
                                    true)
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            (FFMainAxisAlignment.start)
                                                .flutterValue,
                                        crossAxisAlignment:
                                            (FFCrossAxisAlignment.start)
                                                .flutterValue,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            _model.hasMyReview!
                                                ? 'Edit your review'
                                                : 'Rate & review',
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  font: GoogleFonts.sora(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                (FFMainAxisAlignment.start)
                                                    .flutterValue,
                                            crossAxisAlignment:
                                                (FFCrossAxisAlignment.center)
                                                    .flutterValue,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Container(
                                                width: 46.0,
                                                height: 46.0,
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  children: [
                                                    if (((double? r) {
                                                          return (r ?? 0) >= 1;
                                                        }(_model
                                                            .draftRating)) ??
                                                        true)
                                                      Icon(
                                                        Icons.star_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 42.0,
                                                      ),
                                                    if (((double? r) {
                                                          return (r ?? 0) >=
                                                                  0.5 &&
                                                              (r ?? 0) < 1;
                                                        }(_model
                                                            .draftRating)) ??
                                                        true)
                                                      Icon(
                                                        Icons.star_half_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 42.0,
                                                      ),
                                                    if (((_model.draftRating ??
                                                                0) <
                                                            0.5) ??
                                                        true)
                                                      Icon(
                                                        Icons
                                                            .star_outline_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 42.0,
                                                      ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          (FFMainAxisAlignment
                                                                  .start)
                                                              .flutterValue,
                                                      crossAxisAlignment:
                                                          (FFCrossAxisAlignment
                                                                  .center)
                                                              .flutterValue,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.draftRating =
                                                                  0.5;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              height: 48.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.draftRating =
                                                                  1.0;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              height: 48.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 46.0,
                                                height: 46.0,
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  children: [
                                                    if (((double? r) {
                                                          return (r ?? 0) >= 2;
                                                        }(_model
                                                            .draftRating)) ??
                                                        true)
                                                      Icon(
                                                        Icons.star_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 42.0,
                                                      ),
                                                    if (((double? r) {
                                                          return (r ?? 0) >=
                                                                  1.5 &&
                                                              (r ?? 0) < 2;
                                                        }(_model
                                                            .draftRating)) ??
                                                        true)
                                                      Icon(
                                                        Icons.star_half_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 42.0,
                                                      ),
                                                    if (((_model.draftRating ??
                                                                0) <
                                                            1.5) ??
                                                        true)
                                                      Icon(
                                                        Icons
                                                            .star_outline_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 42.0,
                                                      ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          (FFMainAxisAlignment
                                                                  .start)
                                                              .flutterValue,
                                                      crossAxisAlignment:
                                                          (FFCrossAxisAlignment
                                                                  .center)
                                                              .flutterValue,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.draftRating =
                                                                  1.5;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              height: 48.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.draftRating =
                                                                  2.0;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              height: 48.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 46.0,
                                                height: 46.0,
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  children: [
                                                    if (((double? r) {
                                                          return (r ?? 0) >= 3;
                                                        }(_model
                                                            .draftRating)) ??
                                                        true)
                                                      Icon(
                                                        Icons.star_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 42.0,
                                                      ),
                                                    if (((double? r) {
                                                          return (r ?? 0) >=
                                                                  2.5 &&
                                                              (r ?? 0) < 3;
                                                        }(_model
                                                            .draftRating)) ??
                                                        true)
                                                      Icon(
                                                        Icons.star_half_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 42.0,
                                                      ),
                                                    if (((_model.draftRating ??
                                                                0) <
                                                            2.5) ??
                                                        true)
                                                      Icon(
                                                        Icons
                                                            .star_outline_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 42.0,
                                                      ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          (FFMainAxisAlignment
                                                                  .start)
                                                              .flutterValue,
                                                      crossAxisAlignment:
                                                          (FFCrossAxisAlignment
                                                                  .center)
                                                              .flutterValue,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.draftRating =
                                                                  2.5;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              height: 48.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.draftRating =
                                                                  3.0;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              height: 48.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 46.0,
                                                height: 46.0,
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  children: [
                                                    if (((double? r) {
                                                          return (r ?? 0) >= 4;
                                                        }(_model
                                                            .draftRating)) ??
                                                        true)
                                                      Icon(
                                                        Icons.star_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 42.0,
                                                      ),
                                                    if (((double? r) {
                                                          return (r ?? 0) >=
                                                                  3.5 &&
                                                              (r ?? 0) < 4;
                                                        }(_model
                                                            .draftRating)) ??
                                                        true)
                                                      Icon(
                                                        Icons.star_half_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 42.0,
                                                      ),
                                                    if (((_model.draftRating ??
                                                                0) <
                                                            3.5) ??
                                                        true)
                                                      Icon(
                                                        Icons
                                                            .star_outline_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 42.0,
                                                      ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          (FFMainAxisAlignment
                                                                  .start)
                                                              .flutterValue,
                                                      crossAxisAlignment:
                                                          (FFCrossAxisAlignment
                                                                  .center)
                                                              .flutterValue,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.draftRating =
                                                                  3.5;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              height: 48.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.draftRating =
                                                                  4.0;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              height: 48.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 46.0,
                                                height: 46.0,
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  children: [
                                                    if (((double? r) {
                                                          return (r ?? 0) >= 5;
                                                        }(_model
                                                            .draftRating)) ??
                                                        true)
                                                      Icon(
                                                        Icons.star_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 42.0,
                                                      ),
                                                    if (((double? r) {
                                                          return (r ?? 0) >=
                                                                  4.5 &&
                                                              (r ?? 0) < 5;
                                                        }(_model
                                                            .draftRating)) ??
                                                        true)
                                                      Icon(
                                                        Icons.star_half_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 42.0,
                                                      ),
                                                    if (((_model.draftRating ??
                                                                0) <
                                                            4.5) ??
                                                        true)
                                                      Icon(
                                                        Icons
                                                            .star_outline_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 42.0,
                                                      ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          (FFMainAxisAlignment
                                                                  .start)
                                                              .flutterValue,
                                                      crossAxisAlignment:
                                                          (FFCrossAxisAlignment
                                                                  .center)
                                                              .flutterValue,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.draftRating =
                                                                  4.5;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              height: 48.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.draftRating =
                                                                  5.0;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              height: 48.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            ((double? r) {
                                              return (r ?? 0) < 0.5
                                                  ? 'Tap a star. Tap its left half for a half star.'
                                                  : '${(r ?? 0).toStringAsFixed(1)} / 5  ·  ' +
                                                      ((r ?? 0) <= 1
                                                          ? 'Awful'
                                                          : (r ?? 0) <= 2
                                                              ? 'Poor'
                                                              : (r ?? 0) <= 3
                                                                  ? 'Okay'
                                                                  : (r ?? 0) <=
                                                                          4
                                                                      ? 'Good'
                                                                      : 'Masterpiece');
                                            }(_model.draftRating)),
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          TextFormField(
                                            controller: _model
                                                .reviewCommentTextController,
                                            focusNode:
                                                _model.reviewCommentFocusNode,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintText:
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                'gmv175yu' /* Share your thoughts (optional) */,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              filled: true,
                                            ),
                                            style: TextStyle(),
                                            maxLines: 5,
                                            maxLength: 1000,
                                            validator: _model
                                                .reviewCommentTextControllerValidator
                                                .asValidator(context),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                (FFMainAxisAlignment.start)
                                                    .flutterValue,
                                            crossAxisAlignment:
                                                (FFCrossAxisAlignment.center)
                                                    .flutterValue,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              ToggleIcon(
                                                onPressed: () async {
                                                  safeSetState(() => _model
                                                          .draftSpoiler =
                                                      !_model.draftSpoiler!);
                                                },
                                                value: _model.draftSpoiler!,
                                                onIcon: Icon(
                                                  Icons.check_box_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  size: 24.0,
                                                ),
                                                offIcon: Icon(
                                                  Icons
                                                      .check_box_outline_blank_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 24.0,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'mu87t7ad' /* This review contains spoilers */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                (FFMainAxisAlignment.start)
                                                    .flutterValue,
                                            crossAxisAlignment:
                                                (FFCrossAxisAlignment.center)
                                                    .flutterValue,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              if (_model.isEditing ?? true)
                                                FFButtonWidget(
                                                  onPressed: () async {
                                                    _model.isEditing = false;
                                                    safeSetState(() {});
                                                    _model.draftRating =
                                                        _model.myRating;
                                                    safeSetState(() {});
                                                    _model.draftSpoiler =
                                                        _model.mySpoiler;
                                                    safeSetState(() {});
                                                    safeSetState(() {
                                                      _model.reviewCommentTextController
                                                              ?.text =
                                                          _model.myComment!;
                                                    });
                                                  },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    '29k951e1' /* Cancel */,
                                                  ),
                                                  options: FFButtonOptions(
                                                    height: 48.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: Colors.transparent,
                                                    textStyle: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                    ),
                                                    elevation: 0.0,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              Expanded(
                                                flex: 1,
                                                child: FFButtonWidget(
                                                  onPressed: _model
                                                          .isSubmitting!
                                                      ? null
                                                      : () async {
                                                          if (((_model.draftRating ??
                                                                  0) <
                                                              0.5)) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Choose a star rating first',
                                                                  style:
                                                                      TextStyle(),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                              ),
                                                            );
                                                          } else {
                                                            if (((String? t) {
                                                              return (t ?? '')
                                                                      .trim()
                                                                      .length >
                                                                  1000;
                                                            }(_model
                                                                .reviewCommentTextController
                                                                .text))) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Reviews can be at most 1000 characters.',
                                                                    style:
                                                                        TextStyle(),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                ),
                                                              );
                                                            } else {
                                                              _model.isSubmitting =
                                                                  true;
                                                              safeSetState(
                                                                  () {});
                                                              _model.saveResult =
                                                                  await actions
                                                                      .saveReview(
                                                                widget.movieId ??
                                                                    0,
                                                                widget.mediaType ==
                                                                        'tv'
                                                                    ? 'tv'
                                                                    : 'movie',
                                                                (String? v) {
                                                                  return v ??
                                                                      '';
                                                                }(_model
                                                                    .displayTitle),
                                                                (String? v) {
                                                                  return v ??
                                                                      '';
                                                                }(_model.details
                                                                    ?.posterPath),
                                                                _model.draftRating ??
                                                                    0.0,
                                                                _model
                                                                    .reviewCommentTextController
                                                                    .text,
                                                                _model.draftSpoiler ??
                                                                    false,
                                                                currentUserDisplayName,
                                                                '',
                                                              );
                                                              _model.isSubmitting =
                                                                  false;
                                                              safeSetState(
                                                                  () {});
                                                              if (_model
                                                                      .saveResult ==
                                                                  '') {
                                                                _model.myReviewMatches =
                                                                    await queryReviewsRecordOnce(
                                                                  queryBuilder: (reviewsRecord) =>
                                                                      reviewsRecord
                                                                          .where(
                                                                            'userId',
                                                                            isEqualTo:
                                                                                currentUserUid,
                                                                          )
                                                                          .where(
                                                                            'mediaKey',
                                                                            isEqualTo:
                                                                                (String? t, int? id) {
                                                                              return '${t ?? 'movie'}_${id}';
                                                                            }(widget.mediaType, widget.movieId),
                                                                          ),
                                                                  limit: 1,
                                                                );
                                                                _model
                                                                    .hasMyReview = !(_model
                                                                        .myReviewMatches
                                                                        ?.length ==
                                                                    0);
                                                                safeSetState(
                                                                    () {});
                                                                _model.myReviewDoc =
                                                                    await queryReviewsRecordOnce(
                                                                  queryBuilder: (reviewsRecord) =>
                                                                      reviewsRecord
                                                                          .where(
                                                                            'userId',
                                                                            isEqualTo:
                                                                                currentUserUid,
                                                                          )
                                                                          .where(
                                                                            'mediaKey',
                                                                            isEqualTo:
                                                                                (String? t, int? id) {
                                                                              return '${t ?? 'movie'}_${id}';
                                                                            }(widget.mediaType, widget.movieId),
                                                                          ),
                                                                  singleRecord:
                                                                      true,
                                                                ).then((s) => s
                                                                        .firstOrNull);
                                                                _model
                                                                    .myRating = _model
                                                                        .myReviewDoc
                                                                        ?.rating ??
                                                                    0.0;
                                                                safeSetState(
                                                                    () {});
                                                                _model.myComment =
                                                                    (String?
                                                                        v) {
                                                                  return v ??
                                                                      '';
                                                                }(_model.myReviewDoc
                                                                        ?.comment);
                                                                safeSetState(
                                                                    () {});
                                                                _model
                                                                    .mySpoiler = _model
                                                                        .myReviewDoc
                                                                        ?.containsSpoilers ??
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                                _model
                                                                    .draftRating = _model
                                                                        .myReviewDoc
                                                                        ?.rating ??
                                                                    0.0;
                                                                safeSetState(
                                                                    () {});
                                                                _model
                                                                    .draftSpoiler = _model
                                                                        .myReviewDoc
                                                                        ?.containsSpoilers ??
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                                _model.yAvg =
                                                                    await actions
                                                                        .getYelloAverage(
                                                                  (String? t,
                                                                          int? id) {
                                                                    return '${t ?? 'movie'}_${id}';
                                                                  }(
                                                                      widget
                                                                          .mediaType,
                                                                      widget
                                                                          .movieId),
                                                                );
                                                                _model.yelloAvg =
                                                                    _model.yAvg;
                                                                safeSetState(
                                                                    () {});
                                                                _model.yCount =
                                                                    await actions
                                                                        .getYelloRatingCount(
                                                                  (String? t,
                                                                          int? id) {
                                                                    return '${t ?? 'movie'}_${id}';
                                                                  }(
                                                                      widget
                                                                          .mediaType,
                                                                      widget
                                                                          .movieId),
                                                                );
                                                                _model.yelloCount =
                                                                    _model
                                                                        .yCount;
                                                                safeSetState(
                                                                    () {});
                                                                _model.isEditing =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Review saved',
                                                                      style:
                                                                          TextStyle(),
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                  ),
                                                                );
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      _model
                                                                          .saveResult!,
                                                                      style:
                                                                          TextStyle(),
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                  ),
                                                                );
                                                              }
                                                            }
                                                          }

                                                          safeSetState(() {});
                                                        },
                                                  text: _model.hasMyReview!
                                                      ? 'Update review'
                                                      : 'Post review',
                                                  icon: Icon(
                                                    Icons.send_rounded,
                                                    size: 20.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    height: 50.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    iconColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tertiary,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    textStyle: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                  ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 12.0)),
                                          ),
                                          if (_model.isSubmitting ?? true)
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  (FFMainAxisAlignment.center)
                                                      .flutterValue,
                                              crossAxisAlignment:
                                                  (FFCrossAxisAlignment.center)
                                                      .flutterValue,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              children: [
                                                CircularPercentIndicator(
                                                  percent: 0.0,
                                                  radius: 9.0,
                                                  lineWidth: 2.0,
                                                  animation: false,
                                                  animateFromLastPercent: true,
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '3hhqvfe7' /* Saving… */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ].divide(SizedBox(width: 12.0)),
                                            ),
                                        ].divide(SizedBox(height: 12.0)),
                                      ),
                                    ),
                                  ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      (FFMainAxisAlignment.spaceBetween)
                                          .flutterValue,
                                  crossAxisAlignment:
                                      (FFCrossAxisAlignment.center)
                                          .flutterValue,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'j2osd8ib' /* What Yello users say */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            font: GoogleFonts.sora(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'tt7sou2e' /* Newest first */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                                StreamBuilder<List<ReviewsRecord>>(
                                  stream: queryReviewsRecord(
                                    queryBuilder: (reviewsRecord) =>
                                        reviewsRecord
                                            .where(
                                              'mediaKey',
                                              isEqualTo: (String? t, int? id) {
                                                return '${t ?? 'movie'}_${id}';
                                              }(widget.mediaType,
                                                  widget.movieId),
                                            )
                                            .orderBy('createdAt',
                                                descending: true),
                                    limit: 100,
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return LoadingStateWidget(
                                        message: 'Loading reviews…',
                                      );
                                    }
                                    List<ReviewsRecord>
                                        reviewsListReviewsRecordList =
                                        snapshot.data!;
                                    if (reviewsListReviewsRecordList.isEmpty) {
                                      return EmptyStateWidget(
                                        message:
                                            'No reviews yet. Be the first to rate it.',
                                      );
                                    }

                                    return Builder(
                                      builder: (context) {
                                        final listItem =
                                            reviewsListReviewsRecordList
                                                .toList();
                                        if (listItem.isEmpty) {
                                          return EmptyStateWidget(
                                            message:
                                                'No reviews yet. Be the first to rate it.',
                                          );
                                        }

                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              (FFMainAxisAlignment.start)
                                                  .flutterValue,
                                          crossAxisAlignment:
                                              (FFCrossAxisAlignment.start)
                                                  .flutterValue,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: List.generate(
                                              listItem.length, (listItemIndex) {
                                            final listItemItem =
                                                listItem[listItemIndex];
                                            return Builder(
                                              builder: (context) =>
                                                  wrapWithModel(
                                                model: _model.reviewCardModels
                                                    .getModel(
                                                  listItemIndex.toString(),
                                                  listItemIndex,
                                                ),
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: ReviewCardWidget(
                                                  key: Key(
                                                    'Key9bh_${listItemIndex.toString()}',
                                                  ),
                                                  comment: listItemItem.comment,
                                                  containsSpoilers: listItemItem
                                                      .containsSpoilers,
                                                  createdAt:
                                                      listItemItem.createdAt,
                                                  isMine: listItemItem.userId ==
                                                      currentUserUid,
                                                  rating: listItemItem.rating,
                                                  updatedAt:
                                                      listItemItem.updatedAt,
                                                  userName:
                                                      listItemItem.userName,
                                                  userPhotoUrl:
                                                      listItemItem.userPhotoUrl,
                                                  userId: listItemItem.userId,
                                                  reviewId: (String? u,
                                                          String? m) {
                                                    return '${u}_${m}';
                                                  }(listItemItem.userId,
                                                      listItemItem.mediaKey),
                                                  movieId: widget.movieId,
                                                  mediaType: widget.mediaType,
                                                  showMenu: true,
                                                  onEdit: () async {
                                                    _model.draftRating =
                                                        _model.myRating;
                                                    safeSetState(() {});
                                                    _model.draftSpoiler =
                                                        _model.mySpoiler;
                                                    safeSetState(() {});
                                                    _model.isEditing = true;
                                                    safeSetState(() {});
                                                  },
                                                  onDelete: () async {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      dialogContext)
                                                                  .unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child:
                                                                DeleteReviewDialogWidget(
                                                              onConfirm:
                                                                  () async {
                                                                await _model
                                                                    .deleteMyReviewFlow(
                                                                        context);
                                                                if (!_model
                                                                    .hasMyReview!) {
                                                                  safeSetState(
                                                                      () {
                                                                    _model
                                                                        .reviewCommentTextController
                                                                        ?.clear();
                                                                  });
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          }).divide(SizedBox(height: 12.0)),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
