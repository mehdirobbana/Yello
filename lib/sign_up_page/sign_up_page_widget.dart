import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign_up_page_model.dart';
export 'sign_up_page_model.dart';

/// Email/password sign-up form (UI only, auth added later)
class SignUpPageWidget extends StatefulWidget {
  const SignUpPageWidget({super.key});

  static String routeName = 'SignUpPage';
  static String routePath = '/sign-up';

  @override
  State<SignUpPageWidget> createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  late SignUpPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUpPageModel());

    _model.signUpNameTextController ??= TextEditingController();
    _model.signUpNameFocusNode ??= FocusNode();

    _model.signUpUsernameTextController ??= TextEditingController();
    _model.signUpUsernameFocusNode ??= FocusNode();

    _model.signUpEmailTextController ??= TextEditingController();
    _model.signUpEmailFocusNode ??= FocusNode();

    _model.signUpPasswordTextController ??= TextEditingController();
    _model.signUpPasswordFocusNode ??= FocusNode();

    _model.signUpConfirmTextController ??= TextEditingController();
    _model.signUpConfirmFocusNode ??= FocusNode();

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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.center).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      AlignedTooltip(
                        content: Text(
                          FFLocalizations.of(context).getText(
                            'z0sa2rdc' /* Back */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
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
                        child: FlutterFlowIconButton(
                          borderRadius: 24.0,
                          buttonSize: 48.0,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            context.pop();
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'xfb318m8' /* Create account */,
                    ),
                    textAlign: TextAlign.center,
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
                      'r6eehze9' /* Join Yello to keep track of ev... */,
                    ),
                    textAlign: TextAlign.center,
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
                  Container(
                    height: 4.0,
                  ),
                  Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.center).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        TextFormField(
                          controller: _model.signUpNameTextController,
                          focusNode: _model.signUpNameFocusNode,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'albijsa4' /* Display name */,
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
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          style: TextStyle(),
                          maxLines: null,
                          validator: _model.signUpNameTextControllerValidator
                              .asValidator(context),
                        ),
                        TextFormField(
                          controller: _model.signUpUsernameTextController,
                          focusNode: _model.signUpUsernameFocusNode,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'unmlbl01' /* Username */,
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
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          style: TextStyle(),
                          maxLines: null,
                          validator: _model
                              .signUpUsernameTextControllerValidator
                              .asValidator(context),
                        ),
                        TextFormField(
                          controller: _model.signUpEmailTextController,
                          focusNode: _model.signUpEmailFocusNode,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'bb5sl531' /* Email */,
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
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          style: TextStyle(),
                          maxLines: null,
                          keyboardType:
                              (FFKeyboardType.emailAddress).flutterValue,
                          validator: _model.signUpEmailTextControllerValidator
                              .asValidator(context),
                        ),
                        TextFormField(
                          controller: _model.signUpPasswordTextController,
                          focusNode: _model.signUpPasswordFocusNode,
                          obscureText: !_model.signUpPasswordVisibility,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'xi4d3fwn' /* Password */,
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
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            suffixIcon: InkWell(
                              onTap: () async {
                                safeSetState(() =>
                                    _model.signUpPasswordVisibility =
                                        !_model.signUpPasswordVisibility);
                              },
                              focusNode: _model
                                  .signUpPasswordPasswordVisibilityFocusNode
                                ..skipTraversal = !(false),
                              child: Icon(
                                _model.signUpPasswordVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 22,
                              ),
                            ),
                          ),
                          style: TextStyle(),
                          validator: _model
                              .signUpPasswordTextControllerValidator
                              .asValidator(context),
                        ),
                        TextFormField(
                          controller: _model.signUpConfirmTextController,
                          focusNode: _model.signUpConfirmFocusNode,
                          obscureText: !_model.signUpConfirmVisibility,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'zci5ssc1' /* Confirm password */,
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
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            suffixIcon: InkWell(
                              onTap: () async {
                                safeSetState(() =>
                                    _model.signUpConfirmVisibility =
                                        !_model.signUpConfirmVisibility);
                              },
                              focusNode: _model
                                  .signUpConfirmPasswordVisibilityFocusNode
                                ..skipTraversal = !(false),
                              child: Icon(
                                _model.signUpConfirmVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 22,
                              ),
                            ),
                          ),
                          style: TextStyle(),
                          validator: _model.signUpConfirmTextControllerValidator
                              .asValidator(context),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                  ),
                  Container(
                    height: 4.0,
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      Function() _navigate = () {};
                      if (_model.formKey.currentState == null ||
                          !_model.formKey.currentState!.validate()) {
                        return;
                      }
                      GoRouter.of(context).prepareAuthEvent();
                      if (_model.signUpPasswordTextController.text !=
                          _model.signUpConfirmTextController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Passwords don\'t match!',
                            ),
                          ),
                        );
                        return;
                      }

                      final user = await authManager.createAccountWithEmail(
                        context,
                        _model.signUpEmailTextController.text,
                        _model.signUpPasswordTextController.text,
                      );
                      if (user == null) {
                        return;
                      }

                      _navigate = () => context.goNamedAuth(
                          DiscoverPageWidget.routeName, context.mounted);

                      await currentUserReference!.update(createUsersRecordData(
                        displayName: _model.signUpNameTextController.text,
                      ));
                      _model.typedUsername = (String? v) {
                        return (v ?? '').trim().toLowerCase();
                      }(_model.signUpUsernameTextController.text);
                      safeSetState(() {});
                      _model.signupTaken = await queryUsersRecordOnce(
                        queryBuilder: (usersRecord) => usersRecord.where(
                          'username',
                          isEqualTo: _model.typedUsername,
                        ),
                        singleRecord: true,
                      ).then((s) => s.firstOrNull);
                      if (((String? u, String? me) {
                        return (u ?? '').isNotEmpty && u != me;
                      }(_model.signupTaken?.uid, currentUserUid))) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'This username is taken. You can choose another one next.',
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
                      }

                      _navigate();

                      safeSetState(() {});
                    },
                    text: FFLocalizations.of(context).getText(
                      'cnmv3nea' /* Create account */,
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                        (FFMainAxisAlignment.center).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.center).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'ikwqq48l' /* Already have an account? */,
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
                      FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(
                            LoginPageWidget.routeName,
                            extra: <String, dynamic>{
                              '__transition_info__': TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                                duration: Duration(milliseconds: 250),
                              ),
                            },
                          );
                        },
                        text: FFLocalizations.of(context).getText(
                          '7ipy5rbp' /* Log in */,
                        ),
                        options: FFButtonOptions(
                          height: 48.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Colors.transparent,
                          textStyle: TextStyle(
                            color: FlutterFlowTheme.of(context).secondary,
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
    );
  }
}
