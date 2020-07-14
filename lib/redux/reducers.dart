import 'package:test/models/AppState.dart';
import 'package:test/models/Note.dart';
import 'package:test/redux/actions.dart';

AppState appStateReducers(AppState state, dynamic action) {
  if (action is AddNoteAction) {
    return addNote(state.notes, action);
  }
}

AppState addNote(List<Note> notes, AddNoteAction action) {
  notes.add(action.note);
  return AppState(notes);
}