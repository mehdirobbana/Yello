import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'match_lobby_page_widget.dart' show MatchLobbyPageWidget;
import 'package:flutter/material.dart';

class MatchLobbyPageModel extends FlutterFlowModel<MatchLobbyPageWidget> {
  ///  Local state fields for this page.

  DocumentReference? roomRef;

  List<String> followingIds = [];
  void addToFollowingIds(String item) => followingIds.add(item);
  void removeFromFollowingIds(String item) => followingIds.remove(item);
  void removeAtIndexFromFollowingIds(int index) => followingIds.removeAt(index);
  void insertAtIndexInFollowingIds(int index, String item) =>
      followingIds.insert(index, item);
  void updateFollowingIdsAtIndex(int index, Function(String) updateFn) =>
      followingIds[index] = updateFn(followingIds[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in MatchLobbyPage widget.
  RoomsRecord? lobbyRoom;
  // Stores action output result for [Firestore Query - Query a collection] action in MatchLobbyPage widget.
  List<FollowsRecord>? lobbyFollows;
  // Stores action output result for [Backend Call - Read Document] action in InviteFriendButton widget.
  RoomsRecord? roomForInvite;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
