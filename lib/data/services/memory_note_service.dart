// lib/data/services/memory_note_service.dart
import 'note_service.dart';
import '../models/note_model.dart';

class MemoryNoteService implements NoteService {
  final List<Note> _notes = [];
  int _nextId = 1;

  @override
  Future<List<Note>> getNotes() async {
    await Future.delayed(const Duration(milliseconds: 500)); // ✅ TAMBAH const
    return List<Note>.from(_notes);
  }

  @override
  Future<Note> getNoteById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300)); // ✅ TAMBAH const
    final note = _notes.firstWhere(
      (note) => note.id == id,
      orElse: () => throw Exception('Note not found'),
    );
    return note;
  }

  @override
  Future<Note> createNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 400)); // ✅ TAMBAH const
    final newNote = note.copyWith(id: (_nextId++).toString());
    _notes.add(newNote);
    return newNote;
  }

  @override
  Future<Note> updateNote(String id, Note updatedNote) async {
    await Future.delayed(const Duration(milliseconds: 400)); // ✅ TAMBAH const
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      _notes[index] = updatedNote.copyWith(id: id);
      return _notes[index];
    } else {
      throw Exception('Note not found');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    await Future.delayed(const Duration(milliseconds: 300)); // ✅ TAMBAH const
    _notes.removeWhere((note) => note.id == id);
  }
}