import 'package:quiver/core.dart';

import 'package:test/models/AppState.dart';
import 'package:test/models/Note.dart';

List<Note> notesSelector(AppState state) => state.notes;

int lastIndexSelector(AppState state) => state.lastIndex;

int currentTabIndexSelector(AppState state) => state.currentTabIndex;

Optional<Note> noteSelector(List<Note> notes, int index) {
  try {
    return Optional.of(notes.firstWhere((note) => note.index == index));
  } catch (e) {
    return Optional.absent();
  }
}