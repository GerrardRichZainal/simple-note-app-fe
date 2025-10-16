// lib/bloc/note_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'note_event.dart';
import 'note_state.dart';
import '../data/models/note_model.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  // List internal untuk menyimpan catatan
  final List<Note> _notes = [];

  NoteBloc() : super(NoteInitial()) {
    // Event LoadNotes
    on<LoadNotesEvent>((event, emit) {
      emit(NoteLoading());
      try {
        emit(NoteLoaded(List.from(_notes))); // Emit salinan list
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    // Event AddNote
    on<AddNoteEvent>((event, emit) {
      _notes.add(event.note);
      emit(NoteLoaded(List.from(_notes)));
    });

    // Event UpdateNote
    on<UpdateNoteEvent>((event, emit) {
      final index = _notes.indexWhere((note) => note.id == event.id);
      if (index != -1) {
        _notes[index] = event.note;
        emit(NoteLoaded(List.from(_notes)));
      } else {
        emit(NoteError('Note with id ${event.id} not found'));
      }
    });

    // Event DeleteNote
    on<DeleteNoteEvent>((event, emit) {
      _notes.removeWhere((note) => note.id == event.id);
      emit(NoteLoaded(List.from(_notes)));
    });

    // Event DeleteMultipleNotes
    on<DeleteMultipleNotesEvent>((event, emit) {
      _notes.removeWhere((note) => event.ids.contains(note.id));
      emit(NoteLoaded(List.from(_notes)));
    });
  }
}
