import '/backend/backend.dart';
import '/components/empty_state_widget.dart';
import '/components/loading_state_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'notifications_page_widget.dart' show NotificationsPageWidget;
import 'package:flutter/material.dart';

class NotificationsPageModel extends FlutterFlowModel<NotificationsPageWidget> {
  ///  Local state fields for this page.

  DateTime? prevSeenAt;

  List<FollowsRecord> items = [];
  void addToItems(FollowsRecord item) => items.add(item);
  void removeFromItems(FollowsRecord item) => items.remove(item);
  void removeAtIndexFromItems(int index) => items.removeAt(index);
  void insertAtIndexInItems(int index, FollowsRecord item) =>
      items.insert(index, item);
  void updateItemsAtIndex(int index, Function(FollowsRecord) updateFn) =>
      items[index] = updateFn(items[index]);

  bool? loaded = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in NotificationsPage widget.
  UsersRecord? meForNotifications;
  // Stores action output result for [Custom Action - getMyFollowers] action in NotificationsPage widget.
  List<FollowsRecord>? myFollowers;
  // Model for LoadingState.
  late LoadingStateModel loadingStateModel;
  // Model for EmptyState.
  late EmptyStateModel emptyStateModel;

  @override
  void initState(BuildContext context) {
    loadingStateModel = createModel(context, () => LoadingStateModel());
    emptyStateModel = createModel(context, () => EmptyStateModel());
  }

  @override
  void dispose() {
    loadingStateModel.dispose();
    emptyStateModel.dispose();
  }
}
