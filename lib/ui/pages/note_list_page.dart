// lib/ui/pages/note_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/note_bloc.dart';
import '../../data/models/note_model.dart';
import 'note_detail_page.dart';
import 'note_add_page.dart';
import '../widgets/note_item_widget.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  List<Note> selectedNotes = [];
  bool isSelectionMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note List'),
        actions: [
          if (!isSelectionMode)
            IconButton(
              icon: const Icon(Icons.select_all),
              onPressed: () {
                setState(() {
                  isSelectionMode = true;
                });
              },
            ),
          if (isSelectionMode)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                if (selectedNotes.isNotEmpty) {
                  context.read<NoteBloc>().add(
                    DeleteMultipleNotesEvent(
                      selectedNotes.map((note) => note.id).toList(),
                    ),
                  );
                  setState(() {
                    selectedNotes.clear();
                    isSelectionMode = false;
                  });
                }
              },
            ),
        ],
      ),
      body: BlocConsumer<NoteBloc, NoteState>(  // ✅ PAKAI BlocConsumer
        listener: (context, state) {
          if (state is NoteErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is NoteLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesLoadedState) {
            final notes = state.notes;
            
            if (notes.isEmpty) {
              return const Center(
                child: Text('No notes available. Tap + to add a new note.'),
              );
            }

            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) => NoteItemWidget(
                note: notes[index],
                isSelectionMode: isSelectionMode,
                isSelected: selectedNotes.contains(notes[index]),
                onTap: () {
                  if (isSelectionMode) {
                    setState(() {
                      if (selectedNotes.contains(notes[index])) {
                        selectedNotes.remove(notes[index]);
                      } else {
                        selectedNotes.add(notes[index]);
                      }
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailPage(note: notes[index]),
                      ),
                    );
                  }
                },
                onLongPress: () {
                  setState(() {
                    isSelectionMode = true;
                    if (!selectedNotes.contains(notes[index])) {
                      selectedNotes.add(notes[index]);
                    }
                  });
                },
              ),
            );
          } else if (state is NoteErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NoteBloc>().add(LoadNotesEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNotePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}