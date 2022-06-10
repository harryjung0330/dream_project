import 'package:flutter/material.dart';

import 'export_view.dart';

class SuccessCreatePsScreen extends StatelessWidget
{
  const SuccessCreatePsScreen({Key? key}) : super(key: key);
  static const route = "/successCreatePsScreen";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;


    final double mainWidgetWidth = screenWidth * 0.85;
    final double mainWidgetHeight = screenHeight * 0.9;

    Widget mainWidget = Stack(
      children: [
        backGround(screenHeight, context),
        frontStack(mainWidgetWidth, mainWidgetHeight, context)

      ],
    );

    return safteyBackground( mainWidget, screenHeight, screenWidth);
  }



  Widget frontStack(double widgetWidth, double widgetHeight, BuildContext context)
  {
    return Center(
      child: SizedBox(
        height: widgetHeight,
        width:  widgetWidth,
        child: Column(
          children: [
            backButton(context),
            spacer(1),
            Flexible(
              flex:30,
              child: Stack(
                children: [
                  whiteRoundedRectangle(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        spacer(10),
                        Flexible(flex: 4, child: Center(child: Text("비밀번호를 변경하였습니다!", textScaleFactor: 1.7,))),
                        spacer(10),
                        Flexible(flex: 4, child:moveToLogInButton(context)),
                        spacer(1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget backButton(BuildContext context) {
    return Flexible(
      flex:3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon:Icon(Icons.arrow_back_ios_outlined,
                color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Text("비밀번호 생성 완료",
            style: TextStyle(fontWeight: FontWeight.bold,
                color:Colors.white),textScaleFactor: 1.5,),
        ],
      ),
    );
  }


  Widget moveToLogInButton(BuildContext context)
  {
    return SizedBox(
      width: double.infinity,
      child: TextButton(

        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
                  (state) => Theme.of(context).primaryColor),

          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Theme.of(context).primaryColor),
              )
          ),
        ),
        child: Text(
          "로그인 페이지로 이동", style: TextStyle(color: Colors.white), textScaleFactor: 1.2,
        ),
        onPressed: (){
          Navigator.of(context)
              .pushNamedAndRemoveUntil(LogInScreen.route, (Route<dynamic> route) => false);
        },
      ),
    );
  }

  Widget whiteRoundedRectangle()
  {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
        )
    );
  }



  Widget safteyBackground(Widget mainWidget, double screenHeight, double screenWidth)
  {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          body: SingleChildScrollView(
              child:SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: mainWidget
              )
          )
      ),
    );
  }


  Widget spacer(int flex)
  {
    return Flexible(
      flex: flex,
      child: Container(),
    );
  }

  Widget backGround(double screenHeight, BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: double.infinity,
            height: screenHeight / 2,
            child: Container(
                color:Theme.of(context).primaryColor
            )
        ),
        SizedBox(
            width: double.infinity,
            height: screenHeight / 2,
            child: Container(
                color:Colors.white
            )
        )
      ],
    );
  }

  //-------------------------------------------------------------------------------










}
