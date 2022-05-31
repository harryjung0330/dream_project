import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller/controller.dart';
import '../model/export_file.dart';
import 'export_view.dart';

class ArticleDetailScreen extends StatefulWidget
{
  static const route = '/articleDetailScreen';

  const ArticleDetailScreen();

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late Article article;
  late Controller cont;
  late Timer t;

  @override
  void initState()
  {
    print("initState of articleDetailScreen Called!");

    super.initState();
    t = Timer(Duration(seconds: 30),() async {
      if(article == null)
      {
          return;
      }

      await cont.readArticles(title: article.title , fetchTime: article.fetchTime);
      print("user read the article!");
    });
  }

  @override
  void dispose()
  {   t != null? t.cancel() : print("timer was null");
      print("timer is cancelled!");
      super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    article = ModalRoute.of(context)!.settings.arguments as Article;

    return MainFrame(mainWidget: mainWidget() , iconButtons: RowButton(pressedButton: RowButton.ARTICLE_BUTTON,) );
  }

  Widget mainWidget()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon:Icon(Icons.arrow_back_ios_outlined,
              color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Expanded(
          child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
            initialUrl: article.path,
          ),
        ),
      ],
    );
  }
}


