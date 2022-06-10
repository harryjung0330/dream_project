import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controller/controller.dart';
import '../model/export_file.dart';
import 'export_view.dart';

class VisitLikeDetailScreen extends StatefulWidget
{
  const VisitLikeDetailScreen({Key? key}) : super(key: key);

  static const route = "/visitLikeDetailScreen";

  @override
  State<VisitLikeDetailScreen> createState() => _VisitLikeDetailScreenState();
}

class _VisitLikeDetailScreenState extends State<VisitLikeDetailScreen> {
  Controller cont = Controller();
  late Visit visit;
  late VisitDetail visitDetail;
  bool searching = false;


  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    visit = ModalRoute.of(context)!.settings.arguments as Visit;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return MainFrame(mainWidget: detailView(), iconButtons: RowButton(pressedButton: RowButton.MY_INFO_BUTTON)
    );
  }

  @override
  void dispose()
  {
    super.dispose();

  }






  Widget detailView()
  {
    return FutureBuilder( future: getVisitDetail(),
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
          DataResponse<VisitDetail>? data = snapShot.hasData ? snapShot.data: null;
          if(data == null)
          {
            return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요"));
          }
          else if(data.errorCode == -1)
          {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(LogInScreen.route, (Route<dynamic> route) => false);
          }
          else if(data.errorCode == 1)
          {
            print("error code is 1");

            return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요"));
          }

          visitDetail = data.data!;



          return visitDetailView(data.data!);
        }
    );
  }

  Widget visitDetailView(VisitDetail visitDetail)
  {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: IconButton(
                      icon:Icon(Icons.arrow_back_ios_outlined,
                          color: Theme.of(context).primaryColor),
                      onPressed: () {
                        print("back button is pressed!");
                        Navigator.of(context).pop(null);
                      },
                    ),
                  ),
                  spacer(2),
                  Flexible( flex: 5, child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.bottomLeft, child: Text(visitDetail.nickname, textScaleFactor: 0.7,)),
                  )),
                  spacer(6),
                  Flexible(flex: 6, child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Align(alignment: Alignment.bottomLeft, child: Text("조회수 ${visitDetail.readView}", textScaleFactor: 0.7,)),
                  )),
                  Flexible(flex: 7, child: Heart(visitDetail: visitDetail))
                ],
              )),
          spacer(3),
          Flexible(
              flex: 3,
              child: Text(visitDetail.title, textScaleFactor: 2,)
          ),
          spacer(3),
          Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child: Text(visitDetail.address)),
                  spacer(1),
                  Flexible(child: Text(visitDetail.tagsToString(), style:  TextStyle(color:  Colors.blue), textScaleFactor: 1.2,))
                ],
              )),
          spacer(3),
          Flexible(
            flex: 27,
            child: SingleChildScrollView(
                child: VisitContent(content: visitDetail.content,)
            ),

          )
        ],

      ),
    );

  }







  Widget spacer(int flex) {
    return Flexible(
      flex: flex,
      child: Container(),
    );
  }

  //------------------------------------------------------------------------------

  Future<DataResponse<VisitDetail>> getVisitDetail() async
  {
    return await cont.getDetailVisit(writer: visit.writer, title: visit.title);
  }


}

