import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_pro/note.dart';
import 'package:notes_pro/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();                   // Initialize Hive
  Hive.registerAdapter(NoteAdapter());        // Register the Note model
  await Hive.openBox<Note>('notes');          // Open a box to store notes

  runApp( NotesApp());
}

class NotesApp  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return GetMaterialApp(
       debugShowCheckedModeBanner: false,
       home: SplashScreen(),);
  }
}

