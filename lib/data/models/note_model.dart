// lib/data/models/note_model.dart
class Note {
  final String id;
  final String title;
  final String content; // Pastikan ini ada, bukan 'body'
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content, // Ini yang harus digunakan
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor untuk fromJson
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '', // Pastikan menggunakan 'content'
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  // Method toJson untuk konversi ke Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content, // Pastikan menggunakan 'content'
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Copy with method untuk update
  Note copyWith({
    String? id,
    String? title,
    String? content, // Pastikan menggunakan 'content'
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content, // Pastikan menggunakan 'content'
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Note &&
        other.id == id &&
        other.title == title &&
        other.content == content && // Pastikan menggunakan 'content'
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^ // Pastikan menggunakan 'content'
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}