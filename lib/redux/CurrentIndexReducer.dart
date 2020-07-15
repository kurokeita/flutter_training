import 'package:redux/redux.dart';
import 'actions.dart';

int updateCurrentIndexReducer(int index, UpdateCurrentIndexAction action) {
  return action.currentIndex;
}

Reducer<int> currentIndexReducer = combineReducers<int>([
  new TypedReducer<int, UpdateCurrentIndexAction>(updateCurrentIndexReducer)
]);