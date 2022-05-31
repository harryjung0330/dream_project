import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../controller/controller.dart';
import '../model/export_file.dart';
import 'export_view.dart';

class VisitComponent extends StatefulWidget
{
  final double tileHeight;
  final Visit visit;
  const VisitComponent({required this.tileHeight, required this.visit});

  @override
  State<VisitComponent> createState() => _VisitComponentState();
}

class _VisitComponentState extends State<VisitComponent> {
  late double tileHeight;
  late Visit visit;
  late Controller cont;

  @override
  void initState()
  {
    super.initState();
    cont = Controller();
  }
  @override
  Widget build(BuildContext context) {
    tileHeight = widget.tileHeight;
    visit = widget.visit;

    return GestureDetector(
      onTap:(){
        //Navigator.pushNamed(context, ArticleDetailScreen.route, arguments: article);
      },
      child: Container(
          child: SizedBox(
            height: tileHeight,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      flex:3,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(onPressed: onPressedHeart,
                          icon: visit.heart == 0? SvgPicture.asset('assets/logos/unfilled_heart_re.svg'):
                          SvgPicture.asset('assets/logos/filled_heart_re.svg'),
                        ),
                      )
                  ),
                  Flexible(
                      flex:3,
                      child: Row(
                        children: [
                          spacer(1),
                          Flexible(
                              flex:28,
                              child: Text(visit.title, textScaleFactor: 2,)),
                        ],
                      )
                  ),
                  spacer(2),
                  Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                              flex: 6,
                              child: Container(
                                  width: double.infinity,
                                  child: Text(visit.address))
                          ),
                          spacer(1),
                          Flexible(
                              flex: 6,
                              child: Container(
                                  width: double.infinity,
                                  child: Text(visit.tagsToString(), style: TextStyle(color: Colors.blue),textScaleFactor: 1.2,))
                          )

                        ],
                      )
                  ),
                ],
              ),
            ),
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

  void onPressedHeart() async {

    DataResponse<bool> data =
    visit.heart == 0?
      await cont.likeVisit(title: visit.title, writer: visit.writer):
      await cont.unlikeVisit(title: visit.title, writer: visit.writer);

    if(data.errorCode == -1)
    {
      moveToLogIn();
    }
    if(data.data ?? false)
    {
      visit.heart = visit.heart == 0? 1: 0;
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
