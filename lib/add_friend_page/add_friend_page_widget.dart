import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_state_widget.dart';
import '/components/loading_state_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_friend_page_model.dart';
export 'add_friend_page_model.dart';

/// Find people by @username and open their profile.
class AddFriendPageWidget extends StatefulWidget {
  const AddFriendPageWidget({super.key});

  static String routeName = 'AddFriendPage';
  static String routePath = '/add-friend';

  @override
  State<AddFriendPageWidget> createState() => _AddFriendPageWidgetState();
}

class _AddFriendPageWidgetState extends State<AddFriendPageWidget> {
  late AddFriendPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddFriendPageModel());

    _model.friendSearchFieldTextController ??= TextEditingController();
    _model.friendSearchFieldFocusNode ??= FocusNode();

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
              'f9yglrz5' /* Add friend */,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
              crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
              textBaseline: TextBaseline.alphabetic,
              children: [
                TextFormField(
                  controller: _model.friendSearchFieldTextController,
                  focusNode: _model.friendSearchFieldFocusNode,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.friendSearchFieldTextController',
                    Duration(milliseconds: 2000),
                    () async {
                      _model.searchText = (String? v) {
                        return (v ?? '')
                            .trim()
                            .toLowerCase()
                            .replaceFirst('@', '');
                      }(_model.friendSearchFieldTextController.text);
                      safeSetState(() {});
                      if (_model.searchText == '') {
                        _model.results =
                            (<UsersRecord>[]).toList().cast<UsersRecord>();
                        safeSetState(() {});
                      } else {
                        _model.isLoading = true;
                        safeSetState(() {});
                        _model.found = await queryUsersRecordOnce(
                          queryBuilder: (usersRecord) => usersRecord
                              .where(
                                'username',
                                isGreaterThanOrEqualTo: _model.searchText,
                              )
                              .where(
                                'username',
                                isLessThan: (String? q) {
                                  return (q ?? '') + '\uf8ff';
                                }(_model.searchText),
                              )
                              .orderBy('username'),
                          limit: 20,
                        );
                        _model.results =
                            _model.found!.toList().cast<UsersRecord>();
                        safeSetState(() {});
                        _model.isLoading = false;
                        safeSetState(() {});
                      }

                      safeSetState(() {});
                    },
                  ),
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: FFLocalizations.of(context).getText(
                      '0rtlke5s' /* Username */,
                    ),
                    hintText: FFLocalizations.of(context).getText(
                      '23jua5e1' /* Search by username */,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).accent2,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                    ),
                  ),
                  style: TextStyle(),
                  maxLines: null,
                  validator: _model.friendSearchFieldTextControllerValidator
                      .asValidator(context),
                ),
                if (_model.searchText == '')
                  wrapWithModel(
                    model: _model.typeToSearchHintModel,
                    updateCallback: () => safeSetState(() {}),
                    child: EmptyStateWidget(
                      message: 'Type a username to find people',
                    ),
                  ),
                if (_model.isLoading ?? true)
                  wrapWithModel(
                    model: _model.searchingStateModel,
                    updateCallback: () => safeSetState(() {}),
                    child: LoadingStateWidget(
                      message: 'Searching',
                    ),
                  ),
                if (((String? q, bool? l, List<UsersRecord>? r, String? me) {
                      return (q ?? '').isNotEmpty &&
                          !(l ?? false) &&
                          (r ?? <UsersRecord>[])
                              .where((u) => u.uid != me)
                              .isEmpty;
                    }(_model.searchText, _model.isLoading,
                        _model.results.toList(), currentUserUid)) ??
                    true)
                  wrapWithModel(
                    model: _model.noUserFoundModel,
                    updateCallback: () => safeSetState(() {}),
                    child: EmptyStateWidget(
                      message: 'No one with that username',
                    ),
                  ),
                Expanded(
                  flex: 1,
                  child: Builder(
                    builder: (context) {
                      final item = ((List<UsersRecord>? r, String? me) {
                            return (r ?? <UsersRecord>[])
                                .where((u) => u.uid != me)
                                .toList();
                          }(_model.results.toList(), currentUserUid))
                              .toList() ??
                          [];

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        itemCount: item.length,
                        itemBuilder: (context, itemIndex) {
                          final itemItem = item[itemIndex];
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                PublicProfilePageWidget.routeName,
                                queryParameters: {
                                  'userId': serializeParam(
                                    itemItem.uid,
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
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
                                      (FFMainAxisAlignment.start).flutterValue,
                                  crossAxisAlignment:
                                      (FFCrossAxisAlignment.center)
                                          .flutterValue,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Container(
                                      width: 48.0,
                                      height: 48.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                            Duration(milliseconds: 500),
                                        fadeOutDuration:
                                            Duration(milliseconds: 500),
                                        imageUrl: ((String? p) {
                                          return (p ?? '').trim().isEmpty
                                              ? 'https://api.dicebear.com/9.x/adventurer/png?seed=Felix'
                                              : (p ?? '');
                                        }(itemItem.photoUrl)),
                                        fit: BoxFit.cover,
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
                                          Text(
                                            itemItem.displayName,
                                            maxLines: 1,
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
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            ((String? u) {
                                              return '@' + (u ?? '');
                                            }(itemItem.username)),
                                            maxLines: 1,
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
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
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ].divide(SizedBox(height: 4.0)),
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ].divide(SizedBox(height: 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}
