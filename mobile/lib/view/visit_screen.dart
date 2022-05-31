import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackerton_project/view/visit_component.dart';

import '../controller/controller.dart';
import '../model/export_file.dart';
import 'export_view.dart';

class VisitScreen extends StatefulWidget
{
  const VisitScreen({Key? key}) : super(key: key);

  static const route = "/visitScreen";

  @override
  State<VisitScreen> createState() => _VisitScreenState();
}

class _VisitScreenState extends State<VisitScreen> {
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return MainFrame(mainWidget: Column(
      children: [
        Flexible(
            flex: 2,
            child: searchBox()),
        Flexible(
            flex: 20,
            child: searching? searchView(screenHeight * 0.2) : recommendView(screenHeight * 0.2)) ,
      ],
    ), iconButtons: RowButton(pressedButton: RowButton.VISIT_BUTTON)
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
                      onPressed: (){
                        if(keywordController.text.length > 0)
                          {
                            searching = true;
                            setState((){});
                          }
                      },
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

  Widget recommendView(double tileHeight)
  {
    return FutureBuilder( future: getRecommendVisits(),
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
          else if(data.errorCode == 1)
          {
            print("error code is 1");

            return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요"));
          }



          return visitView(data.data ?? [], tileHeight);
        }
    );
  }


  Widget searchView(double tileHeight)
  {
    return FutureBuilder( future: getSearchVisits(),
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
          else if(data.errorCode == 1)
          {
            print("error code is 1");

            return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요"));
          }



          return visitView(data.data ?? [], tileHeight);
        }
    );
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
    return VisitComponent(tileHeight: tileHeight, visit: visit);
  }



  Widget spacer(int flex) {
    return Flexible(
      flex: flex,
      child: Container(),
    );
  }

  //------------------------------------------------------------------------------

  Future<DataResponse<List<Visit>>> getRecommendVisits() async
  {
    return await cont.getRecommendVisits();
  }

  Future<DataResponse<List<Visit>>> getSearchVisits() async{

    String keyword = keywordController.text;
    if(keyword.length != 0)
    {
      return await cont.getSearchVisits(keyword: keyword);
    }

    return DataResponse(errorCode: 1);
  }


}
