import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'match_home_page_widget.dart' show MatchHomePageWidget;
import 'package:flutter/material.dart';

class MatchHomePageModel extends FlutterFlowModel<MatchHomePageWidget> {
  ///  Local state fields for this page.

  String? newCode = '';

  String? joinCode = '';

  MediaListResponseStruct? deckResponse;
  void updateDeckResponseStruct(Function(MediaListResponseStruct) updateFn) {
    updateFn(deckResponse ??= MediaListResponseStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in CreateRoomButton widget.
  List<RoomsRecord>? codeTaken;
  // Stores action output result for [Backend Call - API (TmdbTrendingMovies)] action in CreateRoomButton widget.
  ApiCallResponse? deckTrending;
  // Stores action output result for [Backend Call - Create Document] action in CreateRoomButton widget.
  RoomsRecord? document;
  // State field(s) for JoinCodeField widget.
  FocusNode? joinCodeFieldFocusNode;
  TextEditingController? joinCodeFieldTextController;
  String? Function(BuildContext, String?)? joinCodeFieldTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in JoinRoomButton widget.
  List<RoomsRecord>? joinRoom;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    joinCodeFieldFocusNode?.dispose();
    joinCodeFieldTextController?.dispose();
  }
}
