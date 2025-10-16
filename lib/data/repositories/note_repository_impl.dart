// lib/data/repositories/note_repository.dart
import '../services/note_service.dart';
import '../models/note_model.dart';

class NoteRepository {
  final NoteService noteService;

  NoteRepository({required this.noteService});

  Future<List<Note>> getNotes() async {
    try {
      return await noteService.getNotes();
    } catch (e) {
      throw Exception('Failed to load notes: $e');
    }
  }

  Future<Note> getNoteById(String id) async {
    try {
      return await noteService.getNoteById(id);
    } catch (e) {
      throw Exception('Failed to load note: $e');
    }
  }

  Future<Note> addNote(Note note) async {
    if (note.title.isEmpty) {
      throw Exception('Title cannot be empty');
    }
    try {
      return await noteService.createNote(note);
    } catch (e) {
      throw Exception('Failed to create note: $e');
    }
  }

  Future<Note> updateNote(String id, Note note) async {
    if (note.title.isEmpty) {
      throw Exception('Title cannot be empty');
    }
    try {
      return await noteService.updateNote(id, note);
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await noteService.deleteNote(id);
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }
}