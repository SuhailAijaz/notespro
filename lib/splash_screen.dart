import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_pro/home_screen.dart';
import 'package:notes_pro/utils/app_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 4),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),)),);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: customLargeText(
                textValue: "LOGO",fontSize: 50)));
  }
}
