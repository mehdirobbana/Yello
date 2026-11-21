import 'package:flutter/material.dart'
    show ChangeNotifier, Color, Colors, VoidCallback;
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _hasSeenOnboarding =
          prefs.getBool('ff_hasSeenOnboarding') ?? _hasSeenOnboarding;
    });
    _safeInit(() {
      _picksMood = prefs.getString('ff_picksMood') ?? _picksMood;
    });
    _safeInit(() {
      _picksType = prefs.getString('ff_picksType') ?? _picksType;
    });
    _safeInit(() {
      _picksGenres = prefs.getStringList('ff_picksGenres') ?? _picksGenres;
    });
    _safeInit(() {
      _picksMaxMinutes = prefs.getInt('ff_picksMaxMinutes') ?? _picksMaxMinutes;
    });
    _safeInit(() {
      _picksMinRating = prefs.getDouble('ff_picksMinRating') ?? _picksMinRating;
    });
    _safeInit(() {
      _picksIncludeSaved =
          prefs.getBool('ff_picksIncludeSaved') ?? _picksIncludeSaved;
    });
    _safeInit(() {
      _picksDismissed =
          prefs.getStringList('ff_picksDismissed') ?? _picksDismissed;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  /// True once the first-use walkthrough was finished or skipped (per device).
  bool _hasSeenOnboarding = false;
  bool get hasSeenOnboarding => _hasSeenOnboarding;
  set hasSeenOnboarding(bool value) {
    _hasSeenOnboarding = value;
    prefs.setBool('ff_hasSeenOnboarding', value);
  }

  /// Yello Picks: last mood.
  String _picksMood = '';
  String get picksMood => _picksMood;
  set picksMood(String value) {
    _picksMood = value;
    prefs.setString('ff_picksMood', value);
  }

  /// Yello Picks: movie or tv.
  String _picksType = 'movie';
  String get picksType => _picksType;
  set picksType(String value) {
    _picksType = value;
    prefs.setString('ff_picksType', value);
  }

  /// Yello Picks: selected genres.
  List<String> _picksGenres = [];
  List<String> get picksGenres => _picksGenres;
  set picksGenres(List<String> value) {
    _picksGenres = value;
    prefs.setStringList('ff_picksGenres', value);
  }

  void addToPicksGenres(String value) {
    picksGenres.add(value);
    prefs.setStringList('ff_picksGenres', _picksGenres);
  }

  void removeFromPicksGenres(String value) {
    picksGenres.remove(value);
    prefs.setStringList('ff_picksGenres', _picksGenres);
  }

  void removeAtIndexFromPicksGenres(int index) {
    picksGenres.removeAt(index);
    prefs.setStringList('ff_picksGenres', _picksGenres);
  }

  void updatePicksGenresAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    picksGenres[index] = updateFn(_picksGenres[index]);
    prefs.setStringList('ff_picksGenres', _picksGenres);
  }

  void insertAtIndexInPicksGenres(int index, String value) {
    picksGenres.insert(index, value);
    prefs.setStringList('ff_picksGenres', _picksGenres);
  }

  /// Yello Picks: max runtime (0 = any).
  int _picksMaxMinutes = 0;
  int get picksMaxMinutes => _picksMaxMinutes;
  set picksMaxMinutes(int value) {
    _picksMaxMinutes = value;
    prefs.setInt('ff_picksMaxMinutes', value);
  }

  /// Yello Picks: min TMDB rating (0 = any).
  double _picksMinRating = 0.0;
  double get picksMinRating => _picksMinRating;
  set picksMinRating(double value) {
    _picksMinRating = value;
    prefs.setDouble('ff_picksMinRating', value);
  }

  /// Yello Picks: include saved titles.
  bool _picksIncludeSaved = false;
  bool get picksIncludeSaved => _picksIncludeSaved;
  set picksIncludeSaved(bool value) {
    _picksIncludeSaved = value;
    prefs.setBool('ff_picksIncludeSaved', value);
  }

  /// Yello Picks: skipped mediaKeys.
  List<String> _picksDismissed = [];
  List<String> get picksDismissed => _picksDismissed;
  set picksDismissed(List<String> value) {
    _picksDismissed = value;
    prefs.setStringList('ff_picksDismissed', value);
  }

  void addToPicksDismissed(String value) {
    picksDismissed.add(value);
    prefs.setStringList('ff_picksDismissed', _picksDismissed);
  }

  void removeFromPicksDismissed(String value) {
    picksDismissed.remove(value);
    prefs.setStringList('ff_picksDismissed', _picksDismissed);
  }

  void removeAtIndexFromPicksDismissed(int index) {
    picksDismissed.removeAt(index);
    prefs.setStringList('ff_picksDismissed', _picksDismissed);
  }

  void updatePicksDismissedAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    picksDismissed[index] = updateFn(_picksDismissed[index]);
    prefs.setStringList('ff_picksDismissed', _picksDismissed);
  }

  void insertAtIndexInPicksDismissed(int index, String value) {
    picksDismissed.insert(index, value);
    prefs.setStringList('ff_picksDismissed', _picksDismissed);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
