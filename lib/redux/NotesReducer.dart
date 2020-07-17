import 'package:redux/redux.dart';
import 'actions.dart';

import 'package:test/models/Note.dart';

List<Note> addNoteReducer(List<Note> notes, AddNoteAction action) {
  notes.add(action.note);
  return notes;
}

List<Note> likeNoteReducer(List<Note> notes, LikeNoteAction action) {
  final int index = action.index;
  notes = notes
      .map((note) => note.index == index ? Note(index, note.count + 1) : note)
      .toList();
  return notes;
}

List<Note> dislikeNoteReducer(List<Note> notes, DislikeNoteAction action) {
  final int index = action.index;
  notes = notes
      .map((note) => note.index == index
          ? Note(index, note.count > 0 ? note.count - 1 : note.count)
          : note)
      .toList();
  return notes;
}

List<Note> deleteNoteReducer(List<Note> notes, DeleteNoteAction action) {
  final int index = action.index;
  notes.removeWhere((note) => note.index == index);
  return notes;
}

List<Note> likeAllReducer(List<Note> notes, LikeAllAction action) {
  return notes.map((note) => Note(note.index, note.count + 1)).toList();
}

List<Note> dislikeAllReducer(List<Note> notes, DislikeAllAction action) {
  return notes
      .map((note) => Note(note.index, note.count > 0 ? note.count - 1 : 0))
      .toList();
}

List<Note> resetCounterReducer(List<Note> notes, ResetCounterAction action) {
  return notes.map((note) => Note(note.index, 0)).toList();
}

List<Note> deleteAllReducer(List<Note> notes, DeleteAllAction action) {
  return List<Note>();
}

Reducer<List<Note>> notesReducer = combineReducers<List<Note>>([
  new TypedReducer<List<Note>, AddNoteAction>(addNoteReducer),
  new TypedReducer<List<Note>, LikeNoteAction>(likeNoteReducer),
  new TypedReducer<List<Note>, DislikeNoteAction>(dislikeNoteReducer),
  new TypedReducer<List<Note>, DeleteNoteAction>(deleteNoteReducer),
  new TypedReducer<List<Note>, LikeAllAction>(likeAllReducer),
  new TypedReducer<List<Note>, DislikeAllAction>(dislikeAllReducer),
  new TypedReducer<List<Note>, ResetCounterAction>(resetCounterReducer),
  new TypedReducer<List<Note>, DeleteAllAction>(deleteAllReducer),
]);
