import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'sign_up_page_widget.dart' show SignUpPageWidget;
import 'package:flutter/material.dart';

class SignUpPageModel extends FlutterFlowModel<SignUpPageWidget> {
  ///  Local state fields for this page.

  String? typedUsername = '';

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for signUpName widget.
  FocusNode? signUpNameFocusNode;
  TextEditingController? signUpNameTextController;
  String? Function(BuildContext, String?)? signUpNameTextControllerValidator;
  // State field(s) for signUpUsername widget.
  FocusNode? signUpUsernameFocusNode;
  TextEditingController? signUpUsernameTextController;
  String? Function(BuildContext, String?)?
      signUpUsernameTextControllerValidator;
  String? _signUpUsernameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'unmv0001' /* Choose a username */,
      );
    }

    if (val.length < 3) {
      return FFLocalizations.of(context).getText(
        'unmv0002' /* At least 3 characters */,
      );
    }
    if (val.length > 20) {
      return FFLocalizations.of(context).getText(
        'unmv0003' /* At most 20 characters */,
      );
    }
    if (!RegExp('^[a-z0-9_.]+\$').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'unmv0004' /* Use lowercase letters, numbers... */,
      );
    }
    return null;
  }

  // State field(s) for signUpEmail widget.
  FocusNode? signUpEmailFocusNode;
  TextEditingController? signUpEmailTextController;
  String? Function(BuildContext, String?)? signUpEmailTextControllerValidator;
  // State field(s) for signUpPassword widget.
  late FocusNode signUpPasswordPasswordVisibilityFocusNode;
  FocusNode? signUpPasswordFocusNode;
  TextEditingController? signUpPasswordTextController;
  late bool signUpPasswordVisibility;
  String? Function(BuildContext, String?)?
      signUpPasswordTextControllerValidator;
  // State field(s) for signUpConfirm widget.
  late FocusNode signUpConfirmPasswordVisibilityFocusNode;
  FocusNode? signUpConfirmFocusNode;
  TextEditingController? signUpConfirmTextController;
  late bool signUpConfirmVisibility;
  String? Function(BuildContext, String?)? signUpConfirmTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in SignUpSubmitButton widget.
  UsersRecord? signupTaken;

  @override
  void initState(BuildContext context) {
    signUpUsernameTextControllerValidator =
        _signUpUsernameTextControllerValidator;
    signUpPasswordPasswordVisibilityFocusNode = FocusNode();
    signUpPasswordVisibility = false;
    signUpConfirmPasswordVisibilityFocusNode = FocusNode();
    signUpConfirmVisibility = false;
  }

  @override
  void dispose() {
    signUpNameFocusNode?.dispose();
    signUpNameTextController?.dispose();

    signUpUsernameFocusNode?.dispose();
    signUpUsernameTextController?.dispose();

    signUpEmailFocusNode?.dispose();
    signUpEmailTextController?.dispose();

    signUpPasswordFocusNode?.dispose();
    signUpPasswordTextController?.dispose();
    signUpPasswordPasswordVisibilityFocusNode.dispose();
    signUpConfirmFocusNode?.dispose();
    signUpConfirmTextController?.dispose();
    signUpConfirmPasswordVisibilityFocusNode.dispose();
  }
}
