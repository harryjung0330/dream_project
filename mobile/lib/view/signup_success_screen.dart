import 'package:flutter/material.dart';
import 'package:hackerton_project/view/export_view.dart';

class SignUpSuccessScreen extends StatelessWidget
{
  const SignUpSuccessScreen({Key? key}) : super(key: key);
  static const route = "/signUpSuccessScreen";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double mainWidgetWidth = screenWidth * 0.85;
    final double mainWidgetHeight = screenHeight * 0.95;

    Widget mainWidget = Stack(
      children: [
        backGround(screenHeight, context),
        frontStack(mainWidgetWidth, mainWidgetHeight ,context)

      ],
    );

    return safteyBackground( mainWidget, screenHeight, screenWidth);
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

  Widget backGround(double screenHeight, context)
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

  Widget frontStack(double widgetWidth, double widgetHeight, BuildContext context)
  {
    return Center(
      child: SizedBox(
        width: widgetWidth,
        height: widgetHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
                backButton(context),
                spacer(1),
                Flexible(
                  flex:36,
                  child: Stack(
                      children:[
                        whiteRoundedRectangle(),
                        whiteRoundedRectangleContent()
                  ])
                ),
            spacer(2),
            moveToLoginPageButton( context)

          ],
        ),
      ),
    );
  }

  Widget whiteRoundedRectangleContent()
  {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Text(
          "회원가입이 성공적으로 완료되었습니다!",
          textScaleFactor: 1.5,
        ),
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

  Widget moveToLoginPageButton( BuildContext context) {
    return Flexible(
      flex:3,
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)
                )
            ),
          ),
          child:Text("로그인 페이지로 이동", style: TextStyle(color:Colors.white),),
          onPressed: (){
            Navigator.of(context)
                .pushNamedAndRemoveUntil(LogInScreen.route, (Route<dynamic> route) => false);
          },
        ),
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
          Text("회원가입 완료!",
            style: TextStyle(fontWeight: FontWeight.bold,
                color:Colors.white),textScaleFactor: 1.5,),
        ],
      ),
    );
  }
}


