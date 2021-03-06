import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackerton_project/view/sign_up.dart';

import 'login_screen.dart';

class LauncherScreen extends StatefulWidget
{
  const LauncherScreen({Key? key}) : super(key: key);
  static const route = "/launcherScreen";

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {

  @override
  void initState()
  {
      super.initState();
      _navigateToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Center(
          child: SvgPicture.asset("assets/logos/home_launcher_re.svg")
        )
      ),
    );
  }

  void _navigateToHome(BuildContext context) async{
    await Future.delayed(Duration(milliseconds: 1500), (){});
    Navigator.pushReplacementNamed(context, LogInScreen.route);
  }
}

