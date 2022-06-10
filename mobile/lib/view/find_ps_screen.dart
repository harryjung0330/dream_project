import 'package:flutter/material.dart';
import 'package:hackerton_project/model/data_response.dart';
import 'package:hackerton_project/view/create_new_ps_screen.dart';

import '../controller/controller.dart';
import 'export_view.dart';

class FindPsScreen extends StatefulWidget
{
  const FindPsScreen({Key? key}) : super(key: key);
  static const String route = "/findPsScreen";

  @override
  State<FindPsScreen> createState() => _FindPsScreenState();
}

class _FindPsScreenState extends State<FindPsScreen> {

  String? nameErrorMsg = null;
  String? emailErrorMsg = null;
  String? codeErrorMsg = null;
  bool didSend = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  bool isSendingCode = false;
  bool isVerifyingCode = false;


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double mainWidgetWidth = screenWidth * 0.85;
    final double mainWidgetHeight = screenHeight * 0.9;

    Widget mainWidget = Stack(
      children: [
        backGround(screenHeight),
        frontStack(mainWidgetWidth, mainWidgetHeight)

      ],
    );

    return safteyBackground( mainWidget, screenHeight, screenWidth);
  }

  @override
  void dispose()
  {
    print("dispose called!");



    super.dispose();
  }

  Widget frontStack(double widgetWidth, double widgetHeight)
  {
    return Center(
      child: SizedBox(
        height: widgetHeight,
        width:  widgetWidth,
        child: Column(
          children: [
            backButton(),
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
                         spacer(1),
                         Flexible( flex: 8, child: infoInput()),
                         spacer(1),
                         Flexible(flex: 3, child: isSendingCode? CircularProgressIndicator(): sendCodeButton()),
                         spacer(1),
                         Flexible(flex:3, child: didSend? inputField(codeController): Container(height: double.infinity,)),
                         Flexible(
                           flex:1,
                           child: Align(
                             alignment:Alignment.centerLeft,
                             child: codeErrorMsg == null ? Container(height: double.infinity,): Text(codeErrorMsg!, style: TextStyle(color: Colors.red), textScaleFactor: 0.8,),
                           ),
                         ),
                         spacer(8),
                         Flexible(flex:3, child: isVerifyingCode? CircularProgressIndicator(): moveToNextButton(),)

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

  Widget backButton() {
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
          Text("비밀번호 새로 생성",
            style: TextStyle(fontWeight: FontWeight.bold,
                color:Colors.white),textScaleFactor: 1.5,),
        ],
      ),
    );
  }

  Widget sendCodeButton()
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
          "인증번호 발송", style: TextStyle(color: Theme.of(context).primaryColor), textScaleFactor: 1.2,
        ),
        onPressed: (){
            _onSendCode();
        },
      ),
    );
  }

  Widget moveToNextButton()
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
          "확인", style: TextStyle(color: Colors.white), textScaleFactor: 1.2,
        ),
        onPressed: (){
          _onVerifyCode();
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

  Widget infoInput()
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
              spacer(1),
              Flexible(
                flex:2,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "이름을 입력하세요",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Flexible(
                flex:1,
                child: Align(
                  alignment:Alignment.centerLeft,
                  child: nameErrorMsg == null ? Container(): Text(nameErrorMsg!, style: TextStyle(color: Colors.red), textScaleFactor: 0.8,),
                ),
              ),
              spacer(1),
              Flexible(
                flex:2,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "이메일 주소를 입력하세요.",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Flexible(
                flex:1,
                child: Align(
                  alignment:Alignment.centerLeft,
                  child: emailErrorMsg == null ? Container(): Text(emailErrorMsg!, style: TextStyle(color: Colors.red), textScaleFactor: 0.8,),
                ),
              ),
              spacer(1),
            ],
          ),
        )
    );
  }

  Widget inputField(TextEditingController cont) {
    return TextField(
      controller: cont,
      decoration: InputDecoration(
          hintText: "인증번호를 입력해주세요.",
          contentPadding: EdgeInsets.all(10.0),
          fillColor: Colors.white,
          enabledBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 0.5),
          ),
          focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 0.5 ),
          )
      ),
      style: TextStyle(
          color: Colors.black
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



  void _onSendCode() async
  {
    String email = emailController.text;
    String name = nameController.text;
    Controller cont = Controller();

    refreshState();

    if(email == "")
    {
      emailErrorMsg = "이메일을 입력하세요";
    }
    else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {

      emailErrorMsg = "올바른 이메일이 아닙니다.";
    }

    if(name == "")
    {

      nameErrorMsg ="이름을 입력하세요.";

    }

    didSend = false;
    codeController.text = "";


    if(emailErrorMsg == null && nameErrorMsg == null)
    {
        isSendingCode = true;
        setState((){});

        DataResponse<bool> response = await cont.send_code_findps(email: email);
        isSendingCode = false;

        if(response.data ?? false)
        {
            didSend = true;
        }
        else
        {
            emailErrorMsg = response.errorMsg();
        }
    }


    setState((){

    });



  }

  void _onVerifyCode() async
  {
    String email = emailController.text;
    String name = nameController.text;
    String code = codeController.text;

    Controller cont = Controller();

    refreshState();

    if(!didSend)
    {
      emailErrorMsg = "코드를 먼저 전송해 주세요.";
    }
    else if(code == "" || code.length != 4)
    {
      codeErrorMsg = "코드는 4자리 숫자입니다.";
    }

    if(email == "")
    {
      emailErrorMsg = "이메일을 입력하세요";
    }
    else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {

      emailErrorMsg = "올바른 이메일이 아닙니다.";
    }

    if(name == "")
    {

      nameErrorMsg ="이름을 입력하세요.";

    }

    if(emailErrorMsg == null && nameErrorMsg == null && codeErrorMsg == null)
    {
      isVerifyingCode = true;
      setState((){});

      DataResponse<bool> response = await cont.verify_code_findps(email: email, code: code);
      isVerifyingCode = false;

      if(response.data ?? false)
      {
        Map<String, String> info = {
          CreateNewPsScreen.EMAIL: email,
          CreateNewPsScreen.CODE : code
        };

        Navigator.pushReplacementNamed(context, CreateNewPsScreen.route, arguments: info);
      }
      else
      {
        codeErrorMsg = response.errorMsg();
      }
    }


    setState((){

    });



  }

  void refreshState()
  {
    emailErrorMsg = null;
    nameErrorMsg =null;
    codeErrorMsg = null;
  }


}
