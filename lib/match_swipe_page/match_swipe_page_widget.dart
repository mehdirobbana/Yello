import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'match_swipe_page_model.dart';
export 'match_swipe_page_model.dart';

/// Swipe the room deck (Pass / Like).
///
/// Shows the match when everyone likes the same movie.
class MatchSwipePageWidget extends StatefulWidget {
  const MatchSwipePageWidget({
    super.key,
    String? code,
  }) : this.code = code ?? '';

  final String code;

  static String routeName = 'MatchSwipePage';
  static String routePath = '/match/swipe';

  @override
  State<MatchSwipePageWidget> createState() => _MatchSwipePageWidgetState();
}

class _MatchSwipePageWidgetState extends State<MatchSwipePageWidget> {
  late MatchSwipePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MatchSwipePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.swipeRoom = await queryRoomsRecordOnce(
        queryBuilder: (roomsRecord) => roomsRecord.where(
          'code',
          isEqualTo: widget.code,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      _model.roomRef = _model.swipeRoom?.reference;
      safeSetState(() {});
      _model.deck = _model.swipeRoom!.deckMovieIds.toList().cast<int>();
      safeSetState(() {});
      _model.round = _model.swipeRoom?.round;
      safeSetState(() {});
      _model.index = 0;
      safeSetState(() {});
      if (((int? i, List<int>? d) {
        return (i ?? 0) < (d ?? <int>[]).length;
      }(_model.index, _model.deck.toList()))) {
        _model.cardOnLoad = await TMDBApiGroup.tmdbMovieDetailsCall.call(
          id: (List<int>? d, int? i) {
            return (d ?? <int>[])[i ?? 0];
          }(_model.deck.toList(), _model.index),
        );

        if ((_model.cardOnLoad?.succeeded ?? true)) {
          _model.card = MediaDetailsStruct.maybeFromMap(
              (_model.cardOnLoad?.jsonBody ?? ''));
          safeSetState(() {});
        }
      }
    });

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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          iconTheme:
              IconThemeData(color: FlutterFlowTheme.of(context).primaryText),
          automaticallyImplyLeading: true,
          title: Text(
            FFLocalizations.of(context).getText(
              'te5473ee' /* Movie Match */,
            ),
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  font: GoogleFonts.sora(
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleLarge.fontStyle,
                  ),
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  StreamBuilder<List<RoomsRecord>>(
                    stream: queryRoomsRecord(
                      queryBuilder: (roomsRecord) => roomsRecord.where(
                        'code',
                        isEqualTo: widget.code,
                      ),
                      limit: 1,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).secondary,
                              ),
                            ),
                          ),
                        );
                      }
                      List<RoomsRecord> swipeRoomLiveRoomsRecordList =
                          snapshot.data!;

                      return Builder(
                        builder: (context) {
                          final listItem =
                              swipeRoomLiveRoomsRecordList.toList();

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                                (FFMainAxisAlignment.start).flutterValue,
                            crossAxisAlignment:
                                (FFCrossAxisAlignment.center).flutterValue,
                            textBaseline: TextBaseline.alphabetic,
                            children:
                                List.generate(listItem.length, (listItemIndex) {
                              final listItemItem = listItem[listItemIndex];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    (FFMainAxisAlignment.start).flutterValue,
                                crossAxisAlignment:
                                    (FFCrossAxisAlignment.center).flutterValue,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  if (((String? s, int? r, int? lr) {
                                        return s == 'swiping' && r != lr;
                                      }(listItemItem.status, listItemItem.round,
                                          _model.round)) ??
                                      true)
                                    FFButtonWidget(
                                      onPressed: () async {
                                        _model.deck = listItemItem.deckMovieIds
                                            .toList()
                                            .cast<int>();
                                        safeSetState(() {});
                                        _model.round = listItemItem.round;
                                        safeSetState(() {});
                                        _model.index = 0;
                                        safeSetState(() {});
                                        if (((int? i, List<int>? d) {
                                          return (i ?? 0) <
                                              (d ?? <int>[]).length;
                                        }(_model.index,
                                            _model.deck.toList()))) {
                                          _model.cardRound = await TMDBApiGroup
                                              .tmdbMovieDetailsCall
                                              .call(
                                            id: (List<int>? d, int? i) {
                                              return (d ?? <int>[])[i ?? 0];
                                            }(_model.deck.toList(),
                                                _model.index),
                                          );

                                          if ((_model.cardRound?.succeeded ??
                                              true)) {
                                            _model.card =
                                                MediaDetailsStruct.maybeFromMap(
                                                    (_model.cardRound
                                                            ?.jsonBody ??
                                                        ''));
                                            safeSetState(() {});
                                          }
                                        }

                                        safeSetState(() {});
                                      },
                                      text: FFLocalizations.of(context).getText(
                                        'b78gmji8' /* New round started. Continue */,
                                      ),
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 48.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                    ),
                                  if (((String? s, int? r, int? lr, int? i,
                                              List<int>? d) {
                                        return s == 'swiping' &&
                                            r == lr &&
                                            (i ?? 0) < (d ?? <int>[]).length;
                                      }(
                                          listItemItem.status,
                                          listItemItem.round,
                                          _model.round,
                                          _model.index,
                                          _model.deck.toList())) ??
                                      true)
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.start)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.center)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                                Duration(milliseconds: 500),
                                            fadeOutDuration:
                                                Duration(milliseconds: 500),
                                            imageUrl: ((String? p) {
                                              return 'https://image.tmdb.org/t/p/w500${p}';
                                            }(_model.card?.posterPath)),
                                            width: double.infinity,
                                            height: 420.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          _model.card!.title,
                                          maxLines: 2,
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .override(
                                                font: GoogleFonts.sora(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                        Text(
                                          ((String? y, double? r) {
                                            return '${(y ?? '').length >= 4 ? y!.substring(0, 4) : ''}  ·  ${(r ?? 0).toStringAsFixed(1)} / 10';
                                          }(_model.card?.releaseDate,
                                              _model.card?.voteAverage)),
                                          style: FlutterFlowTheme.of(context)
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              (FFMainAxisAlignment.center)
                                                  .flutterValue,
                                          crossAxisAlignment:
                                              (FFCrossAxisAlignment.center)
                                                  .flutterValue,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            FFButtonWidget(
                                              onPressed: _model.busy!
                                                  ? null
                                                  : () async {
                                                      if (!_model.busy!) {
                                                        _model.busy = true;
                                                        safeSetState(() {});

                                                        var roomSwipesRecordReference =
                                                            RoomSwipesRecord
                                                                .collection
                                                                .doc();
                                                        await roomSwipesRecordReference
                                                            .set(
                                                                createRoomSwipesRecordData(
                                                          userId:
                                                              currentUserUid,
                                                          roomId: widget.code,
                                                          round: _model.round,
                                                          movieId:
                                                              (List<int>? d,
                                                                      int? i) {
                                                            return (d ??
                                                                    <int>[])[
                                                                i ?? 0];
                                                          }(
                                                                  _model.deck
                                                                      .toList(),
                                                                  _model.index),
                                                          liked: false,
                                                          createdAt:
                                                              DateTime.now(),
                                                        ));
                                                        _model.document = RoomSwipesRecord
                                                            .getDocumentFromData(
                                                                createRoomSwipesRecordData(
                                                                  userId:
                                                                      currentUserUid,
                                                                  roomId:
                                                                      widget
                                                                          .code,
                                                                  round: _model
                                                                      .round,
                                                                  movieId: (List<int>?
                                                                              d,
                                                                          int? i) {
                                                                    return (d ??
                                                                            <int>[])[
                                                                        i ?? 0];
                                                                  }(
                                                                      _model
                                                                          .deck
                                                                          .toList(),
                                                                      _model
                                                                          .index),
                                                                  liked: false,
                                                                  createdAt:
                                                                      DateTime
                                                                          .now(),
                                                                ),
                                                                roomSwipesRecordReference);
                                                        _model.index =
                                                            (_model.index ??
                                                                    0) +
                                                                1;
                                                        safeSetState(() {});
                                                        if (((int? i,
                                                                List<int>? d) {
                                                          return (i ?? 0) <
                                                              (d ?? <int>[])
                                                                  .length;
                                                        }(
                                                            _model.index,
                                                            _model.deck
                                                                .toList()))) {
                                                          _model.cardPass =
                                                              await TMDBApiGroup
                                                                  .tmdbMovieDetailsCall
                                                                  .call(
                                                            id: (List<int>? d,
                                                                    int? i) {
                                                              return (d ??
                                                                      <int>[])[
                                                                  i ?? 0];
                                                            }(
                                                                _model.deck
                                                                    .toList(),
                                                                _model.index),
                                                          );

                                                          if ((_model.cardPass
                                                                  ?.succeeded ??
                                                              true)) {
                                                            _model.card = MediaDetailsStruct
                                                                .maybeFromMap((_model
                                                                        .cardPass
                                                                        ?.jsonBody ??
                                                                    ''));
                                                            safeSetState(() {});
                                                          }
                                                        }
                                                        _model.busy = false;
                                                        safeSetState(() {});
                                                      }

                                                      safeSetState(() {});
                                                    },
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                '2utfxm5s' /* Pass */,
                                              ),
                                              icon: Icon(
                                                Icons.close_rounded,
                                                size: 20.0,
                                              ),
                                              options: FFButtonOptions(
                                                width: 140.0,
                                                height: 50.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                iconColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                color: Colors.transparent,
                                                textStyle: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                                elevation: 0.0,
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .accent2,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                            ),
                                            FFButtonWidget(
                                              onPressed: _model.busy!
                                                  ? null
                                                  : () async {
                                                      if (!_model.busy!) {
                                                        _model.busy = true;
                                                        safeSetState(() {});

                                                        var roomSwipesRecordReference =
                                                            RoomSwipesRecord
                                                                .collection
                                                                .doc();
                                                        await roomSwipesRecordReference
                                                            .set(
                                                                createRoomSwipesRecordData(
                                                          userId:
                                                              currentUserUid,
                                                          roomId: widget.code,
                                                          round: _model.round,
                                                          movieId:
                                                              (List<int>? d,
                                                                      int? i) {
                                                            return (d ??
                                                                    <int>[])[
                                                                i ?? 0];
                                                          }(
                                                                  _model.deck
                                                                      .toList(),
                                                                  _model.index),
                                                          liked: true,
                                                          createdAt:
                                                              DateTime.now(),
                                                        ));
                                                        _model.document2 = RoomSwipesRecord
                                                            .getDocumentFromData(
                                                                createRoomSwipesRecordData(
                                                                  userId:
                                                                      currentUserUid,
                                                                  roomId:
                                                                      widget
                                                                          .code,
                                                                  round: _model
                                                                      .round,
                                                                  movieId: (List<int>?
                                                                              d,
                                                                          int? i) {
                                                                    return (d ??
                                                                            <int>[])[
                                                                        i ?? 0];
                                                                  }(
                                                                      _model
                                                                          .deck
                                                                          .toList(),
                                                                      _model
                                                                          .index),
                                                                  liked: true,
                                                                  createdAt:
                                                                      DateTime
                                                                          .now(),
                                                                ),
                                                                roomSwipesRecordReference);
                                                        _model.likesLike =
                                                            await queryRoomSwipesRecordOnce(
                                                          queryBuilder:
                                                              (roomSwipesRecord) =>
                                                                  roomSwipesRecord
                                                                      .where(
                                                                        'roomId',
                                                                        isEqualTo:
                                                                            widget.code,
                                                                      )
                                                                      .where(
                                                                        'round',
                                                                        isEqualTo:
                                                                            _model.round,
                                                                      )
                                                                      .where(
                                                                        'movieId',
                                                                        isEqualTo: (List<int>?
                                                                                d,
                                                                            int?
                                                                                i) {
                                                                          return (d ??
                                                                              <int>[])[i ?? 0];
                                                                        }(_model.deck.toList(), _model.index),
                                                                      )
                                                                      .where(
                                                                        'liked',
                                                                        isEqualTo:
                                                                            true,
                                                                      ),
                                                        );
                                                        _model.roomLike =
                                                            await RoomsRecord
                                                                .getDocumentOnce(
                                                                    _model
                                                                        .roomRef!);
                                                        if (((int? c,
                                                                List<String>? m) {
                                                          return (c ?? 0) >=
                                                              (m ?? []).length;
                                                        }(
                                                            _model.likesLike
                                                                ?.length,
                                                            _model.roomLike
                                                                ?.memberIds
                                                                .toList()))) {
                                                          await _model.roomRef!
                                                              .update(
                                                                  createRoomsRecordData(
                                                            status: 'matched',
                                                            matchedMovieId:
                                                                (List<int>? d,
                                                                        int? i) {
                                                              return (d ??
                                                                      <int>[])[
                                                                  i ?? 0];
                                                            }(
                                                                    _model.deck
                                                                        .toList(),
                                                                    _model
                                                                        .index),
                                                            matchedTitle: _model
                                                                .card?.title,
                                                            matchedPosterPath:
                                                                _model.card
                                                                    ?.posterPath,
                                                            matchedBackdropPath:
                                                                _model.card
                                                                    ?.backdropPath,
                                                          ));
                                                        }
                                                        _model.index =
                                                            (_model.index ??
                                                                    0) +
                                                                1;
                                                        safeSetState(() {});
                                                        if (((int? i,
                                                                List<int>? d) {
                                                          return (i ?? 0) <
                                                              (d ?? <int>[])
                                                                  .length;
                                                        }(
                                                            _model.index,
                                                            _model.deck
                                                                .toList()))) {
                                                          _model.cardLike =
                                                              await TMDBApiGroup
                                                                  .tmdbMovieDetailsCall
                                                                  .call(
                                                            id: (List<int>? d,
                                                                    int? i) {
                                                              return (d ??
                                                                      <int>[])[
                                                                  i ?? 0];
                                                            }(
                                                                _model.deck
                                                                    .toList(),
                                                                _model.index),
                                                          );

                                                          if ((_model.cardLike
                                                                  ?.succeeded ??
                                                              true)) {
                                                            _model.card = MediaDetailsStruct
                                                                .maybeFromMap((_model
                                                                        .cardLike
                                                                        ?.jsonBody ??
                                                                    ''));
                                                            safeSetState(() {});
                                                          }
                                                        }
                                                        _model.busy = false;
                                                        safeSetState(() {});
                                                      }

                                                      safeSetState(() {});
                                                    },
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                '3ofx31fl' /* Like */,
                                              ),
                                              icon: Icon(
                                                Icons.favorite_rounded,
                                                size: 20.0,
                                              ),
                                              options: FFButtonOptions(
                                                width: 140.0,
                                                height: 50.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                iconColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                textStyle: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiary,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 16.0)),
                                        ),
                                      ].divide(SizedBox(height: 12.0)),
                                    ),
                                  if (((String? s, int? r, int? lr, int? i,
                                              List<int>? d) {
                                        return s == 'swiping' &&
                                            r == lr &&
                                            (d ?? <int>[]).isNotEmpty &&
                                            (i ?? 0) >= (d ?? <int>[]).length;
                                      }(
                                          listItemItem.status,
                                          listItemItem.round,
                                          _model.round,
                                          _model.index,
                                          _model.deck.toList())) ??
                                      true)
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.start)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.center)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '9avbu6w7' /* No match this time */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                font: GoogleFonts.sora(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            't90wffx0' /* You went through the whole dec... */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        if (listItemItem.hostId ==
                                            currentUserUid)
                                          FFButtonWidget(
                                            onPressed: () async {
                                              _model.restartDeck =
                                                  await TMDBApiGroup
                                                      .tmdbPopularMoviesCall
                                                      .call();

                                              if ((_model
                                                      .restartDeck?.succeeded ??
                                                  true)) {
                                                _model.deckResponse =
                                                    MediaListResponseStruct
                                                        .maybeFromMap((_model
                                                                .restartDeck
                                                                ?.jsonBody ??
                                                            ''));
                                                safeSetState(() {});

                                                await _model.roomRef!.update({
                                                  ...createRoomsRecordData(
                                                    round:
                                                        (_model.round ?? 0) + 1,
                                                    status: 'swiping',
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'deckMovieIds':
                                                          (MediaListResponseStruct?
                                                              d) {
                                                        return (d?.results ??
                                                                [])
                                                            .take(20)
                                                            .map((e) => e.id)
                                                            .toList();
                                                      }(_model.deckResponse),
                                                    },
                                                  ),
                                                });
                                                _model.deck =
                                                    ((MediaListResponseStruct?
                                                            d) {
                                                  return (d?.results ?? [])
                                                      .take(20)
                                                      .map((e) => e.id)
                                                      .toList();
                                                }(_model.deckResponse))
                                                        .toList()
                                                        .cast<int>();
                                                safeSetState(() {});
                                                _model.round =
                                                    (_model.round ?? 0) + 1;
                                                safeSetState(() {});
                                                _model.index = 0;
                                                safeSetState(() {});
                                                if (((int? i, List<int>? d) {
                                                  return (i ?? 0) <
                                                      (d ?? <int>[]).length;
                                                }(_model.index,
                                                    _model.deck.toList()))) {
                                                  _model.cardRestart =
                                                      await TMDBApiGroup
                                                          .tmdbMovieDetailsCall
                                                          .call(
                                                    id: (List<int>? d, int? i) {
                                                      return (d ??
                                                          <int>[])[i ?? 0];
                                                    }(_model.deck.toList(),
                                                        _model.index),
                                                  );

                                                  if ((_model.cardRestart
                                                          ?.succeeded ??
                                                      true)) {
                                                    _model.card =
                                                        MediaDetailsStruct
                                                            .maybeFromMap((_model
                                                                    .cardRestart
                                                                    ?.jsonBody ??
                                                                ''));
                                                    safeSetState(() {});
                                                  }
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Could not load a new deck. Please try again.',
                                                      style: TextStyle(),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                  ),
                                                );
                                              }

                                              safeSetState(() {});
                                            },
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              '1sdwu4jf' /* Restart with a new deck */,
                                            ),
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 50.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                      ].divide(SizedBox(height: 12.0)),
                                    ),
                                  if (((String? s) {
                                        return s == 'matched';
                                      }(listItemItem.status)) ??
                                      true)
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.start)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.center)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                                Duration(milliseconds: 500),
                                            fadeOutDuration:
                                                Duration(milliseconds: 500),
                                            imageUrl: ((String? p) {
                                              return 'https://image.tmdb.org/t/p/w780${p}';
                                            }(listItemItem
                                                .matchedBackdropPath)),
                                            width: double.infinity,
                                            height: 220.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '4985dy0z' /* It's a match! */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                font: GoogleFonts.sora(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Text(
                                          listItemItem.matchedTitle,
                                          maxLines: 2,
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .override(
                                                font: GoogleFonts.sora(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            context.pushNamed(
                                              MovieDetailsPageWidget.routeName,
                                              queryParameters: {
                                                'movieId': serializeParam(
                                                  listItemItem.matchedMovieId,
                                                  ParamType.int,
                                                ),
                                                'mediaType': serializeParam(
                                                  'movie',
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                '__transition_info__':
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                ),
                                              },
                                            );
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'cp2ywg5h' /* Open details */,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 50.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
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
                                        FFButtonWidget(
                                          onPressed: () async {
                                            _model.matchInWatchlist =
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
                                                        isEqualTo: (int? id) {
                                                          return 'movie_${id}';
                                                        }(listItemItem
                                                            .matchedMovieId),
                                                      ),
                                            );
                                            if (_model
                                                    .matchInWatchlist?.length ==
                                                0) {
                                              var watchlistRecordReference =
                                                  WatchlistRecord.collection
                                                      .doc();
                                              await watchlistRecordReference
                                                  .set(
                                                      createWatchlistRecordData(
                                                userId: currentUserUid,
                                                mediaKey: (int? id) {
                                                  return 'movie_${id}';
                                                }(listItemItem.matchedMovieId),
                                                mediaType: 'movie',
                                                tmdbId:
                                                    listItemItem.matchedMovieId,
                                                title:
                                                    listItemItem.matchedTitle,
                                                posterPath: listItemItem
                                                    .matchedPosterPath,
                                                createdAt: DateTime.now(),
                                              ));
                                              _model.document3 = WatchlistRecord
                                                  .getDocumentFromData(
                                                      createWatchlistRecordData(
                                                        userId: currentUserUid,
                                                        mediaKey: (int? id) {
                                                          return 'movie_${id}';
                                                        }(listItemItem
                                                            .matchedMovieId),
                                                        mediaType: 'movie',
                                                        tmdbId: listItemItem
                                                            .matchedMovieId,
                                                        title: listItemItem
                                                            .matchedTitle,
                                                        posterPath: listItemItem
                                                            .matchedPosterPath,
                                                        createdAt:
                                                            DateTime.now(),
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
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Already in your watchlist',
                                                    style: TextStyle(),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'vfnqz4ew' /* Add to my watchlist */,
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
                                      ].divide(SizedBox(height: 12.0)),
                                    ),
                                ].divide(SizedBox(height: 12.0)),
                              );
                            }),
                          );
                        },
                      );
                    },
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
