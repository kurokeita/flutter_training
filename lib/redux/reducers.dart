import 'package:test/models/AppState.dart';
import 'package:test/redux/CurrentTabIndexReducer.dart';
import 'package:test/redux/NotesReducer.dart';
import 'package:test/redux/LastIndexReducer.dart';
import 'package:test/redux/actions.dart';

AppState appStateReducers(AppState state, dynamic action) => AppState(
    notes: notesReducer(state.notes, action),
    lastIndex: lastIndexReducer(state.lastIndex, action),
    currentTabIndex: currentTabIndexReducer(state.currentTabIndex, action));

AppState loadAppStateReducer(AppState state, LoadStateAction action) {
  return AppState.loadFromSharedPreference() as AppState;
}
