// lib/bloc/note_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/note_repository_impl.dart';

// 🚫 HAPUS: part 'note_event.dart';
// 🚫 HAPUS: part 'note_state.dart';
// ✅ IMPORT manual:
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;

  NoteBloc({required this.noteRepository}) : super(NoteInitialState()) {
    on<LoadNotesEvent>(_onLoadNotes);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
    on<DeleteMultipleNotesEvent>(_onDeleteMultipleNotes);
  }

  Future<void> _onLoadNotes(LoadNotesEvent event, Emitter<NoteState> emit) async {
    emit(NoteLoadingState());
    try {
      final notes = await noteRepository.getNotes();
      emit(NotesLoadedState(notes));
    } catch (e) {
      emit(NoteErrorState(e.toString()));
    }
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NoteState> emit) async {
    try {
      await noteRepository.addNote(event.note);
      emit(NoteOperationSuccessState('Note added successfully'));
      add(LoadNotesEvent());
    } catch (e) {
      emit(NoteErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateNote(UpdateNoteEvent event, Emitter<NoteState> emit) async {
    try {
      await noteRepository.updateNote(event.id, event.note);
      emit(NoteOperationSuccessState('Note updated successfully'));
      add(LoadNotesEvent());
    } catch (e) {
      emit(NoteErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteNote(DeleteNoteEvent event, Emitter<NoteState> emit) async {
    try {
      await noteRepository.deleteNote(event.id);
      emit(NoteOperationSuccessState('Note deleted successfully'));
      add(LoadNotesEvent());
    } catch (e) {
      emit(NoteErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteMultipleNotes(DeleteMultipleNotesEvent event, Emitter<NoteState> emit) async {
    try {
      for (final id in event.ids) {
        await noteRepository.deleteNote(id);
      }
      emit(NoteOperationSuccessState('Notes deleted successfully'));
      add(LoadNotesEvent());
    } catch (e) {
      emit(NoteErrorState(e.toString()));
    }
  }
}