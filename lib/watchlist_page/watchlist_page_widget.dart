import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_state_widget.dart';
import '/components/media_list_tile_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'watchlist_page_model.dart';
export 'watchlist_page_model.dart';

/// Saved movies of the user (shell, built in feature 5)
class WatchlistPageWidget extends StatefulWidget {
  const WatchlistPageWidget({super.key});

  static String routeName = 'WatchlistPage';
  static String routePath = '/watchlist';

  @override
  State<WatchlistPageWidget> createState() => _WatchlistPageWidgetState();
}

class _WatchlistPageWidgetState extends State<WatchlistPageWidget> {
  late WatchlistPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WatchlistPageModel());

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
            crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Container(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                        (FFMainAxisAlignment.spaceBetween).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.center).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment:
                              (FFMainAxisAlignment.start).flutterValue,
                          crossAxisAlignment:
                              (FFCrossAxisAlignment.start).flutterValue,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'u9y18bj6' /* Watchlist */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    font: GoogleFonts.sora(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                            ),
                            Text(
                              FFLocalizations.of(context).getText(
                                'zq0t3zyd' /* Saved for movie night */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
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
                                  ),
                            ),
                          ].divide(SizedBox(height: 4.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: StreamBuilder<List<WatchlistRecord>>(
                    stream: queryWatchlistRecord(
                      queryBuilder: (watchlistRecord) => watchlistRecord
                          .where(
                            'userId',
                            isEqualTo: currentUserUid,
                          )
                          .orderBy('createdAt', descending: true),
                      limit: 200,
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
                      List<WatchlistRecord> listViewWatchlistRecordList =
                          snapshot.data!;
                      if (listViewWatchlistRecordList.isEmpty) {
                        return EmptyStateWidget(
                          message:
                              'Your watchlist is empty. Tap Watchlist on any title.',
                        );
                      }

                      return Builder(
                        builder: (context) {
                          final listItem = listViewWatchlistRecordList.toList();
                          if (listItem.isEmpty) {
                            return EmptyStateWidget(
                              message:
                                  'Your watchlist is empty. Tap Watchlist on any title.',
                            );
                          }

                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            primary: false,
                            scrollDirection: Axis.vertical,
                            itemCount: listItem.length,
                            separatorBuilder: (_, __) => SizedBox(height: 12.0),
                            itemBuilder: (context, listItemIndex) {
                              final listItemItem = listItem[listItemIndex];
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    (FFMainAxisAlignment.start).flutterValue,
                                crossAxisAlignment:
                                    (FFCrossAxisAlignment.center).flutterValue,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model:
                                          _model.mediaListTileModels.getModel(
                                        listItemIndex.toString(),
                                        listItemIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: MediaListTileWidget(
                                        key: Key(
                                          'Key1yj_${listItemIndex.toString()}',
                                        ),
                                        date: '',
                                        mediaType: listItemItem.mediaType,
                                        posterPath: listItemItem.posterPath,
                                        title: listItemItem.title,
                                        tmdbId: listItemItem.tmdbId,
                                        voteAverage: listItemItem.voteAverage,
                                      ),
                                    ),
                                  ),
                                  AlignedTooltip(
                                    content: Text(
                                      FFLocalizations.of(context).getText(
                                        'ttremov1' /* Remove */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    preferredDirection: AxisDirection.down,
                                    borderRadius: BorderRadius.circular(8.0),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    elevation: 0.0,
                                    tailBaseWidth: 0.0,
                                    tailLength: 0.0,
                                    waitDuration: Duration(milliseconds: 0),
                                    showDuration: Duration(milliseconds: 0),
                                    triggerMode: TooltipTriggerMode.longPress,
                                    child: FlutterFlowIconButton(
                                      borderRadius: 24.0,
                                      buttonSize: 48.0,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 22.0,
                                      ),
                                      onPressed: () async {
                                        await listItemItem.reference.delete();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Removed from your watchlist',
                                              style: TextStyle(),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ].divide(SizedBox(height: 8.0)),
          ),
        ),
      ),
    );
  }
}
