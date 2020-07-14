import 'package:test/models/Note.dart';

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

class UpdateLastIndexAction {
  final int lastIndex;
  UpdateLastIndexAction(this.lastIndex);
}