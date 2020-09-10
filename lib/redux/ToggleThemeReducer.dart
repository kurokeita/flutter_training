import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:test/models/AppState.dart';
import 'actions.dart';

bool toggleTheme(bool theme, ToggleThemeAction action) {
  return !action.theme;
}

Reducer<bool> toggleThemeReducer = combineReducers<bool>([
  new TypedReducer<bool, ToggleThemeAction>(
      toggleTheme)
]);