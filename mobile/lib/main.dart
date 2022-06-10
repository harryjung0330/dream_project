import 'package:flutter/material.dart';
import 'package:hackerton_project/view/article_detail_screen.dart';
import 'package:hackerton_project/view/create_new_ps_screen.dart';
import 'package:hackerton_project/view/export_view.dart';
import 'package:hackerton_project/view/find_ps_screen.dart';
import 'package:hackerton_project/view/my_info_screen.dart';
import 'package:hackerton_project/view/recommend_article_screen.dart';
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


      routes:{
        LauncherScreen.route: (context) =>
        const LauncherScreen(),
        LogInScreen.route: (context) =>
            LogInScreen(),
        SignUpScreen.route: (context) =>
            SignUpScreen(),
        SignUpSuccessScreen.route: (context) =>
            const SignUpSuccessScreen(),
        RecommendArticleScreen.route:(context) =>
          RecommendArticleScreen(),
        ArticleDetailScreen.route: (context) =>
            ArticleDetailScreen(),
        VisitScreen.route: (context) =>
            VisitScreen(),
        VisitDetailScreen.route: (context) =>
            VisitDetailScreen(),
        DisplayJusoScreen.route: (context) =>
            DisplayJusoScreen(),
        VisitNewScreen.route: (context) =>
            VisitNewScreen(),
        FindPsScreen.route: (context) =>
            FindPsScreen(),
        CreateNewPsScreen.route: (context) =>
            CreateNewPsScreen(),
        SuccessCreatePsScreen.route: (context) =>
            SuccessCreatePsScreen(),
        MyInfoScreen.route: (context) =>
            MyInfoScreen(),
        LikedVisitsScreen.route: (context) =>
            LikedVisitsScreen(),
        VisitLikeDetailScreen.route: (context) =>
            VisitLikeDetailScreen(),
        RecentArticleScreen.route: (context) =>
            RecentArticleScreen(),
        ArticleRecentDetailScreen.route: (context) =>
            ArticleRecentDetailScreen(),
        GraphDataScreen.route: (context) =>
            GraphDataScreen()
      },
      title: 'Flutter Demo',
      theme: ThemeData(

        primaryColor: Color(0xFF2799FA)
      ),
      home: LauncherScreen(),
    );
  }
}


