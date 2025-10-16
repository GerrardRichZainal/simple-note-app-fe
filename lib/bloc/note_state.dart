// lib/bloc/note_state.dart
import 'package:meta/meta.dart';
import '../data/models/note_model.dart';

@immutable
abstract class NoteState {}

// State awal
class NoteInitial extends NoteState {}

// State saat memuat data
class NoteLoading extends NoteState {}

// State saat data berhasil dimuat
class NoteLoaded extends NoteState {
  final List<Note> notes;

  NoteLoaded(this.notes);
}

// State saat terjadi error
class NoteError extends NoteState {
  final String message;

  NoteError(this.message);
}
