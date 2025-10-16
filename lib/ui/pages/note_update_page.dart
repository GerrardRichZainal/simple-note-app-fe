// lib/ui/pages/note_update_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/note_bloc.dart';
import '../../data/models/note_model.dart';

class UpdateNotePage extends StatefulWidget {
  final Note note;

  const UpdateNotePage({super.key, required this.note});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: BlocListener<NoteBloc, NoteState>(
                listener: (context, state) {
                  if (state is NoteOperationSuccessState) {
                    Navigator.pop(context);
                  }
                  if (state is NoteErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a title')),
                      );
                      return;
                    }

                    final updatedNote = Note(
                      id: widget.note.id,
                      title: _titleController.text,
                      body: _contentController.text,
                    );
                    context.read<NoteBloc>().add(
                      UpdateNoteEvent(widget.note.id, updatedNote),
                    );
                  },
                  child: const Text('Save Changes'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}