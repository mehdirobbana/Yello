import '/components/username_tag_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'my_qr_sheet_widget.dart' show MyQrSheetWidget;
import 'package:flutter/material.dart';

class MyQrSheetModel extends FlutterFlowModel<MyQrSheetWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for MyQrUsername.
  late UsernameTagModel myQrUsernameModel;

  @override
  void initState(BuildContext context) {
    myQrUsernameModel = createModel(context, () => UsernameTagModel());
  }

  @override
  void dispose() {
    myQrUsernameModel.dispose();
  }
}
