import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackerton_project/view/export_view.dart';

import '../controller/controller.dart';
import '../model/export_file.dart';

class RecommendArticleScreen extends StatefulWidget
{
  static const String route = '/recommendArticleScreen';

  const RecommendArticleScreen({Key? key}) : super(key: key);

  @override
  State<RecommendArticleScreen> createState() => _RecommendArticleScreenState();
}

class _RecommendArticleScreenState extends State<RecommendArticleScreen> {
  Controller cont = Controller();
  TextEditingController keywordController = TextEditingController();

  bool searching = false;

  @override
  void initState(){
    super.initState();

    //키워드칸에 아무것도 없으면 추천을 가져온다.
    keywordController.addListener(() {
      if(keywordController.text.length == 0 && searching){
        searching = false;
        setState((){});
      }
    });

  }
  @override
  Widget build(BuildContext context) {

    return MainFrame(mainWidget: Column(
      children: [
        Flexible(
          flex: 2,
            child: searchBox()),
       Flexible(
            flex: 20,
            child: searching ? searchView() :recommendView()) ,
      ],
    ), iconButtons: RowButton(pressedButton: RowButton.ARTICLE_BUTTON)
    );
  }

  @override
  void dispose()
  {
    super.dispose();
    keywordController.dispose();
  }

  Widget searchBox()
  {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF5F0F0),
          borderRadius: BorderRadius.all(Radius.circular(20)
        ),

        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 6,
                  child: Center(
                    child: IconButton(
                          icon: SvgPicture.asset('assets/logos/filled_search_re.svg'),
                      onPressed: onPressSearchButton,
                    ),
                  )
              ),
              Flexible(
                flex: 18,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '키워드를 입력하세요.',
                  ),
                  controller: keywordController,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget recommendView()
  {
    return FutureBuilder( future: getRecommendedArticle(),
        builder:(BuildContext context, AsyncSnapshot<dynamic> snapShot){
          if(snapShot.connectionState == ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator());
          }
          else if(snapShot.connectionState == ConnectionState.done)
          {
            if(snapShot.hasError)
            {
              print(snapShot.error);
              print("error has occurred!");
              return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요."));
            }
          }
          DataResponse<List<Article>> data = snapShot.hasData ? snapShot.data: [];
          if(data.errorCode == -1)
            {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(LogInScreen.route, (Route<dynamic> route) => false);
            }
          else if(data.errorCode == 1)
            {
              print("error code is 1");

              return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요"));
            }



          return articlesView(data.data ?? []);
        }
    );
  }

  Widget searchView()
  {
    return FutureBuilder( future: getSearchKeyword(),
        builder:(BuildContext context, AsyncSnapshot<dynamic> snapShot){
          if(snapShot.connectionState == ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator());
          }
          else if(snapShot.connectionState == ConnectionState.done)
          {
            if(snapShot.hasError)
            {
              print(snapShot.error);
              print("error has occurred!");
              return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요."));
            }
          }
          DataResponse<List<Article>> data = snapShot.hasData ? snapShot.data: [];
          if(data.errorCode == -1)
          {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(LogInScreen.route, (Route<dynamic> route) => false);
          }
          else if(data.errorCode == 1)
          {
            print("error code is 1");

            return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요"));
          }



          return articlesView(data.data ?? []);
        }
    );
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
        Navigator.pushNamed(context, ArticleDetailScreen.route, arguments: article);
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

  void onPressSearchButton() async
  {
    if(keywordController.text.length != 0)
      {
        searching = true;
        setState((){});
      }
  }


//-----------------------------------------------------------------------
  Future<DataResponse<List<Article>>> getRecommendedArticle() async
  {
    return await cont.getRecommendedArticles();
  }

  Future<DataResponse<List<Article>>> getSearchKeyword() async
  {
    String keyword = keywordController.text;
    if(keyword.length != 0)
    {
      return await cont.getSearchArticles(keyword: keyword);
    }

    return DataResponse(errorCode: 1);
  }


}
