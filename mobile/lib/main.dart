import 'package:flutter/material.dart';
import 'package:hackerton_project/view/export_view.dart';
import 'package:hackerton_project/view/sign_up.dart';
import "view/login_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF34E277)
      ),
      home: const LauncherScreen(),
    );
  }
}


