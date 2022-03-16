import 'package:flutter/material.dart';
import 'package:hackerton_project/view/create_new_passwd_verification.dart';
import 'package:hackerton_project/view/find_id_screen.dart';
import 'package:hackerton_project/view/sign_up.dart';

import '../controller/controller.dart';

class LogInScreen extends StatefulWidget
{
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController logInIdController = TextEditingController();
  TextEditingController psController = TextEditingController();
  bool logInFail = false;
  Controller _controller = Controller();
  String logInErrorMsg = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return GestureDetector(
      onTap:(){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body:
          SafeArea(
            left:false,
            right:false,
            child: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.1, right:screenWidth * 0.1,
                  top: screenHeight * 0.05, bottom: screenHeight * 0.05),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                    flex:2,
                    child: Text("동네동기",
                      style: TextStyle(fontWeight: FontWeight.bold,
                          color:Theme.of(context).primaryColor),textScaleFactor: 1.5,)),
                    Flexible(  flex:4,
                        child:Container(

                        )
                    )
                    ,
                    Flexible(
                      flex:2,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "아이디를 입력하세요",
                              hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: logInIdController,
                          validator: (String? value)
                            {
                              if(value == null || value.isEmpty)
                                {
                                  return "아이디를 입력하세요!";
                                }
                            }
                        )
                    ),
                    Flexible(
                        flex:2,
                        child:Container(

                        )
                    ),
                    Flexible(
                        flex:2,
                        child: TextFormField(
                          controller:psController,
                          decoration: InputDecoration(
                              hintText: "비밀번호를 입력하세요",
                              hintStyle: TextStyle(color: Colors.grey)
                          ),
                            obscureText: true,
                          autocorrect: false,
                          validator: (String? value) {
                            if(value == null || value.isEmpty)
                              {
                                return "비밀번호를 입력하세요!";
                              }
                            else if( value.length < 8 || value.length > 20)
                              {
                                return "올바른 비밀번호가 아닙니다!";
                              }
                            else{
                              return null;
                            }
                          },
                        )
                    ),
                    Flexible(
                        flex:2,
                        child: Container(
                          height: double.infinity,
                          child: logInFail? Align(
                            alignment: Alignment.centerLeft,
                            child: Text(logInErrorMsg,
                            style: TextStyle(
                              color: Colors.red
                            ), textScaleFactor: 0.7,),
                          ): Container(),
                        )
                    ),
                    Flexible(
                        flex:1,
                        child: GestureDetector(
                          onTap:() {
                            onTapFindId(context);
                          },
                          child:Text(
                          "아이디를 잊으셨나요?",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                            textScaleFactor: 0.7,
                        )
                        )
                    ),
                    Flexible(
                        flex:1,
                        child:Container(

                        )
                    ),
                    Flexible(
                        flex:1,
                        child: GestureDetector(
                            onTap:() {
                              onTapFindPs(context);
                            },
                            child:Text(
                              "비밀번호를 잊으셨나요?",
                              style: TextStyle(
                                  decoration: TextDecoration.underline
                              ),
                                textScaleFactor: 0.7
                            )
                        )
                    ),
                    Flexible(
                        flex:20,
                        child:Container(

                        )
                    ),
                    Flexible(
                      flex:4,
                      child:SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black)
                                  )
                              ),
                          ),
                          onPressed: (){
                            if(_formKey.currentState!.validate()) {
                              logIn(logInIdController.text.toString(),
                                  psController.text.toString(), context);
                            }
                            },
                          child:Text(
                            "로그인",
                          style: TextStyle(color:Colors.black),
                          )
                        ),
                      ),
                    ),
                    Flexible(
                        flex:2,
                        child:Container(

                        )
                    ),
                    Flexible(
                      flex:4,
                      child:SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black)
                                  )
                              ),
                            ),
                            onPressed: (){
                              onTapSingUp(context);
                            },
                            child:Text(
                              "회원가입",
                              style: TextStyle(color:Colors.black),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          )
      ),
    );
  }

  void onTapFindId(BuildContext context)
  {
    resetAll();
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => FindIdScreen()
        )
    );
  }

  void onTapFindPs(BuildContext context)
  {
    resetAll();
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => CreateNewPsVerificationScreen()
        )
    );
  }

  void onTapSingUp(BuildContext context)
  {
    resetAll();
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => SignUpScreen()
        )
    );
  }

  void logIn(String id, String ps, BuildContext context)
  {
    _controller.logIn(id, ps).then((String? val){
      if(val == null)
        {
          logInErrorMsg = "아이디 또는 비밀번호를 잘못 입력했습니다.";
          logInFail = true;
          setState(() {
          });
        }
      else{
        /*Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => FindIdScreen()
            )
        );*/
        logInErrorMsg = "성공!";
        logInFail = true;
        setState(() {
        });
      }
    }).catchError((String error){
      logInErrorMsg = "로그인시 에러가 발생했습니다. 다시 시도해 주세요.";
      logInFail = true;
      setState(() {
      });
    });
  }

  void resetAll()
  {
    logInFail = false;
    logInErrorMsg = "";
    setState(() {

    });
  }
}
