import '/components/media_list_tile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'watchlist_page_widget.dart' show WatchlistPageWidget;
import 'package:flutter/material.dart';

class WatchlistPageModel extends FlutterFlowModel<WatchlistPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for MediaListTile.
  late FlutterFlowDynamicModels<MediaListTileModel> mediaListTileModels;

  @override
  void initState(BuildContext context) {
    mediaListTileModels = FlutterFlowDynamicModels(() => MediaListTileModel());
  }

  @override
  void dispose() {
    mediaListTileModels.dispose();
  }
}
