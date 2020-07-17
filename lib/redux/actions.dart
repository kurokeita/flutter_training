import 'package:test/models/Note.dart';

class LoadStateAction {
  LoadStateAction();
}

class AddNoteAction {
  final Note note;
  AddNoteAction(this.note);
}

class LikeNoteAction {
  final int index;
  LikeNoteAction(this.index);
}

class DislikeNoteAction {
  final int index;
  DislikeNoteAction(this.index);
}

class DeleteNoteAction {
  final int index;
  DeleteNoteAction(this.index);
}

class LikeAllAction {
  LikeAllAction();
}

class DislikeAllAction {
  DislikeAllAction();
}

class ResetCounterAction {
  ResetCounterAction();
}

class DeleteAllAction {
  DeleteAllAction();
}

class UpdateLastIndexAction {
  UpdateLastIndexAction();
}

class UpdateCurrentTabIndexAction {
  final int currentIndex;
  UpdateCurrentTabIndexAction(this.currentIndex);
}
