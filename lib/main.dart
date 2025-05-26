import 'package:flutter/material.dart';
import 'package:notes_pro/splash_screen.dart';

void main() {
  runApp( NotesApp());
}

class NotesApp  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       home: SplashScreen(),);
  }
}

