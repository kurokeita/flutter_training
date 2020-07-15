import 'package:redux/redux.dart';

import 'package:test/models/AppState.dart';
import 'package:test/redux/CurrentIndexReducer.dart';
import 'package:test/redux/NotesReducer.dart';
import 'package:test/redux/LastIndexReducer.dart';
import 'package:test/redux/actions.dart';

AppState appStateReducers(AppState state, dynamic action) => AppState(
  notesReducer(state.notes, action),
  lastIndexReducer(state.lastIndex, action),
  currentIndexReducer(state.currentIndex, action)
);

AppState loadAppStateReducer(AppState state, LoadStateAction action) {
  return AppState.loadFromSharedPreference() as AppState;
}