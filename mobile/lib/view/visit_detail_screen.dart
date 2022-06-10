import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackerton_project/view/visit_component.dart';

import '../controller/controller.dart';
import '../model/export_file.dart';
import 'export_view.dart';

class VisitDetailScreen extends StatefulWidget
{
  const VisitDetailScreen({Key? key}) : super(key: key);

  static const route = "/visitDetailScreen";

  @override
  State<VisitDetailScreen> createState() => _VisitDetailScreenState();
}

class _VisitDetailScreenState extends State<VisitDetailScreen> {
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

    return MainFrame(mainWidget: detailView(), iconButtons: RowButton(pressedButton: RowButton.VISIT_BUTTON)
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

class Heart extends StatefulWidget {
  const Heart({
    Key? key,
    required this.visitDetail,
  }) : super(key: key);

  final VisitDetail visitDetail;

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed:onPressedHeart,
      icon: widget.visitDetail.heart == 0? SvgPicture.asset('assets/logos/unfilled_heart_re.svg'):
      SvgPicture.asset('assets/logos/filled_heart_re.svg'),
    );
  }

  void onPressedHeart() async {
    Controller cont = Controller();
    DataResponse<bool> data =
    widget.visitDetail.heart == 0?
    await cont.likeVisit(title: widget.visitDetail.title, writer: widget.visitDetail.writer):
    await cont.unlikeVisit(title: widget.visitDetail.title, writer: widget.visitDetail.writer);

    if(data.errorCode == -1)
    {
      moveToLogIn();
    }
    if(data.data ?? false)
    {
      widget.visitDetail.heart = widget.visitDetail.heart == 0? 1: 0;
      setState((){});
    }
    else{
      print(data.errorMsg());
      showAlertDialog(context, "하트 누르기 실패", "하트 누르기에 에러가 발생했습니다.");
    }
  }

  void moveToLogIn()
  {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LogInScreen.route, (Route<dynamic> route) => false);
  }

  showAlertDialog(BuildContext context, String title, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("이전으로"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}