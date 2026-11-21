import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'username_page_model.dart';
export 'username_page_model.dart';

/// Choose or change your @username.
///
/// Used as a one-time gate and from Settings.
class UsernamePageWidget extends StatefulWidget {
  const UsernamePageWidget({
    super.key,
    bool? isGate,
  }) : this.isGate = isGate ?? false;

  final bool isGate;

  static String routeName = 'UsernamePage';
  static String routePath = '/username';

  @override
  State<UsernamePageWidget> createState() => _UsernamePageWidgetState();
}

class _UsernamePageWidgetState extends State<UsernamePageWidget> {
  late UsernamePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UsernamePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.meDoc = await queryUsersRecordOnce(
        queryBuilder: (usersRecord) => usersRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      safeSetState(() {
        _model.usernameFieldTextController?.text = ((String? u) {
          return u ?? '';
        }(_model.meDoc?.username));
      });
    });

    _model.usernameFieldTextController ??= TextEditingController();
    _model.usernameFieldFocusNode ??= FocusNode();

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
            padding: EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  if (!widget.isGate)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.center).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        AlignedTooltip(
                          content: Text(
                            FFLocalizations.of(context).getText(
                              'ogc689u3' /* Back */,
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
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pop();
                            },
                            child: Container(
                              width: 48.0,
                              height: 48.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  Text(
                    widget.isGate
                        ? 'Choose your username'
                        : 'Change your username',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
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
                      'xy58uzl1' /* People find you by this name. ... */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                  ),
                  Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: TextFormField(
                      controller: _model.usernameFieldTextController,
                      focusNode: _model.usernameFieldFocusNode,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: FFLocalizations.of(context).getText(
                          'baouufpk' /* Username */,
                        ),
                        hintText: FFLocalizations.of(context).getText(
                          'd6o4d5jl' /* for example movie_fan */,
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
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.alternate_email_rounded,
                        ),
                      ),
                      style: TextStyle(),
                      maxLines: null,
                      validator: _model.usernameFieldTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      if (_model.formKey.currentState == null ||
                          !_model.formKey.currentState!.validate()) {
                        return;
                      }
                      _model.typedUsername = (String? v) {
                        return (v ?? '').trim().toLowerCase();
                      }(_model.usernameFieldTextController.text);
                      safeSetState(() {});
                      _model.takenBy = await queryUsersRecordOnce(
                        queryBuilder: (usersRecord) => usersRecord.where(
                          'username',
                          isEqualTo: _model.typedUsername,
                        ),
                        singleRecord: true,
                      ).then((s) => s.firstOrNull);
                      if (((String? u, String? me) {
                        return (u ?? '').isNotEmpty && u != me;
                      }(_model.takenBy?.uid, currentUserUid))) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'This username is taken',
                              style: TextStyle(),
                            ),
                            duration: Duration(milliseconds: 4000),
                          ),
                        );
                      } else {
                        await currentUserReference!
                            .update(createUsersRecordData(
                          username: _model.typedUsername,
                        ));
                        if (widget.isGate) {
                          context.goNamed(DiscoverPageWidget.routeName);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Username updated',
                                style: TextStyle(),
                              ),
                              duration: Duration(milliseconds: 4000),
                            ),
                          );
                          context.pop();
                        }
                      }

                      safeSetState(() {});
                    },
                    text: FFLocalizations.of(context).getText(
                      'f0xnozgm' /* Save username */,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 54.0,
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
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
