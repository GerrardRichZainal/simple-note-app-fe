// lib/bloc/note_event.dart
import 'package:meta/meta.dart';
import '../data/models/note_model.dart';

// 🚫 HAPUS: part of 'note_bloc.dart';
// ✅ BIARKAN SEPERTI INI

@immutable
abstract class NoteEvent {}

class LoadNotesEvent extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final Note note;
  AddNoteEvent(this.note);
}

class UpdateNoteEvent extends NoteEvent {
  final String id;
  final Note note;
  UpdateNoteEvent(this.id, this.note);
}

class DeleteNoteEvent extends NoteEvent {
  final String id;
  DeleteNoteEvent(this.id);
}

class DeleteMultipleNotesEvent extends NoteEvent {
  final List<String> ids;
  DeleteMultipleNotesEvent(this.ids);
}