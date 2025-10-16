// lib/bloc/note_event.dart
import 'package:meta/meta.dart';
import '../data/models/note_model.dart';

@immutable
abstract class NoteEvent {}

// Event untuk memuat semua catatan
class LoadNotesEvent extends NoteEvent {
  LoadNotesEvent();
}

// Event untuk menambahkan catatan
class AddNoteEvent extends NoteEvent {
  final Note note;

  AddNoteEvent(this.note); // Hapus const karena Note mungkin bukan const
}

// Event untuk memperbarui catatan berdasarkan id
class UpdateNoteEvent extends NoteEvent {
  final String id;
  final Note note;

  UpdateNoteEvent(this.id, this.note); // Hapus const
}

// Event untuk menghapus catatan berdasarkan id
class DeleteNoteEvent extends NoteEvent {
  final String id;

  DeleteNoteEvent(this.id);
}

// Event untuk menghapus beberapa catatan sekaligus
class DeleteMultipleNotesEvent extends NoteEvent {
  final List<String> ids;

  DeleteMultipleNotesEvent(this.ids);
}
