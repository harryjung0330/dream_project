import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget
{
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController psController = TextEditingController();

  String? errorMsg = "hello";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double mainWidgetWidth = screenWidth * 0.8;
    final double mainWidgetHeight = screenHeight * 0.4;

    Widget mainWidget = Stack(
      children: [
        backGround(screenHeight),
        frontStack(mainWidgetWidth, mainWidgetHeight)

      ],
    );

    return safteyBackground( mainWidget, screenHeight, screenWidth);
  }

  Widget frontStack(double widgetWidth, double widgetHeight)
  {
   return Column(
     crossAxisAlignment: CrossAxisAlignment.center,
     mainAxisAlignment: MainAxisAlignment.start,
     children: [
       spacer(8),
       Text(
         "부스터",
         style: TextStyle(
             color: Colors.white,
           fontWeight: FontWeight.bold
         ),
         textScaleFactor: 1.2,
       ),
       spacer(3),
       SizedBox(
         width: widgetWidth,
         height: widgetHeight,
         child: LogInInput(),
       ),
       spacer(5),
       SizedBox(
          width: widgetWidth,
           child: logInButton()
       ),
       spacer(1),
       SizedBox(
         width: widgetWidth,
           child: signUpButton()
       ),
       spacer(5)
     ],
   );
  }

  Widget signUpButton()
  {
    return SizedBox(
      width: double.infinity,
      child: TextButton(

        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith(
                  (state) => Theme.of(context).primaryColor),

          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Theme.of(context).primaryColor),
              )
          ),
        ),
        child: Text(
          "회원가입", style: TextStyle(color: Theme.of(context).primaryColor), textScaleFactor: 1.2,
        ),
        onPressed: (){},
      ),
    );
  }

  Widget logInButton()
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
          "로그인", style: TextStyle(color: Colors.white), textScaleFactor: 1.2,
        ),
        onPressed: (){},
      ),
    );
  }

  Widget LogInInput()
  {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.all(Radius.circular(40))
      ),
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            spacer(2),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "이메일을 입력하세요",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            spacer(1),
            TextField(
              controller: psController,
              decoration: InputDecoration(
                hintText: "비밀번호를 입력하세요",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            Align(
                alignment:Alignment.centerLeft,
              child: errorMsg == null ? Container(): Text(errorMsg!, style: TextStyle(color: Colors.red), textScaleFactor: 0.8,),
            ),
            spacer(2),
            Align(
              alignment:Alignment.centerLeft,
              child: forgetPs()
            )
          ],
        ),
      )
    );
  }

  Widget forgetPs()
  {
    return GestureDetector(
      onTap: _onForgetPs,
      child: Text(
        "비밀번호를 잊으셨나요?",
        textScaleFactor: 0.9,
        style: TextStyle(
          color:Colors.blue,
            decoration: TextDecoration.underline
        ),
      ),
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

  Widget backGround(double screenHeight)
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

  void _onForgetPs()
  {

  }
}
