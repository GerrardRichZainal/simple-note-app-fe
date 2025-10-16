// lib/bloc/note_state.dart
import 'package:meta/meta.dart';
import '../data/models/note_model.dart';

// 🚫 HAPUS: part of 'note_bloc.dart';
// ✅ BIARKAN SEPERTI INI

@immutable
abstract class NoteState {}

class NoteInitialState extends NoteState {}

class NoteLoadingState extends NoteState {}

class NotesLoadedState extends NoteState {
  final List<Note> notes;
  NotesLoadedState(this.notes);
}

class NoteOperationSuccessState extends NoteState {
  final String message;
  NoteOperationSuccessState(this.message);
}

class NoteErrorState extends NoteState {
  final String message;
  NoteErrorState(this.message);
}