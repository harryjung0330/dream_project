import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackerton_project/view/create_new_passwd_create_new_ps.dart';
import 'package:hackerton_project/view/create_new_passwd_verification.dart';
import 'package:hackerton_project/view/find_id_screen.dart';
import 'package:hackerton_project/view/finish_sign_up.dart';
import 'package:hackerton_project/view/login_screen.dart';
import 'package:hackerton_project/view/new_pass_success.dart';
import 'package:hackerton_project/view/show_id.dart';
import 'package:hackerton_project/view/sign_up.dart';

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
        primaryColor: Colors.blueAccent[700]
      ),
      home: const LogInScreen(),
    );
  }
}


