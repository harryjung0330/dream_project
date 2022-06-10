import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackerton_project/view/export_view.dart';

import '../controller/controller.dart';
import '../model/export_file.dart';

class RecentArticleScreen extends StatefulWidget
{
  static const String route = '/recentArticleScreen';

  const RecentArticleScreen({Key? key}) : super(key: key);

  @override
  State<RecentArticleScreen> createState() => _RecentArticleScreenState();
}

class _RecentArticleScreenState extends State<RecentArticleScreen> {
 late List<Article> recentViewArticles;

  @override
  void initState(){
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    recentViewArticles = ModalRoute.of(context)!.settings.arguments as List<Article>;

    return MainFrame(mainWidget: Column(
      children: [
        Flexible(
            flex: 2,
            child: Row(
            children: [
              IconButton(
              icon:Icon(Icons.arrow_back_ios_outlined,
              color: Theme.of(context).primaryColor),
              onPressed: () {
              print("back button is pressed!");
                Navigator.of(context).pop(null);
              },
            ),
            spacer(1),
            Text("최근 본 기사", textScaleFactor: 1.2, style: TextStyle(color: Theme.of(context).primaryColor),),
            spacer(20)
            ],)
        ),
        Flexible(
            flex: 20,
            child: articlesView(recentViewArticles),
        )
      ],
    ), iconButtons: RowButton(pressedButton: RowButton.MY_INFO_BUTTON)
    );
  }

  @override
  void dispose()
  {
    super.dispose();

  }


  Widget articlesView(List<Article> articles)
  {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return articleComponent(articles[index]);
        },
        separatorBuilder: (a, b) => const Divider(
            height: 5,
            thickness: 1,
            endIndent: 0,
            color: Color(0xFF2799FA)
        ),
        itemCount: articles.length);
  }


  Widget articleComponent(Article article)
  {
    return GestureDetector(
      onTap:(){
        Navigator.pushNamed(context, ArticleRecentDetailScreen.route, arguments: article);
      },
      child: Container(
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child:
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 3,
                      child: SizedBox(
                          width: double.infinity,
                          child: Image.network(article.pictUrl))
                  ),
                  spacer(1),
                  Flexible(
                      flex:4,
                      child:Text(article.title, textScaleFactor: 1.5,)
                  )


                ],
              )
          )
      ),
    );
  }



  Widget spacer(int flex) {
    return Flexible(
      flex: flex,
      child: Container(),
    );
  }
  //----------------------------------------------------------------------



}