// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'data/services/note_service.dart';
import 'data/services/remote_note_service.dart';
import 'data/services/memory_note_service.dart';
import 'data/repositories/note_repository_impl.dart';
import 'bloc/note_bloc.dart';
import 'ui/pages/note_list_page.dart';

void main() {
  runApp(MyApp(useRemoteService: true)); // Change to false for in-memory
}

class MyApp extends StatelessWidget {
  final bool useRemoteService;

  const MyApp({super.key, required this.useRemoteService});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NoteService>(
          create: (context) => useRemoteService
              ? RemoteNoteService(client: http.Client())
              : MemoryNoteService(),
        ),
        RepositoryProvider<NoteRepository>(
          create: (context) => NoteRepository(
            noteService: RepositoryProvider.of<NoteService>(context),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => NoteBloc(
          noteRepository: RepositoryProvider.of<NoteRepository>(context),
        )..add(LoadNotesEvent()),
        child: MaterialApp(
          title: useRemoteService ? 'Notes App (Remote)' : 'Notes App (Memory)',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: NoteListPage(),
        ),
      ),
    );
  }
}