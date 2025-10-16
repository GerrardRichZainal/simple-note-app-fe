// lib/data/services/note_service.dart
import '../models/note_model.dart';  // 🆕 IMPORT INI

abstract class NoteService {
  Future<List<Note>> getNotes();
  Future<Note> getNoteById(String id);
  Future<Note> createNote(Note note);
  Future<Note> updateNote(String id, Note note);
  Future<void> deleteNote(String id);
}