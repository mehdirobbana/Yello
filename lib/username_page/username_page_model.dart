import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'username_page_widget.dart' show UsernamePageWidget;
import 'package:flutter/material.dart';

class UsernamePageModel extends FlutterFlowModel<UsernamePageWidget> {
  ///  Local state fields for this page.

  String? typedUsername = '';

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in UsernamePage widget.
  UsersRecord? meDoc;
  // State field(s) for usernameField widget.
  FocusNode? usernameFieldFocusNode;
  TextEditingController? usernameFieldTextController;
  String? Function(BuildContext, String?)? usernameFieldTextControllerValidator;
  String? _usernameFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'nxd16jft' /* Choose a username */,
      );
    }

    if (val.length < 3) {
      return FFLocalizations.of(context).getText(
        'kahph3cg' /* At least 3 characters */,
      );
    }
    if (val.length > 20) {
      return FFLocalizations.of(context).getText(
        'puw6zhhs' /* At most 20 characters */,
      );
    }
    if (!RegExp('^[a-z0-9_.]+\$').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'dcmdofz5' /* Use lowercase letters, numbers... */,
      );
    }
    return null;
  }

  // Stores action output result for [Firestore Query - Query a collection] action in SaveUsernameButton widget.
  UsersRecord? takenBy;

  @override
  void initState(BuildContext context) {
    usernameFieldTextControllerValidator =
        _usernameFieldTextControllerValidator;
  }

  @override
  void dispose() {
    usernameFieldFocusNode?.dispose();
    usernameFieldTextController?.dispose();
  }
}
