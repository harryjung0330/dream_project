import 'package:flutter/material.dart';
import 'package:hackerton_project/model/data_response.dart';

import '../controller/controller.dart';
import 'export_view.dart';

class SignUpScreen extends StatefulWidget
{
  const SignUpScreen({Key? key}) : super(key: key);
  static const route = "/signup";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Controller cont = Controller();

  String? emailErrorMsg = null;
  String? codeErrorMsg = null;
  String? passwordReErrorMsg = null;
  String? nicknameErrorMsg = null;
  String? nameErrorMsg = null;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordReController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  bool isEmailVerified = false;
  bool isNicknameChecked = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double mainWidgetWidth = screenWidth * 0.85;
    final double mainWidgetHeight = screenHeight * 0.95;


    Widget mainWidget = Stack(
      children: [
        backGround(screenHeight),
        frontWidget(widgetWidth: mainWidgetWidth, widgetHeight: mainWidgetHeight)

      ],
    );

    return safteyBackground( mainWidget, screenHeight, screenWidth);
  }

  @override
  void dispose()
  {
    print("dispose called!");

    nameController.dispose();
     emailController.dispose();
     codeController.dispose();
    passwordController.dispose();
     passwordReController.dispose();
     nicknameController.dispose();
    super.dispose();
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

  Widget frontWidget({required double widgetWidth,required double widgetHeight})
  {
    return Center(
      child: Container(
        width: widgetWidth,
        height: widgetHeight,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spacer(1),
              backButton(),
              spacer(1),
              inputForm(),
              spacer(1),
              signupButton(onPressedSignUp)
            ],
          ),
        ),
      ),
    );
  }

  Widget signupButton(Function() onPressed) {
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
                  child:Text("????????????", style: TextStyle(color:Colors.white),),
                  onPressed: onPressed,
                ),
              ),
            );
  }

  Widget inputForm()
  {
    return Flexible(
      flex:30,
      child:
        Stack(
          children: [
              whiteRoundedRectangle(),
              inputFields()

          ],
        )
    );
  }

  Widget inputFields()
  {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spacer(1),
          inputFieldName("??????"),
          spacer(1),
          Flexible(
              flex: 3,
              child: inputField(nameController)
          ),
          Flexible(
              flex:1,
              child: nameErrorMsg == null? Container(height: double.infinity): Text(nameErrorMsg!, style: TextStyle(color: Colors.red),textScaleFactor: 0.7,)
          ),
          spacer(1),
          inputFieldName("?????????"),
          spacer(1),
          rowInputField(emailController, "????????????", onPressSendCode),
          Flexible(
            flex:1,
            child: emailErrorMsg == null? Container(height: double.infinity): Text(emailErrorMsg!, style: TextStyle(color: Colors.red),textScaleFactor: 0.7,)
          ),
          spacer(1),
          inputFieldName("????????????"),
          spacer(1),
          rowInputField(codeController, "??????", onPressedVerifyCode),
          Flexible(
              flex:1,
              child: codeErrorMsg == null? Container(height: double.infinity): Text(codeErrorMsg!, style: TextStyle(color: Colors.red),textScaleFactor: 0.7,)
          ),
          spacer(1),
          inputFieldName("????????????"),
          spacer(1),
          Flexible(
           flex:3,
           child: inputField(passwordController)
          ),
          spacer(2),
          inputFieldName("???????????? ?????????"),
          spacer(1),
          Flexible(
            flex:3,
            child:inputField(passwordReController)
          ),
          Flexible(
            flex: 1,
            child:passwordReErrorMsg == null? Container(height: double.infinity): Text(passwordReErrorMsg!, style: TextStyle(color: Colors.red),textScaleFactor: 0.7,)
          ),
          spacer(1),
          inputFieldName("?????????"),
          spacer(1),
          rowInputField(nicknameController, "????????????", onPressCheckDuplicateNickname),
          Flexible(
              flex: 1,
              child:nicknameErrorMsg == null? Container(height: double.infinity): Text(nicknameErrorMsg!, style: TextStyle(color: Colors.red),textScaleFactor: 0.7,)
          )

        ],
      ),
    );
  }

  Flexible inputFieldName(String name) {
    return Flexible(
          flex: 2,
          child: Text(
            name,
         )
        );
  }

  Widget rowInputField(TextEditingController cont, String buttonString, Function() onPressed) {
    return Flexible(
          flex:3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 13,
                child: inputField(cont)
              ),
              spacer(1),
              Flexible(
                  flex:7,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(buttonString, style: TextStyle(color: Colors.white),),
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          ),
                    ),
                  ))
            ],
          )
        );
  }

  Widget inputField(TextEditingController cont) {
    return TextField(
      controller: cont,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(2.0),
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
            Text("????????????",
              style: TextStyle(fontWeight: FontWeight.bold,
                  color:Colors.white),textScaleFactor: 1.5,),
          ],
        ),
      );
  }

  Widget spacer(int flex)
  {
    return Flexible(
      flex: flex,
      child:Container(
        height: double.infinity,
      )
    );
  }


  void resetAllErrorMsgs()
  {
    emailErrorMsg = null;
    codeErrorMsg = null;
    passwordReErrorMsg = null;
    nicknameErrorMsg = null;
    nameErrorMsg = null;
  }

  //--------------------------------- state check --------------------------------
  bool checkName(String name)
  {
    if(name  == "")
      {
        nameErrorMsg = "????????? ??????????????????";
        return false;
      }

    return true;
  }

  bool checkEmail(String email)
  {
    if(email == "") {
      emailErrorMsg = "???????????? ???????????????";
      return false;
    }
    else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email))
    {
      emailErrorMsg = "????????? ???????????? ????????????.";
      return false;
    }

    return true;
  }

  bool checkCode(String code)
  {
    if(code  == "")
      {
        codeErrorMsg = "????????? ??????????????????";
        return false;
      }
    else if(code.length != 4)
    {
        codeErrorMsg = "????????? 4?????? ?????????.";
        return false;
    }

    return true;

  }

  bool checkNickname(String nickname)
  {
    if(nickname == "")
      {
        nicknameErrorMsg = "???????????? ??????????????????.";
        return false;
      }
    return true;
  }

  bool checkPassword(String password, String passwordRe)
  {
    if(password.length < 8)
      {
        passwordReErrorMsg = "??????????????? 8?????? ???????????????.";
        return false;
      }
    else if( password != passwordRe)
      {
        passwordReErrorMsg = "??????????????? ?????? ????????????.";
        return false;
      }

    return true;

  }

  //--------------------------------- button pressed function ---------------------

  void onPressSendCode() async{
    String email = emailController.text;
    if(checkEmail(email))
    {
      bool isSuccess = await sendCode(email);
      if(isSuccess)
        {
          emailErrorMsg = "?????? ???????????? ??????????????? ???????????????.";
        }
      else{
        emailErrorMsg = "????????? ????????? ??????????????????";
      }
    }
    setState(() {

    });

  }

  void onPressedVerifyCode() async{
    String email = emailController.text;
    String code = codeController.text;
    if(checkEmail(email) && checkCode(code))
      {
        DataResponse<bool> res = await verifyCode(email: email, code: code);
        if(res.data??false)
          {
            isEmailVerified = true;
          }
        else{
          isEmailVerified = false;
        }
        codeErrorMsg = res.errorMsg();
      }

    setState(() {
    });
  }

  void onPressCheckDuplicateNickname() async{
    String nickname = nicknameController.text;

    if(checkNickname(nickname))
      {
        DataResponse<bool> res = await checkDuplicateNickname(nickname);
        if(res.data?? false)
          {
            isNicknameChecked = true;
          }
        else{
          isNicknameChecked = false;
        }
        nicknameErrorMsg = res.errorMsg();
      }

    setState(() {

    });
  }

  void onPressedSignUp() async{
    String nickname = nicknameController.text;
    String name = nameController.text;
    String code = codeController.text;
    String password = passwordController.text;
    String passwordRe = passwordReController.text;
    String email = emailController.text;

    bool check = checkNickname(nickname);
    check = checkEmail(email) && check;
    check = checkName(name) && check;
    check = checkPassword(password, passwordRe) &&  check;
    check = checkCode(code) && check;

    if(check)
      {
        if(!isEmailVerified)
          {
            codeErrorMsg = "???????????? ??????????????????";
          }
        else if(!isNicknameChecked)
          {
            nicknameErrorMsg = "????????? ??????????????? ?????????";
          }
        else{
          DataResponse<bool> dataResponse = await signUp(name: name, email: email, code: code, pswd: password, nickname: nickname);
          bool dataRes = dataResponse.data ?? false;
          if(dataRes)
            {
              print("success sign up!");

                Navigator.of(context).pushReplacementNamed(
                  SignUpSuccessScreen.route
                );

            }
          else{
                showAlertDialog(context, "???????????? ??????","??????????????? ?????????????????????. ?????? ????????? ?????????????????? ????????????.");
          }
        }
      }

    setState(() {

    });

  }


  //--------------------------------- network request-------------------------------

  Future<bool> sendCode(String email) async{
      DataResponse<bool> res = await cont.send_code_signup(email: email);

      return res.data ?? false;
  }

  Future<DataResponse<bool>> verifyCode({required String email, required String code}) async
  {
    DataResponse<bool> res = await cont.verify_code_signup(email: email, code:code);

    return res;
  }

  Future<DataResponse<bool>> checkDuplicateNickname(String nickname) async
  {
    DataResponse<bool> res = await cont.check_duplicate_nickname(nickname: nickname);

    return res;
  }

  Future<DataResponse<bool>> signUp({required String name,required String email,
    required String code, required String pswd, required nickname}) async
  {
    DataResponse<bool> ret = await cont.sign_up(name: name, email: email, code: code, pswd: pswd, nickname: nickname);

    return ret;
  }

  //------------------------- alert Dialog
  showAlertDialog(BuildContext context, String title, String msg) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("????????????"),
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


