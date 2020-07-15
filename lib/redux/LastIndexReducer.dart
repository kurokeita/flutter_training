import 'package:redux/redux.dart';
import 'actions.dart';

int updateLastIndexReducer(int index, UpdateLastIndexAction action) {
  return index + 1;
}

Reducer<int> lastIndexReducer = combineReducers<int>([
  new TypedReducer<int, UpdateLastIndexAction>(updateLastIndexReducer)
]);