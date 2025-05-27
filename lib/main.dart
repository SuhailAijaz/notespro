import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_pro/splash_screen.dart';

void main() {
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

