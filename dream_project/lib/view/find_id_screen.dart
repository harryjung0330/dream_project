import 'package:flutter/material.dart';
import 'package:hackerton_project/view/show_id.dart';

import '../controller/controller.dart';

class FindIdScreen extends StatefulWidget
{
  const FindIdScreen({Key? key}) : super(key: key);

  @override
  State<FindIdScreen> createState() => _FindIdScreenState();
}

class _FindIdScreenState extends State<FindIdScreen> {
  String? sendCodeErrorMsg = null;
  bool verified = false;
  String sentCodeMsg = "인증번호 발송";
  bool isWrongCode = false;                          //null일시 코드를 확인 안했다는뜻!
  String wrongCodeMsg = "잘못된 코드입니다.";
  String? correctUserName;
  String? correctEmailAddr;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailAddrController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  final _userEmailFormKey = GlobalKey<FormState>();
  final _codeFormKey = GlobalKey<FormState>();

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
            child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.1, right:screenWidth * 0.1,
                    top: screenHeight * 0.05, bottom: screenHeight * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex:2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon:Icon(Icons.arrow_back_ios_outlined),
                            onPressed: () {
                              goBackToPrev(context);
                            },
                          ),
                          Text("아이디 찾기",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color:Theme.of(context).primaryColor),textScaleFactor: 1.5,),
                        ],
                      ),
                    ),
                    Flexible(
                        flex:4,
                        child:Container(

                        )
                    ),
                    Flexible(
                      flex:10,
                      child:Form(
                        key:_userEmailFormKey,
                        child: Column(
                          children: [
                            Flexible(
                                flex:2,
                                child: TextFormField(
                                  validator: (String? value){
                                    if(value == null || value!.isEmpty)
                                      {
                                        return "이름을 입력하세요!";
                                      }
                                  },
                                  decoration: InputDecoration(
                                      hintText: "이름을 입력하세요",
                                      hintStyle: TextStyle(color: Colors.grey)
                                  ),
                                  controller: userNameController,
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
                                    decoration: InputDecoration(
                                        hintText: "이메일주소를 입력하세요",
                                        hintStyle: TextStyle(color: Colors.grey)
                                    ),
                                    controller: emailAddrController,
                                    validator:(String? value)
                                    {
                                      if(value == null || value.isEmpty)
                                      {
                                        return "이메일을 입력하세요.";
                                      }
                                      else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").
                                      hasMatch(value))
                                      {
                                        return "올바른 이메일이 아닙니다.";
                                      }
                                      return null;
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
                              child:SizedBox(
                                height: double.infinity,
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
                                      if (_userEmailFormKey.currentState!.validate()) {
                                      }
                                      },
                                    child:Text(
                                      "인증번호 발송",
                                      style: TextStyle(color:Colors.black),
                                    )
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                    Flexible(
                        flex:2,
                        child:Container(
                        )
                    ),
                    Flexible(
                        flex:2,
                        child:Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: sendCodeErrorMsg == null ? SizedBox.shrink():
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  border: Border.all(color:Colors.black)
                                ),
                                child:Center(child: Text(sendCodeErrorMsg ?? ""))
                              )
                        )
                    ),
                    Flexible(
                      flex:6,
                      child: !(correctEmailAddr == null) ? Container(): Column(

                        crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Text("이메일로 인증번호를 발송했습니다", textScaleFactor: 1.2,),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                border: Border.all(color:Colors.black)
                            ),
                            child: Center(
                              child: Form(
                                key: _codeFormKey,
                                child: TextFormField(
                                    maxLength: 8,
                                    controller:codeController,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(

                                        hintText: "인증번호를 입력하세요",
                                        hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                    ),
                                  validator: (String? value)
                                  {
                                    if(value == null || value.isEmpty)
                                      {
                                        return "인증번호를 입력하세요!";
                                      }
                                    else if( value.length != 8){
                                      return "인증번호는 8자리 입니다.";
                                    }
                                  },
                                ),
                              ),
                            ),
                          )
                        ]
                      )
                    ),
                    Flexible(
                        flex:2,
                        child:Container(
                          height: double.infinity,
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: isWrongCode? Text(
                              wrongCodeMsg,style: TextStyle(color:Colors.red)
                            ) : Container()
                          )
                        )
                    ),
                    Flexible(
                        flex:6,
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
                              if (_codeFormKey.currentState!.validate()) {

                              }
                            },
                            child:Text(
                              "확인",
                              style: TextStyle(color:Colors.black),
                            )
                        ),
                      ),
                    )
                  ],
                )
            ),
          )
      ),
    );
  }

  void goBackToPrev(BuildContext context)
  {
    Navigator.pop(context);
  }

  void resetAll(){
    sendCodeErrorMsg = null;

    verified = false;
    isWrongCode = false;
    correctUserName = null;
    correctEmailAddr = null;
    setState(() {
    });
  }




}
