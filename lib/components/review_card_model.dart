import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'review_card_widget.dart' show ReviewCardWidget;
import 'package:flutter/material.dart';

class ReviewCardModel extends FlutterFlowModel<ReviewCardWidget> {
  ///  Local state fields for this component.

  bool? revealed = false;

  bool? likeBusy = false;

  List<ReviewLikesRecord> likes = [];
  void addToLikes(ReviewLikesRecord item) => likes.add(item);
  void removeFromLikes(ReviewLikesRecord item) => likes.remove(item);
  void removeAtIndexFromLikes(int index) => likes.removeAt(index);
  void insertAtIndexInLikes(int index, ReviewLikesRecord item) =>
      likes.insert(index, item);
  void updateLikesAtIndex(int index, Function(ReviewLikesRecord) updateFn) =>
      likes[index] = updateFn(likes[index]);

  List<ReviewLikesRecord> myLikes = [];
  void addToMyLikes(ReviewLikesRecord item) => myLikes.add(item);
  void removeFromMyLikes(ReviewLikesRecord item) => myLikes.remove(item);
  void removeAtIndexFromMyLikes(int index) => myLikes.removeAt(index);
  void insertAtIndexInMyLikes(int index, ReviewLikesRecord item) =>
      myLikes.insert(index, item);
  void updateMyLikesAtIndex(int index, Function(ReviewLikesRecord) updateFn) =>
      myLikes[index] = updateFn(myLikes[index]);

  String? authorName = '';

  String? authorPhoto = '';

  String? authorUsername = '';

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in ReviewCard widget.
  List<ReviewLikesRecord>? likesOnInit;
  // Stores action output result for [Firestore Query - Query a collection] action in ReviewCard widget.
  List<ReviewLikesRecord>? myLikesOnInit;
  // Stores action output result for [Firestore Query - Query a collection] action in ReviewCard widget.
  UsersRecord? authorDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in UnlikeButton widget.
  List<ReviewLikesRecord>? toggleLikeA;
  // Stores action output result for [Backend Call - Create Document] action in UnlikeButton widget.
  ReviewLikesRecord? document;
  // Stores action output result for [Firestore Query - Query a collection] action in UnlikeButton widget.
  List<ReviewLikesRecord>? myLikesAfterA;
  // Stores action output result for [Firestore Query - Query a collection] action in UnlikeButton widget.
  List<ReviewLikesRecord>? likesAfterA;
  // Stores action output result for [Firestore Query - Query a collection] action in LikeButton widget.
  List<ReviewLikesRecord>? toggleLikeB;
  // Stores action output result for [Backend Call - Create Document] action in LikeButton widget.
  ReviewLikesRecord? document2;
  // Stores action output result for [Firestore Query - Query a collection] action in LikeButton widget.
  List<ReviewLikesRecord>? myLikesAfterB;
  // Stores action output result for [Firestore Query - Query a collection] action in LikeButton widget.
  List<ReviewLikesRecord>? likesAfterB;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
