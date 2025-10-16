// lib/data/services/remote_note_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'note_service.dart';
import '../models/note_model.dart';

class RemoteNoteService implements NoteService {
  final String baseUrl = "http://localhost:8080";
  final http.Client client;

  RemoteNoteService({required this.client});

  @override
  Future<List<Note>> getNotes() async {
    final response = await client.get(Uri.parse('$baseUrl/notes'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Note.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  @override
  Future<Note> getNoteById(String id) async {
    final response = await client.get(Uri.parse('$baseUrl/notes/$id'));
    if (response.statusCode == 200) {
      return Note.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load note');
    }
  }

  @override
  Future<Note> createNote(Note note) async {
    final response = await client.post(
      Uri.parse('$baseUrl/notes'),
      body: jsonEncode(note.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      return Note.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create note');
    }
  }

  @override
  Future<Note> updateNote(String id, Note note) async {
    final response = await client.patch(
      Uri.parse('$baseUrl/notes/$id'),
      body: jsonEncode(note.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return Note.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update note');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/notes/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete note');
    }
  }
}