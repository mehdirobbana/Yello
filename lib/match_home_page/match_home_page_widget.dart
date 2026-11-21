import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'match_home_page_model.dart';
export 'match_home_page_model.dart';

/// Movie Match: create a room, join with a code, or accept an invitation.
class MatchHomePageWidget extends StatefulWidget {
  const MatchHomePageWidget({super.key});

  static String routeName = 'MatchHomePage';
  static String routePath = '/match';

  @override
  State<MatchHomePageWidget> createState() => _MatchHomePageWidgetState();
}

class _MatchHomePageWidgetState extends State<MatchHomePageWidget> {
  late MatchHomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MatchHomePageModel());

    _model.joinCodeFieldTextController ??= TextEditingController();
    _model.joinCodeFieldFocusNode ??= FocusNode();

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
              'pzj8hp15' /* Movie Match */,
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
                  Text(
                    FFLocalizations.of(context).getText(
                      'flxd699c' /* Pick a movie together */,
                    ),
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          font: GoogleFonts.sora(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      _model.newCode = (100000 +
                              (DateTime.now().microsecondsSinceEpoch * 1) %
                                  900000)
                          .toString();
                      safeSetState(() {});
                      _model.codeTaken = await queryRoomsRecordOnce(
                        queryBuilder: (roomsRecord) => roomsRecord.where(
                          'code',
                          isEqualTo: _model.newCode,
                        ),
                      );
                      if (((_model.codeTaken?.length ?? 0) > 0)) {
                        _model.newCode = (100000 +
                                (DateTime.now().microsecondsSinceEpoch * 7919) %
                                    900000)
                            .toString();
                        safeSetState(() {});
                      }
                      _model.deckTrending =
                          await TMDBApiGroup.tmdbTrendingMoviesCall.call();

                      if ((_model.deckTrending?.succeeded ?? true)) {
                        _model.deckResponse =
                            MediaListResponseStruct.maybeFromMap(
                                (_model.deckTrending?.jsonBody ?? ''));
                        safeSetState(() {});

                        var roomsRecordReference = RoomsRecord.collection.doc();
                        await roomsRecordReference.set({
                          ...createRoomsRecordData(
                            code: _model.newCode,
                            hostId: currentUserUid,
                            status: 'waiting',
                            round: 1,
                            matchedMovieId: 0,
                            createdAt: DateTime.now(),
                          ),
                          ...mapToFirestore(
                            {
                              'memberIds': (List<String>? l, String? v) {
                                return <String>{...?l, if (v != null) v}
                                    .toList();
                              }((<String>[]).toList(), currentUserUid),
                              'invitedIds': <String>[],
                              'deckMovieIds': (MediaListResponseStruct? d) {
                                return (d?.results ?? [])
                                    .take(20)
                                    .map((e) => e.id)
                                    .toList();
                              }(_model.deckResponse),
                            },
                          ),
                        });
                        _model.document = RoomsRecord.getDocumentFromData({
                          ...createRoomsRecordData(
                            code: _model.newCode,
                            hostId: currentUserUid,
                            status: 'waiting',
                            round: 1,
                            matchedMovieId: 0,
                            createdAt: DateTime.now(),
                          ),
                          ...mapToFirestore(
                            {
                              'memberIds': (List<String>? l, String? v) {
                                return <String>{...?l, if (v != null) v}
                                    .toList();
                              }((<String>[]).toList(), currentUserUid),
                              'invitedIds': <String>[],
                              'deckMovieIds': (MediaListResponseStruct? d) {
                                return (d?.results ?? [])
                                    .take(20)
                                    .map((e) => e.id)
                                    .toList();
                              }(_model.deckResponse),
                            },
                          ),
                        }, roomsRecordReference);

                        context.pushNamed(
                          MatchLobbyPageWidget.routeName,
                          queryParameters: {
                            'code': serializeParam(
                              _model.newCode,
                              ParamType.String,
                            ),
                          }.withoutNulls,
                          extra: <String, dynamic>{
                            '__transition_info__': TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 250),
                            ),
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Could not load movies. Please try again.',
                              style: TextStyle(),
                            ),
                            duration: Duration(milliseconds: 4000),
                          ),
                        );
                      }

                      safeSetState(() {});
                    },
                    text: FFLocalizations.of(context).getText(
                      'kblxtvcx' /* Create room */,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: TextStyle(
                        color: FlutterFlowTheme.of(context).tertiary,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed(YelloPicksPageWidget.routeName);
                    },
                    text: FFLocalizations.of(context).getText(
                      'qundsc16' /* Build a deck with Yello Picks */,
                    ),
                    icon: Icon(
                      Icons.auto_awesome_rounded,
                      size: 20.0,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 48.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconColor: FlutterFlowTheme.of(context).primaryText,
                      color: Colors.transparent,
                      textStyle: TextStyle(
                        color: FlutterFlowTheme.of(context).secondary,
                      ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).accent2,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'dy2an9o7' /* Join with a code */,
                    ),
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.sora(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
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
                  TextFormField(
                    controller: _model.joinCodeFieldTextController,
                    focusNode: _model.joinCodeFieldFocusNode,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.joinCodeFieldTextController',
                      Duration(milliseconds: 2000),
                      () async {
                        _model.joinCode =
                            _model.joinCodeFieldTextController.text;
                        safeSetState(() {});
                      },
                    ),
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: FFLocalizations.of(context).getText(
                        'eoqxfj5s' /* 6-digit code */,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      filled: true,
                    ),
                    style: TextStyle(),
                    maxLines: null,
                    validator: _model.joinCodeFieldTextControllerValidator
                        .asValidator(context),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      _model.joinRoom = await queryRoomsRecordOnce(
                        queryBuilder: (roomsRecord) => roomsRecord.where(
                          'code',
                          isEqualTo: _model.joinCode,
                        ),
                        limit: 1,
                      );
                      if (_model.joinRoom?.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'No room with that code.',
                              style: TextStyle(),
                            ),
                            duration: Duration(milliseconds: 4000),
                          ),
                        );
                      } else {
                        for (int loop1Index = 0;
                            loop1Index < _model.joinRoom!.length;
                            loop1Index++) {
                          final currentLoop1Item = _model.joinRoom![loop1Index];

                          await currentLoop1Item.reference.update({
                            ...mapToFirestore(
                              {
                                'memberIds': (List<String>? l, String? v) {
                                  return <String>{...?l, if (v != null) v}
                                      .toList();
                                }(currentLoop1Item.memberIds.toList(),
                                    currentUserUid),
                                'invitedIds': (List<String>? l, String? v) {
                                  return (l ?? <String>[])
                                      .where((x) => x != v)
                                      .toList();
                                }(currentLoop1Item.invitedIds.toList(),
                                    currentUserUid),
                              },
                            ),
                          });
                        }

                        context.pushNamed(
                          MatchLobbyPageWidget.routeName,
                          queryParameters: {
                            'code': serializeParam(
                              _model.joinCode,
                              ParamType.String,
                            ),
                          }.withoutNulls,
                          extra: <String, dynamic>{
                            '__transition_info__': TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 250),
                            ),
                          },
                        );
                      }

                      safeSetState(() {});
                    },
                    text: FFLocalizations.of(context).getText(
                      'nji6wyhc' /* Join */,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 48.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Colors.transparent,
                      textStyle: TextStyle(
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).accent2,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      '7oo46opc' /* Invitations */,
                    ),
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.sora(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
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
                  StreamBuilder<List<RoomsRecord>>(
                    stream: queryRoomsRecord(
                      queryBuilder: (roomsRecord) => roomsRecord.where(
                        'invitedIds',
                        arrayContains: currentUserUid,
                      ),
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
                      List<RoomsRecord> columnRoomsRecordList = snapshot.data!;

                      return Builder(
                        builder: (context) {
                          final listItem = columnRoomsRecordList.toList();

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
                              return Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Row(
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
                                        ((String? c) {
                                          return 'Room ${c}';
                                        }(listItemItem.code)),
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
                                      FFButtonWidget(
                                        onPressed: () async {
                                          await listItemItem.reference.update({
                                            ...mapToFirestore(
                                              {
                                                'memberIds': (List<String>? l,
                                                        String? v) {
                                                  return <String>{
                                                    ...?l,
                                                    if (v != null) v
                                                  }.toList();
                                                }(
                                                    listItemItem.memberIds
                                                        .toList(),
                                                    currentUserUid),
                                                'invitedIds': (List<String>? l,
                                                        String? v) {
                                                  return (l ?? <String>[])
                                                      .where((x) => x != v)
                                                      .toList();
                                                }(
                                                    listItemItem.invitedIds
                                                        .toList(),
                                                    currentUserUid),
                                              },
                                            ),
                                          });

                                          context.pushNamed(
                                            MatchLobbyPageWidget.routeName,
                                            queryParameters: {
                                              'code': serializeParam(
                                                listItemItem.code,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              '__transition_info__':
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType
                                                        .rightToLeft,
                                                duration:
                                                    Duration(milliseconds: 250),
                                              ),
                                            },
                                          );
                                        },
                                        text:
                                            FFLocalizations.of(context).getText(
                                          '8uzbcc1i' /* Accept */,
                                        ),
                                        options: FFButtonOptions(
                                          width: 110.0,
                                          height: 48.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                    ],
                                  ),
                                ),
                              );
                            }).divide(SizedBox(height: 8.0)),
                          );
                        },
                      );
                    },
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
