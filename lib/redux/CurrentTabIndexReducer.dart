import 'package:redux/redux.dart';
import 'actions.dart';

int updateCurrentTabIndexReducer(
    int index, UpdateCurrentTabIndexAction action) {
  return action.currentIndex;
}

Reducer<int> currentTabIndexReducer = combineReducers<int>([
  new TypedReducer<int, UpdateCurrentTabIndexAction>(
      updateCurrentTabIndexReducer)
]);
