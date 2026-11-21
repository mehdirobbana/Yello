import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'match_swipe_page_widget.dart' show MatchSwipePageWidget;
import 'package:flutter/material.dart';

class MatchSwipePageModel extends FlutterFlowModel<MatchSwipePageWidget> {
  ///  Local state fields for this page.

  DocumentReference? roomRef;

  List<int> deck = [];
  void addToDeck(int item) => deck.add(item);
  void removeFromDeck(int item) => deck.remove(item);
  void removeAtIndexFromDeck(int index) => deck.removeAt(index);
  void insertAtIndexInDeck(int index, int item) => deck.insert(index, item);
  void updateDeckAtIndex(int index, Function(int) updateFn) =>
      deck[index] = updateFn(deck[index]);

  int? round = 1;

  int? index = 0;

  bool? busy = false;

  MediaDetailsStruct? card;
  void updateCardStruct(Function(MediaDetailsStruct) updateFn) {
    updateFn(card ??= MediaDetailsStruct());
  }

  MediaListResponseStruct? deckResponse;
  void updateDeckResponseStruct(Function(MediaListResponseStruct) updateFn) {
    updateFn(deckResponse ??= MediaListResponseStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in MatchSwipePage widget.
  RoomsRecord? swipeRoom;
  // Stores action output result for [Backend Call - API (TmdbMovieDetails)] action in MatchSwipePage widget.
  ApiCallResponse? cardOnLoad;
  // Stores action output result for [Backend Call - API (TmdbMovieDetails)] action in NewRoundButton widget.
  ApiCallResponse? cardRound;
  // Stores action output result for [Backend Call - Create Document] action in PassButton widget.
  RoomSwipesRecord? document;
  // Stores action output result for [Backend Call - API (TmdbMovieDetails)] action in PassButton widget.
  ApiCallResponse? cardPass;
  // Stores action output result for [Backend Call - Create Document] action in LikeMovieButton widget.
  RoomSwipesRecord? document2;
  // Stores action output result for [Firestore Query - Query a collection] action in LikeMovieButton widget.
  List<RoomSwipesRecord>? likesLike;
  // Stores action output result for [Backend Call - Read Document] action in LikeMovieButton widget.
  RoomsRecord? roomLike;
  // Stores action output result for [Backend Call - API (TmdbMovieDetails)] action in LikeMovieButton widget.
  ApiCallResponse? cardLike;
  // Stores action output result for [Backend Call - API (TmdbPopularMovies)] action in RestartDeckButton widget.
  ApiCallResponse? restartDeck;
  // Stores action output result for [Backend Call - API (TmdbMovieDetails)] action in RestartDeckButton widget.
  ApiCallResponse? cardRestart;
  // Stores action output result for [Firestore Query - Query a collection] action in AddMatchToWatchlistButton widget.
  List<WatchlistRecord>? matchInWatchlist;
  // Stores action output result for [Backend Call - Create Document] action in AddMatchToWatchlistButton widget.
  WatchlistRecord? document3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
