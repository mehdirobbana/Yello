import '/backend/backend.dart';
import '/components/empty_state_widget.dart';
import '/components/loading_state_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_friend_page_widget.dart' show AddFriendPageWidget;
import 'package:flutter/material.dart';

class AddFriendPageModel extends FlutterFlowModel<AddFriendPageWidget> {
  ///  Local state fields for this page.

  String? searchText = '';

  List<UsersRecord> results = [];
  void addToResults(UsersRecord item) => results.add(item);
  void removeFromResults(UsersRecord item) => results.remove(item);
  void removeAtIndexFromResults(int index) => results.removeAt(index);
  void insertAtIndexInResults(int index, UsersRecord item) =>
      results.insert(index, item);
  void updateResultsAtIndex(int index, Function(UsersRecord) updateFn) =>
      results[index] = updateFn(results[index]);

  bool? isLoading = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for friendSearchField widget.
  FocusNode? friendSearchFieldFocusNode;
  TextEditingController? friendSearchFieldTextController;
  String? Function(BuildContext, String?)?
      friendSearchFieldTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in friendSearchField widget.
  List<UsersRecord>? found;
  // Model for TypeToSearchHint.
  late EmptyStateModel typeToSearchHintModel;
  // Model for SearchingState.
  late LoadingStateModel searchingStateModel;
  // Model for NoUserFound.
  late EmptyStateModel noUserFoundModel;

  @override
  void initState(BuildContext context) {
    typeToSearchHintModel = createModel(context, () => EmptyStateModel());
    searchingStateModel = createModel(context, () => LoadingStateModel());
    noUserFoundModel = createModel(context, () => EmptyStateModel());
  }

  @override
  void dispose() {
    friendSearchFieldFocusNode?.dispose();
    friendSearchFieldTextController?.dispose();

    typeToSearchHintModel.dispose();
    searchingStateModel.dispose();
    noUserFoundModel.dispose();
  }
}
