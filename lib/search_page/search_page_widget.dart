import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/empty_state_widget.dart';
import '/components/loading_state_widget.dart';
import '/components/media_list_tile_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'search_page_model.dart';
export 'search_page_model.dart';

/// Search movies by title (shell, built in feature 3)
class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({super.key});

  static String routeName = 'SearchPage';
  static String routePath = '/search';

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  late SearchPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.isLoading = true;
      safeSetState(() {});
      _model.initialPage = await actions.fetchTitles(
        _model.query,
        _model.mediaType,
        _model.genre,
        _model.year,
        _model.minRating,
        _model.sortBy,
        1,
      );
      if (((_model.initialPage?.page ?? 0) > 0)) {
        _model.results =
            _model.initialPage!.results.toList().cast<MediaItemStruct>();
        safeSetState(() {});
        _model.page = 1;
        safeSetState(() {});
        _model.totalPages = _model.initialPage?.totalPages;
        safeSetState(() {});
      } else {
        _model.loadError =
            'Couldn\'t load titles. Check your connection and try again.';
        safeSetState(() {});
      }

      _model.isLoading = false;
      safeSetState(() {});
    });

    _model.searchQueryFieldTextController ??= TextEditingController();
    _model.searchQueryFieldFocusNode ??= FocusNode();

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
                      EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.start).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'hgan7uhb' /* Search */,
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
                          'qepaplr0' /* Find, filter and sort movies &... */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
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
              ),
              Container(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.center).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: _model.searchQueryFieldTextController,
                          focusNode: _model.searchQueryFieldFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.searchQueryFieldTextController',
                            Duration(milliseconds: 2000),
                            () async {
                              _model.query =
                                  _model.searchQueryFieldTextController.text;
                              safeSetState(() {});
                              _model.isLoading = true;
                              safeSetState(() {});
                              _model.loadError = '';
                              safeSetState(() {});
                              _model.firstPage = await actions.fetchTitles(
                                _model.query,
                                _model.mediaType,
                                _model.genre,
                                _model.year,
                                _model.minRating,
                                _model.sortBy,
                                1,
                              );
                              if (((_model.firstPage?.page ?? 0) > 0)) {
                                _model.results = _model.firstPage!.results
                                    .toList()
                                    .cast<MediaItemStruct>();
                                safeSetState(() {});
                                _model.page = 1;
                                safeSetState(() {});
                                _model.totalPages =
                                    _model.firstPage?.totalPages;
                                safeSetState(() {});
                              } else {
                                _model.results = (<MediaItemStruct>[])
                                    .toList()
                                    .cast<MediaItemStruct>();
                                safeSetState(() {});
                                _model.page = 0;
                                safeSetState(() {});
                                _model.totalPages = 0;
                                safeSetState(() {});
                                _model.loadError =
                                    'Couldn\'t load titles. Check your connection and try again.';
                                safeSetState(() {});
                              }

                              _model.isLoading = false;
                              safeSetState(() {});

                              safeSetState(() {});
                            },
                          ),
                          onFieldSubmitted: (_) async {
                            _model.query =
                                _model.searchQueryFieldTextController.text;
                            safeSetState(() {});
                            _model.isLoading = true;
                            safeSetState(() {});
                            _model.loadError = '';
                            safeSetState(() {});
                            _model.firstPage2 = await actions.fetchTitles(
                              _model.query,
                              _model.mediaType,
                              _model.genre,
                              _model.year,
                              _model.minRating,
                              _model.sortBy,
                              1,
                            );
                            if (((_model.firstPage2?.page ?? 0) > 0)) {
                              _model.results = _model.firstPage2!.results
                                  .toList()
                                  .cast<MediaItemStruct>();
                              safeSetState(() {});
                              _model.page = 1;
                              safeSetState(() {});
                              _model.totalPages = _model.firstPage2?.totalPages;
                              safeSetState(() {});
                            } else {
                              _model.results = (<MediaItemStruct>[])
                                  .toList()
                                  .cast<MediaItemStruct>();
                              safeSetState(() {});
                              _model.page = 0;
                              safeSetState(() {});
                              _model.totalPages = 0;
                              safeSetState(() {});
                              _model.loadError =
                                  'Couldn\'t load titles. Check your connection and try again.';
                              safeSetState(() {});
                            }

                            _model.isLoading = false;
                            safeSetState(() {});

                            safeSetState(() {});
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: FFLocalizations.of(context).getText(
                              'drtoyoxy' /* Search titles (optional) */,
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
                          validator: _model
                              .searchQueryFieldTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          _model.showFilters = !(_model.showFilters ?? false);
                          safeSetState(() {});
                        },
                        child: Container(
                          width: 48.0,
                          height: 48.0,
                          child: Stack(
                            alignment: AlignmentDirectional(1.0, -1.0),
                            children: [
                              Container(
                                width: 48.0,
                                height: 48.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Icon(
                                  Icons.tune_rounded,
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  size: 22.0,
                                ),
                              ),
                              if (((((String? g, int? y, double? m) {
                                            return (g != 'All' ? 1 : 0) +
                                                ((y ?? 0) > 0 ? 1 : 0) +
                                                ((m ?? 0) > 0 ? 1 : 0);
                                          }(_model.genre, _model.year,
                                              _model.minRating)) ??
                                          0) >
                                      0) ??
                                  true)
                                Container(
                                  width: 18.0,
                                  height: 18.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).accent3,
                                    borderRadius: BorderRadius.circular(9.0),
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    ((int? n) {
                                      return '${n ?? 0}';
                                    }(((String? g, int? y, double? m) {
                                      return (g != 'All' ? 1 : 0) +
                                          ((y ?? 0) > 0 ? 1 : 0) +
                                          ((m ?? 0) > 0 ? 1 : 0);
                                    }(_model.genre, _model.year,
                                        _model.minRating)))),
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
                                          color:
                                              FlutterFlowTheme.of(context).info,
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
                                ),
                            ],
                          ),
                        ),
                      ),
                    ].divide(SizedBox(width: 12.0)),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.center).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.mediaType = 'movie';
                            safeSetState(() {});
                            _model.isLoading = true;
                            safeSetState(() {});
                            _model.loadError = '';
                            safeSetState(() {});
                            _model.firstPage3 = await actions.fetchTitles(
                              _model.query,
                              _model.mediaType,
                              _model.genre,
                              _model.year,
                              _model.minRating,
                              _model.sortBy,
                              1,
                            );
                            if (((_model.firstPage3?.page ?? 0) > 0)) {
                              _model.results = _model.firstPage3!.results
                                  .toList()
                                  .cast<MediaItemStruct>();
                              safeSetState(() {});
                              _model.page = 1;
                              safeSetState(() {});
                              _model.totalPages = _model.firstPage3?.totalPages;
                              safeSetState(() {});
                            } else {
                              _model.results = (<MediaItemStruct>[])
                                  .toList()
                                  .cast<MediaItemStruct>();
                              safeSetState(() {});
                              _model.page = 0;
                              safeSetState(() {});
                              _model.totalPages = 0;
                              safeSetState(() {});
                              _model.loadError =
                                  'Couldn\'t load titles. Check your connection and try again.';
                              safeSetState(() {});
                            }

                            _model.isLoading = false;
                            safeSetState(() {});

                            safeSetState(() {});
                          },
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: 48.0,
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                if (_model.mediaType == 'movie')
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      borderRadius:
                                          BorderRadius.circular(999.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'su8yujy2' /* Movies */,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
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
                                    ),
                                  ),
                                if (!(_model.mediaType == 'movie'))
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius:
                                          BorderRadius.circular(999.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '1ds2f12t' /* Movies */,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
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
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.mediaType = 'tv';
                            safeSetState(() {});
                            _model.isLoading = true;
                            safeSetState(() {});
                            _model.loadError = '';
                            safeSetState(() {});
                            _model.firstPage4 = await actions.fetchTitles(
                              _model.query,
                              _model.mediaType,
                              _model.genre,
                              _model.year,
                              _model.minRating,
                              _model.sortBy,
                              1,
                            );
                            if (((_model.firstPage4?.page ?? 0) > 0)) {
                              _model.results = _model.firstPage4!.results
                                  .toList()
                                  .cast<MediaItemStruct>();
                              safeSetState(() {});
                              _model.page = 1;
                              safeSetState(() {});
                              _model.totalPages = _model.firstPage4?.totalPages;
                              safeSetState(() {});
                            } else {
                              _model.results = (<MediaItemStruct>[])
                                  .toList()
                                  .cast<MediaItemStruct>();
                              safeSetState(() {});
                              _model.page = 0;
                              safeSetState(() {});
                              _model.totalPages = 0;
                              safeSetState(() {});
                              _model.loadError =
                                  'Couldn\'t load titles. Check your connection and try again.';
                              safeSetState(() {});
                            }

                            _model.isLoading = false;
                            safeSetState(() {});

                            safeSetState(() {});
                          },
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: 48.0,
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                if (_model.mediaType == 'tv')
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      borderRadius:
                                          BorderRadius.circular(999.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'hk0jfni8' /* TV shows */,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
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
                                    ),
                                  ),
                                if (!(_model.mediaType == 'tv'))
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius:
                                          BorderRadius.circular(999.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'hl22tx7x' /* TV shows */,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
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
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 1.0,
                          height: 24.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.sortBy = 'popular';
                            safeSetState(() {});
                            _model.isLoading = true;
                            safeSetState(() {});
                            _model.loadError = '';
                            safeSetState(() {});
                            _model.firstPage5 = await actions.fetchTitles(
                              _model.query,
                              _model.mediaType,
                              _model.genre,
                              _model.year,
                              _model.minRating,
                              _model.sortBy,
                              1,
                            );
                            if (((_model.firstPage5?.page ?? 0) > 0)) {
                              _model.results = _model.firstPage5!.results
                                  .toList()
                                  .cast<MediaItemStruct>();
                              safeSetState(() {});
                              _model.page = 1;
                              safeSetState(() {});
                              _model.totalPages = _model.firstPage5?.totalPages;
                              safeSetState(() {});
                            } else {
                              _model.results = (<MediaItemStruct>[])
                                  .toList()
                                  .cast<MediaItemStruct>();
                              safeSetState(() {});
                              _model.page = 0;
                              safeSetState(() {});
                              _model.totalPages = 0;
                              safeSetState(() {});
                              _model.loadError =
                                  'Couldn\'t load titles. Check your connection and try again.';
                              safeSetState(() {});
                            }

                            _model.isLoading = false;
                            safeSetState(() {});

                            safeSetState(() {});
                          },
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: 48.0,
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                if (_model.sortBy == 'popular')
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      borderRadius:
                                          BorderRadius.circular(999.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'xft0h431' /* Popular */,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
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
                                    ),
                                  ),
                                if (!(_model.sortBy == 'popular'))
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius:
                                          BorderRadius.circular(999.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '1c8jgc05' /* Popular */,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
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
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.sortBy = 'rating';
                            safeSetState(() {});
                            _model.isLoading = true;
                            safeSetState(() {});
                            _model.loadError = '';
                            safeSetState(() {});
                            _model.firstPage6 = await actions.fetchTitles(
                              _model.query,
                              _model.mediaType,
                              _model.genre,
                              _model.year,
                              _model.minRating,
                              _model.sortBy,
                              1,
                            );
                            if (((_model.firstPage6?.page ?? 0) > 0)) {
                              _model.results = _model.firstPage6!.results
                                  .toList()
                                  .cast<MediaItemStruct>();
                              safeSetState(() {});
                              _model.page = 1;
                              safeSetState(() {});
                              _model.totalPages = _model.firstPage6?.totalPages;
                              safeSetState(() {});
                            } else {
                              _model.results = (<MediaItemStruct>[])
                                  .toList()
                                  .cast<MediaItemStruct>();
                              safeSetState(() {});
                              _model.page = 0;
                              safeSetState(() {});
                              _model.totalPages = 0;
                              safeSetState(() {});
                              _model.loadError =
                                  'Couldn\'t load titles. Check your connection and try again.';
                              safeSetState(() {});
                            }

                            _model.isLoading = false;
                            safeSetState(() {});

                            safeSetState(() {});
                          },
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: 48.0,
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                if (_model.sortBy == 'rating')
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      borderRadius:
                                          BorderRadius.circular(999.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'lhvii9u0' /* Top rated */,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
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
                                    ),
                                  ),
                                if (!(_model.sortBy == 'rating'))
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius:
                                          BorderRadius.circular(999.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '6ys9xrka' /* Top rated */,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
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
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.sortBy = 'newest';
                            safeSetState(() {});
                            _model.isLoading = true;
                            safeSetState(() {});
                            _model.loadError = '';
                            safeSetState(() {});
                            _model.firstPage7 = await actions.fetchTitles(
                              _model.query,
                              _model.mediaType,
                              _model.genre,
                              _model.year,
                              _model.minRating,
                              _model.sortBy,
                              1,
                            );
                            if (((_model.firstPage7?.page ?? 0) > 0)) {
                              _model.results = _model.firstPage7!.results
                                  .toList()
                                  .cast<MediaItemStruct>();
                              safeSetState(() {});
                              _model.page = 1;
                              safeSetState(() {});
                              _model.totalPages = _model.firstPage7?.totalPages;
                              safeSetState(() {});
                            } else {
                              _model.results = (<MediaItemStruct>[])
                                  .toList()
                                  .cast<MediaItemStruct>();
                              safeSetState(() {});
                              _model.page = 0;
                              safeSetState(() {});
                              _model.totalPages = 0;
                              safeSetState(() {});
                              _model.loadError =
                                  'Couldn\'t load titles. Check your connection and try again.';
                              safeSetState(() {});
                            }

                            _model.isLoading = false;
                            safeSetState(() {});

                            safeSetState(() {});
                          },
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: 48.0,
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                if (_model.sortBy == 'newest')
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      borderRadius:
                                          BorderRadius.circular(999.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          's65zt5n6' /* Newest */,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
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
                                    ),
                                  ),
                                if (!(_model.sortBy == 'newest'))
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius:
                                          BorderRadius.circular(999.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'ybn3ygj0' /* Newest */,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
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
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                  ),
                ),
              ),
              if (_model.showFilters ?? true)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  child: Container(
                    child: Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment:
                              (FFMainAxisAlignment.start).flutterValue,
                          crossAxisAlignment:
                              (FFCrossAxisAlignment.start).flutterValue,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
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
                                    'mr6fjqgb' /* Genre */,
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
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        (FFMainAxisAlignment.start)
                                            .flutterValue,
                                    crossAxisAlignment:
                                        (FFCrossAxisAlignment.center)
                                            .flutterValue,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.genre = 'All';
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage8 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage8?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage8!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage8?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.genre == 'All')
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'nn86r28f' /* All */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.genre == 'All'))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'lm66vz7h' /* All */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.genre = 'Action';
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage9 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage9?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage9!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage9?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.genre == 'Action')
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'w8d7vpqr' /* Action */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.genre == 'Action'))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'q626yix5' /* Action */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.genre = 'Comedy';
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage10 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage10?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage10!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage10?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.genre == 'Comedy')
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'i5scbcyx' /* Comedy */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.genre == 'Comedy'))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'b9yo86na' /* Comedy */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.genre = 'Drama';
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage11 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage11?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage11!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage11?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.genre == 'Drama')
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        't0ymxly4' /* Drama */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.genre == 'Drama'))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'mgky31uk' /* Drama */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.genre = 'Sci-Fi';
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage12 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage12?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage12!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage12?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.genre == 'Sci-Fi')
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'rn2vjfsy' /* Sci-Fi */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.genre == 'Sci-Fi'))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '8o6lf4uk' /* Sci-Fi */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.genre = 'Animation';
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage13 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage13?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage13!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage13?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.genre == 'Animation')
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'tudxaerj' /* Animation */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.genre ==
                                                  'Animation'))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '4ulugo8k' /* Animation */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.genre = 'Crime';
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage14 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage14?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage14!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage14?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.genre == 'Crime')
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'jfn7s33f' /* Crime */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.genre == 'Crime'))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '9n138cmb' /* Crime */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.genre = 'Mystery';
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage15 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage15?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage15!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage15?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.genre == 'Mystery')
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'nt8arqp9' /* Mystery */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.genre == 'Mystery'))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '2j34hjwp' /* Mystery */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.genre = 'Documentary';
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage16 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage16?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage16!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage16?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.genre == 'Documentary')
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        't470i1g1' /* Documentary */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.genre ==
                                                  'Documentary'))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'pb6gyvqp' /* Documentary */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.genre = 'Family';
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage17 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage17?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage17!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage17?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.genre == 'Family')
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '72h1ssof' /* Family */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.genre == 'Family'))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'rues6jqp' /* Family */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.genre = 'Fantasy';
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage18 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage18?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage18!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage18?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.genre == 'Fantasy')
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'qvugxo6p' /* Fantasy */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.genre == 'Fantasy'))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'adu1yizu' /* Fantasy */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
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
                                    'c9bmpbnx' /* Release year */,
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
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        (FFMainAxisAlignment.start)
                                            .flutterValue,
                                    crossAxisAlignment:
                                        (FFCrossAxisAlignment.center)
                                            .flutterValue,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.year = 0;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage19 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage19?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage19!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage19?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.year == 0)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'j25ti5fe' /* Any */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.year == 0))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '6cfll18v' /* Any */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.year = 2026;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage20 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage20?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage20!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage20?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.year == 2026)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'mhl2mvab' /* 2026 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.year == 2026))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'o89hnax2' /* 2026 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.year = 2025;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage21 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage21?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage21!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage21?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.year == 2025)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '5du4du6o' /* 2025 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.year == 2025))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'kpyvp8q4' /* 2025 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.year = 2024;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage22 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage22?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage22!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage22?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.year == 2024)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '0cc5azjv' /* 2024 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.year == 2024))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'm785rbdt' /* 2024 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.year = 2023;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage23 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage23?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage23!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage23?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.year == 2023)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'y61zrqu4' /* 2023 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.year == 2023))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '2at4791i' /* 2023 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.year = 2022;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage24 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage24?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage24!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage24?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.year == 2022)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'm4g44dft' /* 2022 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.year == 2022))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'jldrey1s' /* 2022 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.year = 2021;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage25 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage25?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage25!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage25?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.year == 2021)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '9ruhyysj' /* 2021 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.year == 2021))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '26mi7snc' /* 2021 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.year = 2020;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage26 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage26?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage26!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage26?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.year == 2020)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '5jdpk0cz' /* 2020 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.year == 2020))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'xrriufjd' /* 2020 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.year = 2018;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage27 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage27?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage27!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage27?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.year == 2018)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '65ltdwlm' /* 2018 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.year == 2018))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '9s9q31nb' /* 2018 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.year = 2015;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage28 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage28?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage28!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage28?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.year == 2015)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'qpgkhpcw' /* 2015 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.year == 2015))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'dde0qvqz' /* 2015 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.year = 2010;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage29 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage29?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage29!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage29?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.year == 2010)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '76s4j2q1' /* 2010 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.year == 2010))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'pkzmldci' /* 2010 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.year = 2005;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage30 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage30?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage30!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage30?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.year == 2005)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'm62lzn7v' /* 2005 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.year == 2005))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'pdwbz5tr' /* 2005 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.year = 2000;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage31 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage31?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage31!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage31?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.year == 2000)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'l6xndg0m' /* 2000 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.year == 2000))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'md05phkl' /* 2000 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
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
                                    '2qj7wki1' /* Minimum rating */,
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
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        (FFMainAxisAlignment.start)
                                            .flutterValue,
                                    crossAxisAlignment:
                                        (FFCrossAxisAlignment.center)
                                            .flutterValue,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.minRating = 0.0;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage32 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage32?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage32!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage32?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.minRating == 0.0)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'gdfzs699' /* Any */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.minRating == 0.0))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ur0fg1mn' /* Any */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.minRating = 6.0;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage33 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage33?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage33!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage33?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.minRating == 6.0)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'vkxj2e4w' /* 6+ stars */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.minRating == 6.0))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'm3lhqazk' /* 6+ stars */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.minRating = 7.0;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage34 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage34?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage34!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage34?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.minRating == 7.0)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '4zszh73c' /* 7+ stars */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.minRating == 7.0))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'jamv4n9z' /* 7+ stars */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.minRating = 8.0;
                                          safeSetState(() {});
                                          _model.isLoading = true;
                                          safeSetState(() {});
                                          _model.loadError = '';
                                          safeSetState(() {});
                                          _model.firstPage35 =
                                              await actions.fetchTitles(
                                            _model.query,
                                            _model.mediaType,
                                            _model.genre,
                                            _model.year,
                                            _model.minRating,
                                            _model.sortBy,
                                            1,
                                          );
                                          if (((_model.firstPage35?.page ?? 0) >
                                              0)) {
                                            _model.results = _model
                                                .firstPage35!.results
                                                .toList()
                                                .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 1;
                                            safeSetState(() {});
                                            _model.totalPages =
                                                _model.firstPage35?.totalPages;
                                            safeSetState(() {});
                                          } else {
                                            _model.results =
                                                (<MediaItemStruct>[])
                                                    .toList()
                                                    .cast<MediaItemStruct>();
                                            safeSetState(() {});
                                            _model.page = 0;
                                            safeSetState(() {});
                                            _model.totalPages = 0;
                                            safeSetState(() {});
                                            _model.loadError =
                                                'Couldn\'t load titles. Check your connection and try again.';
                                            safeSetState(() {});
                                          }

                                          _model.isLoading = false;
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 48.0,
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              if (_model.minRating == 8.0)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ohtcno0t' /* 8+ stars */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              if (!(_model.minRating == 8.0))
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 8.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'cmvdk5eg' /* 8+ stars */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                ),
                              ].divide(SizedBox(height: 8.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                                  (FFMainAxisAlignment.spaceBetween)
                                      .flutterValue,
                              crossAxisAlignment:
                                  (FFCrossAxisAlignment.center).flutterValue,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  ((int? n) {
                                    return (n ?? 0) == 0
                                        ? 'No filters active'
                                        : '${n} filter' +
                                            (n == 1 ? '' : 's') +
                                            ' active';
                                  }(((String? g, int? y, double? m) {
                                    return (g != 'All' ? 1 : 0) +
                                        ((y ?? 0) > 0 ? 1 : 0) +
                                        ((m ?? 0) > 0 ? 1 : 0);
                                  }(_model.genre, _model.year,
                                      _model.minRating)))),
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
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    _model.genre = 'All';
                                    safeSetState(() {});
                                    _model.year = 0;
                                    safeSetState(() {});
                                    _model.minRating = 0.0;
                                    safeSetState(() {});
                                    _model.sortBy = 'popular';
                                    safeSetState(() {});
                                    _model.isLoading = true;
                                    safeSetState(() {});
                                    _model.loadError = '';
                                    safeSetState(() {});
                                    _model.firstPage36 =
                                        await actions.fetchTitles(
                                      _model.query,
                                      _model.mediaType,
                                      _model.genre,
                                      _model.year,
                                      _model.minRating,
                                      _model.sortBy,
                                      1,
                                    );
                                    if (((_model.firstPage36?.page ?? 0) >
                                        0)) {
                                      _model.results = _model
                                          .firstPage36!.results
                                          .toList()
                                          .cast<MediaItemStruct>();
                                      safeSetState(() {});
                                      _model.page = 1;
                                      safeSetState(() {});
                                      _model.totalPages =
                                          _model.firstPage36?.totalPages;
                                      safeSetState(() {});
                                    } else {
                                      _model.results = (<MediaItemStruct>[])
                                          .toList()
                                          .cast<MediaItemStruct>();
                                      safeSetState(() {});
                                      _model.page = 0;
                                      safeSetState(() {});
                                      _model.totalPages = 0;
                                      safeSetState(() {});
                                      _model.loadError =
                                          'Couldn\'t load titles. Check your connection and try again.';
                                      safeSetState(() {});
                                    }

                                    _model.isLoading = false;
                                    safeSetState(() {});

                                    safeSetState(() {});
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'udcqxuzl' /* Clear filters */,
                                  ),
                                  icon: Icon(
                                    Icons.filter_alt_off_rounded,
                                    size: 20.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 48.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    color: Colors.transparent,
                                    textStyle: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                    ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                  crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    if (((bool? l, List<MediaItemStruct>? r) {
                          return (l ?? false) && (r ?? []).isEmpty;
                        }(_model.isLoading, _model.results.toList())) ??
                        true)
                      Container(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          child: wrapWithModel(
                            model: _model.loadingStateModel,
                            updateCallback: () => safeSetState(() {}),
                            child: LoadingStateWidget(
                              message: 'Finding titles…',
                            ),
                          ),
                        ),
                      ),
                    if (((String? e, List<MediaItemStruct>? r) {
                          return (e ?? '').isNotEmpty && (r ?? []).isEmpty;
                        }(_model.loadError, _model.results.toList())) ??
                        true)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Container(
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    (FFMainAxisAlignment.start).flutterValue,
                                crossAxisAlignment:
                                    (FFCrossAxisAlignment.center).flutterValue,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Icon(
                                    Icons.wifi_off_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 32.0,
                                  ),
                                  Text(
                                    _model.loadError!,
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
                                  FFButtonWidget(
                                    onPressed: () async {
                                      _model.isLoading = true;
                                      safeSetState(() {});
                                      _model.loadError = '';
                                      safeSetState(() {});
                                      _model.firstPage37 =
                                          await actions.fetchTitles(
                                        _model.query,
                                        _model.mediaType,
                                        _model.genre,
                                        _model.year,
                                        _model.minRating,
                                        _model.sortBy,
                                        1,
                                      );
                                      if (((_model.firstPage37?.page ?? 0) >
                                          0)) {
                                        _model.results = _model
                                            .firstPage37!.results
                                            .toList()
                                            .cast<MediaItemStruct>();
                                        safeSetState(() {});
                                        _model.page = 1;
                                        safeSetState(() {});
                                        _model.totalPages =
                                            _model.firstPage37?.totalPages;
                                        safeSetState(() {});
                                      } else {
                                        _model.results = (<MediaItemStruct>[])
                                            .toList()
                                            .cast<MediaItemStruct>();
                                        safeSetState(() {});
                                        _model.page = 0;
                                        safeSetState(() {});
                                        _model.totalPages = 0;
                                        safeSetState(() {});
                                        _model.loadError =
                                            'Couldn\'t load titles. Check your connection and try again.';
                                        safeSetState(() {});
                                      }

                                      _model.isLoading = false;
                                      safeSetState(() {});

                                      safeSetState(() {});
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      'd7fgsb2k' /* Retry */,
                                    ),
                                    icon: Icon(
                                      Icons.refresh_rounded,
                                      size: 20.0,
                                    ),
                                    options: FFButtonOptions(
                                      height: 48.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      iconColor:
                                          FlutterFlowTheme.of(context).tertiary,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 12.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (((bool? l, String? e, List<MediaItemStruct>? r,
                                int? p) {
                          return !(l ?? false) &&
                              (e ?? '').isEmpty &&
                              (r ?? []).isEmpty &&
                              (p ?? 0) > 0;
                        }(_model.isLoading, _model.loadError,
                            _model.results.toList(), _model.page)) ??
                        true)
                      Container(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          child: wrapWithModel(
                            model: _model.emptyStateModel,
                            updateCallback: () => safeSetState(() {}),
                            child: EmptyStateWidget(
                              message:
                                  'No titles match. Try another search or clear some filters.',
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 12.0),
                        child: Builder(
                          builder: (context) {
                            final result = _model.results.toList();

                            return NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification is ScrollEndNotification &&
                                    notification.depth == 0 &&
                                    notification.metrics.maxScrollExtent > 0 &&
                                    notification.metrics.extentAfter <= 50.0 &&
                                    notification.metrics.extentAfter <=
                                        notification.metrics.extentBefore) {
                                  (() async {
                                    if (((bool? l, int? p, int? t, String? e) {
                                      return !(l ?? false) &&
                                          (p ?? 0) > 0 &&
                                          (p ?? 0) < (t ?? 0) &&
                                          (e ?? '').isEmpty;
                                    }(
                                        _model.isLoading,
                                        _model.page,
                                        _model.totalPages,
                                        _model.loadError))) {
                                      _model.isLoading = true;
                                      safeSetState(() {});
                                      _model.nextPage =
                                          await actions.fetchTitles(
                                        _model.query,
                                        _model.mediaType,
                                        _model.genre,
                                        _model.year,
                                        _model.minRating,
                                        _model.sortBy,
                                        (_model.page ?? 0) + 1,
                                      );
                                      if (((_model.nextPage?.page ?? 0) > 0)) {
                                        _model
                                            .results = ((List<MediaItemStruct>?
                                                        a,
                                                    List<MediaItemStruct>? b) {
                                          return [
                                            ...(a ?? <MediaItemStruct>[]),
                                            ...(b ?? <MediaItemStruct>[]).where(
                                                (x) => !(a ??
                                                        <MediaItemStruct>[])
                                                    .any((y) => y.id == x.id))
                                          ];
                                        }(
                                                _model.results.toList(),
                                                _model.nextPage?.results
                                                    .toList()))
                                            .toList()
                                            .cast<MediaItemStruct>();
                                        safeSetState(() {});
                                        _model.page = (_model.page ?? 0) + 1;
                                        safeSetState(() {});
                                      } else {
                                        _model.loadError =
                                            'Couldn\'t load more results.';
                                        safeSetState(() {});
                                      }

                                      _model.isLoading = false;
                                      safeSetState(() {});
                                    }

                                    safeSetState(() {});
                                  })();
                                }
                                return false;
                              },
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                primary: false,
                                scrollDirection: Axis.vertical,
                                itemCount: result.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 12.0),
                                itemBuilder: (context, resultIndex) {
                                  final resultItem = result[resultIndex];
                                  return wrapWithModel(
                                    model: _model.mediaListTileModels.getModel(
                                      resultIndex.toString(),
                                      resultIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: MediaListTileWidget(
                                      key: Key(
                                        'Key6gl_${resultIndex.toString()}',
                                      ),
                                      date: _model.mediaType == 'tv'
                                          ? resultItem.firstAirDate
                                          : resultItem.releaseDate,
                                      mediaType: _model.mediaType,
                                      posterPath: resultItem.posterPath,
                                      title: _model.mediaType == 'tv'
                                          ? resultItem.name
                                          : resultItem.title,
                                      tmdbId: resultItem.id,
                                      voteAverage: resultItem.voteAverage,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (((bool? l, List<MediaItemStruct>? r) {
                          return (l ?? false) && (r ?? []).isNotEmpty;
                        }(_model.isLoading, _model.results.toList())) ??
                        true)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                            (FFMainAxisAlignment.center).flutterValue,
                        crossAxisAlignment:
                            (FFCrossAxisAlignment.center).flutterValue,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          CircularPercentIndicator(
                            percent: 0.0,
                            radius: 9.0,
                            lineWidth: 2.0,
                            animation: false,
                            animateFromLastPercent: true,
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'wljqjzkq' /* Loading more… */,
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
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                          ),
                        ].divide(SizedBox(width: 12.0)),
                      ),
                    if (((String? e, List<MediaItemStruct>? r) {
                          return (e ?? '').isNotEmpty && (r ?? []).isNotEmpty;
                        }(_model.loadError, _model.results.toList())) ??
                        true)
                      Container(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 4.0, 24.0, 4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                                (FFMainAxisAlignment.spaceBetween).flutterValue,
                            crossAxisAlignment:
                                (FFCrossAxisAlignment.center).flutterValue,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                _model.loadError!,
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
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  _model.loadError = '';
                                  safeSetState(() {});
                                  if (((bool? l, int? p, int? t, String? e) {
                                    return !(l ?? false) &&
                                        (p ?? 0) > 0 &&
                                        (p ?? 0) < (t ?? 0) &&
                                        (e ?? '').isEmpty;
                                  }(_model.isLoading, _model.page,
                                      _model.totalPages, _model.loadError))) {
                                    _model.isLoading = true;
                                    safeSetState(() {});
                                    _model.nextPage2 =
                                        await actions.fetchTitles(
                                      _model.query,
                                      _model.mediaType,
                                      _model.genre,
                                      _model.year,
                                      _model.minRating,
                                      _model.sortBy,
                                      (_model.page ?? 0) + 1,
                                    );
                                    if (((_model.nextPage2?.page ?? 0) > 0)) {
                                      _model
                                          .results = ((List<MediaItemStruct>? a,
                                                  List<MediaItemStruct>? b) {
                                        return [
                                          ...(a ?? <MediaItemStruct>[]),
                                          ...(b ?? <MediaItemStruct>[]).where(
                                              (x) => !(a ?? <MediaItemStruct>[])
                                                  .any((y) => y.id == x.id))
                                        ];
                                      }(
                                              _model.results.toList(),
                                              _model.nextPage2?.results
                                                  .toList()))
                                          .toList()
                                          .cast<MediaItemStruct>();
                                      safeSetState(() {});
                                      _model.page = (_model.page ?? 0) + 1;
                                      safeSetState(() {});
                                    } else {
                                      _model.loadError =
                                          'Couldn\'t load more results.';
                                      safeSetState(() {});
                                    }

                                    _model.isLoading = false;
                                    safeSetState(() {});
                                  }

                                  safeSetState(() {});
                                },
                                text: FFLocalizations.of(context).getText(
                                  '7egrjh7z' /* Retry */,
                                ),
                                options: FFButtonOptions(
                                  height: 48.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Colors.transparent,
                                  textStyle: TextStyle(
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ].divide(SizedBox(height: 8.0)),
                ),
              ),
            ].divide(SizedBox(height: 12.0)),
          ),
        ),
      ),
    );
  }
}
