import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller/controller.dart';
import '../model/export_file.dart';
import 'export_view.dart';

class ArticleRecentDetailScreen extends StatefulWidget
{
  static const route = '/articleRecentDetailScreen';

  const ArticleRecentDetailScreen();

  @override
  State<ArticleRecentDetailScreen> createState() => _ArticleRecentDetailScreenState();
}

class _ArticleRecentDetailScreenState extends State<ArticleRecentDetailScreen> {
  late Article article;
  late Controller cont = Controller();


  @override
  void initState()
  {
    print("initState of articleRecentDetailScreen Called!");

    super.initState();
  }

  @override
  void dispose()
  {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    article = ModalRoute.of(context)!.settings.arguments as Article;

    return MainFrame(mainWidget: mainWidget() , iconButtons: RowButton(pressedButton: RowButton.MY_INFO_BUTTON,) );
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
