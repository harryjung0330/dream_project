import 'package:flutter/material.dart';
import 'package:hackerton_project/view/export_view.dart';

import '../controller/controller.dart';
import '../model/export_file.dart';

class CreateNewPsScreen extends StatefulWidget
{
  const CreateNewPsScreen({Key? key}) : super(key: key);
  static const route = "/createNewPsScreen";
  static const EMAIL = "email";
  static const CODE = "code";

  @override
  State<CreateNewPsScreen> createState() => _CreateNewPsScreenState();
}

class _CreateNewPsScreenState extends State<CreateNewPsScreen> {
  String? passwordErrorMsg = null;
  String? passwordReErrorMsg = null;

  late String email;
  late String code;

  bool isCreatingPs = false;

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordReControoler = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    Map<String, String> info  = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    code = info[CreateNewPsScreen.CODE] ?? "";
    email = info[CreateNewPsScreen.EMAIL] ?? "";

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
                            Flexible(flex: 8, child: infoInput()),
                            spacer(10),
                            Flexible(flex: 2, child: createPsButton()),
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


  Widget createPsButton()
  {
    return SizedBox(
      width: double.infinity,
      child: isCreatingPs? Center(child: CircularProgressIndicator()): TextButton(

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
            _onCreateNewPs();
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
              spacer(2),
              Flexible(
                flex:2,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "새로운 비밀번호를 입력하세요.",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Flexible(
                flex:1,
                child: Align(
                  alignment:Alignment.centerLeft,
                  child: passwordErrorMsg == null ? Container(): Text(passwordErrorMsg!, style: TextStyle(color: Colors.red), textScaleFactor: 0.8,),
                ),
              ),
              spacer(2),
              Flexible(
                flex:2,
                child: TextField(
                  controller: passwordReControoler,
                  decoration: InputDecoration(
                    hintText: "새 비밀번호를 다시 입력하세요.",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Flexible(
                flex:1,
                child: Align(
                  alignment:Alignment.centerLeft,
                  child: passwordReErrorMsg == null ? Container(): Text(passwordReErrorMsg!, style: TextStyle(color: Colors.red), textScaleFactor: 0.8,),
                ),
              ),
              spacer(1),
            ],
          ),
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



  void _onCreateNewPs() async
  {
    String ps = passwordController.text;
    String psRe = passwordReControoler.text;
    Controller cont = Controller();

    refreshState();

    if(ps == "")
    {
      passwordErrorMsg = "비밀번호를 입력해주세요.";
    }
    else if(ps.length < 8 || ps.length > 13) {

      passwordErrorMsg = "비밀번호는 8자리 이상 13자리 이하여야 합니다.";
    }
    else if(ps != psRe) {
      passwordReErrorMsg = "비밀번호를 다시 확인해주세요.";
    }

    if(passwordErrorMsg == null && passwordReErrorMsg == null)
    {
        isCreatingPs = true;
        setState((){});

        DataResponse<bool> response = await cont.create_new_ps(email: email, code: code, password: ps);

        isCreatingPs = false;
        if(response.data ?? false)
          {
            Navigator.of(context).pushReplacementNamed(SuccessCreatePsScreen.route);
          }
        else{
          showAlertDialog(context,"비번 생성 실패", response.errorMsg() );
        }
    }



    setState((){

    });



  }



  void refreshState()
  {
    passwordReErrorMsg = null;
    passwordErrorMsg =null;
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
