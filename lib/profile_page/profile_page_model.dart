import '/backend/backend.dart';
import '/components/media_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  Local state fields for this page.

  String? bio = '';

  String? avatarUrl = 'https://api.dicebear.com/9.x/adventurer/png?seed=Felix';

  int? favCount = 0;

  int? watchCount = 0;

  int? reviewCount = 0;

  int? followersCount = 0;

  int? followingCount = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in ProfilePage widget.
  UsersRecord? myUserDoc;
  // Stores action output result for [Custom Action - countMyDocs] action in ProfilePage widget.
  int? favCountRes;
  // Stores action output result for [Custom Action - countMyDocs] action in ProfilePage widget.
  int? watchCountRes;
  // Stores action output result for [Custom Action - countMyDocs] action in ProfilePage widget.
  int? reviewCountRes;
  // Stores action output result for [Custom Action - countFollows] action in ProfilePage widget.
  int? followersRes;
  // Stores action output result for [Custom Action - countFollows] action in ProfilePage widget.
  int? followingRes;
  // Models for MediaCard.
  late FlutterFlowDynamicModels<MediaCardModel> mediaCardModels;

  @override
  void initState(BuildContext context) {
    mediaCardModels = FlutterFlowDynamicModels(() => MediaCardModel());
  }

  @override
  void dispose() {
    mediaCardModels.dispose();
  }
}
