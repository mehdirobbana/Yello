import '/backend/backend.dart';
import '/components/review_card_widget.dart';
import '/components/username_tag_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'public_profile_page_widget.dart' show PublicProfilePageWidget;
import 'package:flutter/material.dart';

class PublicProfilePageModel extends FlutterFlowModel<PublicProfilePageWidget> {
  ///  Local state fields for this page.

  String? profileName = '';

  String? profilePhoto =
      'https://api.dicebear.com/9.x/adventurer/png?seed=Felix';

  bool? followBusy = false;

  List<FollowsRecord> myFollows = [];
  void addToMyFollows(FollowsRecord item) => myFollows.add(item);
  void removeFromMyFollows(FollowsRecord item) => myFollows.remove(item);
  void removeAtIndexFromMyFollows(int index) => myFollows.removeAt(index);
  void insertAtIndexInMyFollows(int index, FollowsRecord item) =>
      myFollows.insert(index, item);
  void updateMyFollowsAtIndex(int index, Function(FollowsRecord) updateFn) =>
      myFollows[index] = updateFn(myFollows[index]);

  List<FollowsRecord> followers = [];
  void addToFollowers(FollowsRecord item) => followers.add(item);
  void removeFromFollowers(FollowsRecord item) => followers.remove(item);
  void removeAtIndexFromFollowers(int index) => followers.removeAt(index);
  void insertAtIndexInFollowers(int index, FollowsRecord item) =>
      followers.insert(index, item);
  void updateFollowersAtIndex(int index, Function(FollowsRecord) updateFn) =>
      followers[index] = updateFn(followers[index]);

  List<FollowsRecord> following = [];
  void addToFollowing(FollowsRecord item) => following.add(item);
  void removeFromFollowing(FollowsRecord item) => following.remove(item);
  void removeAtIndexFromFollowing(int index) => following.removeAt(index);
  void insertAtIndexInFollowing(int index, FollowsRecord item) =>
      following.insert(index, item);
  void updateFollowingAtIndex(int index, Function(FollowsRecord) updateFn) =>
      following[index] = updateFn(following[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in PublicProfilePage widget.
  UsersRecord? profileUser;
  // Stores action output result for [Firestore Query - Query a collection] action in PublicProfilePage widget.
  List<FollowsRecord>? mineOnLoad;
  // Stores action output result for [Firestore Query - Query a collection] action in PublicProfilePage widget.
  List<FollowsRecord>? followersOnLoad;
  // Stores action output result for [Firestore Query - Query a collection] action in PublicProfilePage widget.
  List<FollowsRecord>? followingOnLoad;
  // Model for PublicProfileUsername.
  late UsernameTagModel publicProfileUsernameModel;
  // Stores action output result for [Firestore Query - Query a collection] action in FollowButton widget.
  List<FollowsRecord>? toggleMine;
  // Stores action output result for [Backend Call - Create Document] action in FollowButton widget.
  FollowsRecord? document;
  // Stores action output result for [Firestore Query - Query a collection] action in FollowButton widget.
  List<FollowsRecord>? mineAfter;
  // Stores action output result for [Firestore Query - Query a collection] action in FollowButton widget.
  List<FollowsRecord>? followersAfter;
  // Models for ReviewCard.
  late FlutterFlowDynamicModels<ReviewCardModel> reviewCardModels;

  @override
  void initState(BuildContext context) {
    publicProfileUsernameModel = createModel(context, () => UsernameTagModel());
    reviewCardModels = FlutterFlowDynamicModels(() => ReviewCardModel());
  }

  @override
  void dispose() {
    publicProfileUsernameModel.dispose();
    reviewCardModels.dispose();
  }
}
