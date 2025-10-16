// lib/ui/widgets/note_item_widget.dart
import 'package:flutter/material.dart';
import '../../data/models/note_model.dart';

class NoteItemWidget extends StatelessWidget {
  final Note note;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const NoteItemWidget({
    super.key,
    required this.note,
    required this.isSelectionMode,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        note.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(note.body),
      onTap: onTap,
      onLongPress: onLongPress,
      leading: isSelectionMode
          ? Checkbox(
              value: isSelected,
              onChanged: (value) => onTap(),
            )
          : const Icon(Icons.note),
    );
  }
}