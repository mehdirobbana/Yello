import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/empty_state_widget.dart';
import '/components/loading_state_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'yello_picks_page_widget.dart' show YelloPicksPageWidget;
import 'package:flutter/material.dart';

class YelloPicksPageModel extends FlutterFlowModel<YelloPicksPageWidget> {
  ///  Local state fields for this page.

  List<PickItemStruct> picks = [];
  void addToPicks(PickItemStruct item) => picks.add(item);
  void removeFromPicks(PickItemStruct item) => picks.remove(item);
  void removeAtIndexFromPicks(int index) => picks.removeAt(index);
  void insertAtIndexInPicks(int index, PickItemStruct item) =>
      picks.insert(index, item);
  void updatePicksAtIndex(int index, Function(PickItemStruct) updateFn) =>
      picks[index] = updateFn(picks[index]);

  bool? isLoading = false;

  String? errorMsg = '';

  bool? hasResults = false;

  bool? editing = false;

  int? round = 0;

  bool? lastSurprise = false;

  bool? roomBusy = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getYelloPicks] action in GetPicksButton widget.
  List<PickItemStruct>? picksOut;
  // Stores action output result for [Custom Action - getYelloPicks] action in SurpriseMeButton widget.
  List<PickItemStruct>? picksOut2;
  // Model for LoadingState.
  late LoadingStateModel loadingStateModel;
  // Stores action output result for [Custom Action - getYelloPicks] action in RetryPicksButton widget.
  List<PickItemStruct>? picksOut3;
  // Model for EmptyState.
  late EmptyStateModel emptyStateModel;
  // Stores action output result for [Custom Action - saveToLibrary] action in IconButton widget.
  String? saveRes;
  // Stores action output result for [Custom Action - saveToLibrary] action in IconButton widget.
  String? saveRes2;
  // Stores action output result for [Custom Action - getYelloPicks] action in MorePicksButton widget.
  List<PickItemStruct>? picksOut4;
  // Stores action output result for [Custom Action - createPicksRoom] action in StartMatchFromPicksButton widget.
  String? roomCode;

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
