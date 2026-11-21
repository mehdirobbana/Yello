import '/backend/backend.dart';
import '/components/review_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'friends_feed_page_widget.dart' show FriendsFeedPageWidget;
import 'package:flutter/material.dart';

class FriendsFeedPageModel extends FlutterFlowModel<FriendsFeedPageWidget> {
  ///  Local state fields for this page.

  List<String> followingIds = [];
  void addToFollowingIds(String item) => followingIds.add(item);
  void removeFromFollowingIds(String item) => followingIds.remove(item);
  void removeAtIndexFromFollowingIds(int index) => followingIds.removeAt(index);
  void insertAtIndexInFollowingIds(int index, String item) =>
      followingIds.insert(index, item);
  void updateFollowingIdsAtIndex(int index, Function(String) updateFn) =>
      followingIds[index] = updateFn(followingIds[index]);

  List<ReviewsRecord> feed = [];
  void addToFeed(ReviewsRecord item) => feed.add(item);
  void removeFromFeed(ReviewsRecord item) => feed.remove(item);
  void removeAtIndexFromFeed(int index) => feed.removeAt(index);
  void insertAtIndexInFeed(int index, ReviewsRecord item) =>
      feed.insert(index, item);
  void updateFeedAtIndex(int index, Function(ReviewsRecord) updateFn) =>
      feed[index] = updateFn(feed[index]);

  bool? loaded = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getFriendsFeed] action in FriendsFeedPage widget.
  List<ReviewsRecord>? friendsFeed;
  var scannedCode = '';
  // Stores action output result for [Custom Action - resolveFriendQr] action in ScanQrCodeButton widget.
  String? qrResult;
  // Models for ReviewCard.
  late FlutterFlowDynamicModels<ReviewCardModel> reviewCardModels;

  @override
  void initState(BuildContext context) {
    reviewCardModels = FlutterFlowDynamicModels(() => ReviewCardModel());
  }

  @override
  void dispose() {
    reviewCardModels.dispose();
  }
}
