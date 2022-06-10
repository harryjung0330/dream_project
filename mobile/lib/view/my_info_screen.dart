import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../controller/controller.dart';
import '../model/export_file.dart';
import 'export_view.dart';

class MyInfoScreen extends StatefulWidget
{
  const MyInfoScreen({Key? key}) : super(key: key);
  static const route = '/myInfoScreen';
  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  Controller cont = Controller();


  @override
  void initState(){
    super.initState();



  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return MainFrame(mainWidget:
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 1, child: userInfoView()),
              Flexible(flex: 1, child: recentViewArticle()),
              Flexible(flex: 1, child: getLikeVisits())
            ],
          ),
        ), iconButtons: RowButton(pressedButton: RowButton.MY_INFO_BUTTON));
  }

  @override
  void dispose()
  {
    super.dispose();
  }



  Widget userInfoView()
  {
    return FutureBuilder( future: getUserInfo(),
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
          DataResponse<UserInfo> data = snapShot.hasData ? snapShot.data: [];
          if(data.errorCode == -1)
          {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(LogInScreen.route, (Route<dynamic> route) => false);
          }
          else if(data.errorCode == 1 || data == null)
          {
            print("error code is 1");

            return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요"));
          }

          UserInfo userInfo = data.data!;


          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(flex: 2, child: Text("내 정보", style: TextStyle(color: Theme.of(context).primaryColor),
              textScaleFactor: 1.2,)),
              spacer(2),
              Flexible(
                flex:2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("닉네임", textScaleFactor: 1.2,),
                    Expanded(child: Container()),
                    Text(userInfo.nickname, textScaleFactor: 1.2,)
                  ],
                ),
              ),
              spacer(2),
              Flexible(
                  flex:2,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("이메일", textScaleFactor: 1.2,),
                      Expanded(child: Container()),
                      Text(userInfo.email, textScaleFactor: 1.2,)
                    ],
                  )
              ),
              spacer(2)
            ],

          );
        }
    );
  }


  Widget recentViewArticle()
  {
    return FutureBuilder( future: getRecentViewArticles(),
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
          else if(data.errorCode == 1 || data.data == null)
          {
            print("error code is 1");

            return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요"));
          }

         List<Article> articles = data.data!;


          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("최근 본 기사들", textScaleFactor: 1.2,),
                        Expanded(child: Container()),
                        IconButton( icon:Icon(Icons.arrow_forward_ios,
                            color: Theme.of(context).primaryColor),
                            onPressed: () {
                              Navigator.pushNamed(context, RecentArticleScreen.route, arguments: articles);
                            }),
                      ],
                    ),
                  )
              ),
              Flexible(flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor)
                  ),
                  child:articles.length == 0? Container(): Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                            flex: 3,
                            child: SizedBox(
                                width: double.infinity,
                                child: Image.network(articles[0].pictUrl))
                        ),
                        spacer(1),
                        Flexible(
                            flex:4,
                            child:Text(articles[0].title, textScaleFactor: 1.2,)
                        )
                      ]),
                )
                ,

              )
            ]
          );
    });

  }

  Widget getLikeVisits()
  {
    return FutureBuilder( future: getLikedVisits(),
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
          DataResponse<List<Visit>> data = snapShot.hasData ? snapShot.data: [];
          if(data.errorCode == -1)
          {
             Navigator.of(context)
                .pushNamedAndRemoveUntil(LogInScreen.route, (Route<dynamic> route) => false);
          }
          else if(data.errorCode == 1 || data.data == null)
          {
            print("error code is 1");

            return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요"));
          }

          List<Visit> visits = data.data!;


          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("관심 방문기", textScaleFactor: 1.2,),
                          Expanded(child: Container()),
                          IconButton( icon:Icon(Icons.arrow_forward_ios,
                              color: Theme.of(context).primaryColor),
                              onPressed: () async {
                                await Navigator.pushNamed(context, LikedVisitsScreen.route, arguments: visits);
                                setState((){});
                              }),
                        ],
                      ),
                    )
                ),
                Flexible(flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor)
                    ),
                    child:visits.length == 0? Container(): VisitComponent(tileHeight: double.infinity, visit: visits[0]),
                  )
                  ,

                )
              ]
          );
        });

  }




  Widget visitView(List<Visit> visits, double tileHeight)
  {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return visitComponent(visits[index], tileHeight);
        },
        separatorBuilder: (a, b) => const Divider(
            height: 5,
            thickness: 1,
            endIndent: 0,
            color: Color(0xFF2799FA)
        ),
        itemCount: visits.length);
  }


  Widget visitComponent(Visit visit, double tileHeight)
  {
    return GestureDetector(
        onTap: () async{
          await Navigator.pushNamed(context, VisitDetailScreen.route, arguments: visit);
          setState((){});
        },
        child: VisitComponent(tileHeight: tileHeight, visit: visit)
    );
  }



  Widget spacer(int flex) {
    return Flexible(
      flex: flex,
      child: Container(),
    );
  }

  //------------------------------------------------------------------------------

 Future<DataResponse<UserInfo>> getUserInfo() async
 {
   return await cont.getUserInfo();
 }

 Future<DataResponse<List<Article>>> getRecentViewArticles() async
 {
   return await cont.getRecentViewedArticles();
 }

 Future<DataResponse<List<Visit>>> getLikedVisits() async{
    return await cont.getLikedVisits();
 }

}
