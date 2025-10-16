// lib/data/models/note_model.dart
class Note {
  final String id;
  final String title;
  final String body;

  const Note({
    required this.id,
    required this.title,
    required this.body,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id']?.toString() ?? json['ID']?.toString() ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }

  Note copyWith({
    String? id,
    String? title,
    String? body,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Note &&
        other.id == id &&
        other.title == title &&
        other.body == body;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ body.hashCode;
}

// Helper class untuk compare list
class ListEquality {
  bool equals<T>(List<T>? list1, List<T>? list2) {
    if (identical(list1, list2)) return true;
    if (list1 == null || list2 == null) return false;
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }
}