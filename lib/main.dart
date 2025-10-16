import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/note_bloc.dart';
import 'bloc/note_event.dart';
import 'ui/pages/note_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc()..add(LoadNotesEvent()),
      child: MaterialApp(
        title: 'Notes App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const NoteListPage(),
      ),
    );
  }
}
