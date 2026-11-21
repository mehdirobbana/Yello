import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'settings_page_widget.dart' show SettingsPageWidget;
import 'package:flutter/material.dart';

class SettingsPageModel extends FlutterFlowModel<SettingsPageWidget> {
  ///  Local state fields for this page.

  String? currentBio = '';

  String? avatarUrl = 'https://api.dicebear.com/9.x/adventurer/png?seed=Felix';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in SettingsPage widget.
  UsersRecord? myProfileDoc;
  // State field(s) for editName widget.
  FocusNode? editNameFocusNode;
  TextEditingController? editNameTextController;
  String? Function(BuildContext, String?)? editNameTextControllerValidator;
  // State field(s) for editBio widget.
  FocusNode? editBioFocusNode;
  TextEditingController? editBioTextController;
  String? Function(BuildContext, String?)? editBioTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    editNameFocusNode?.dispose();
    editNameTextController?.dispose();

    editBioFocusNode?.dispose();
    editBioTextController?.dispose();
  }
}
