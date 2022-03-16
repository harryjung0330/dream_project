import 'package:flutter/material.dart';

class CreateNewPsVerificationScreen extends StatefulWidget
{
  const CreateNewPsVerificationScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPsVerificationScreen> createState() => _CreateNewPsVerificationScreenState();
}

class _CreateNewPsVerificationScreenState extends State<CreateNewPsVerificationScreen>
{
  final String? errorMsg = "일치하는 아이디가 없습니다.";
  bool sentCode = false;

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
                          Text("비밀번호 새로생성",
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
                        flex:2,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "아이디를 입력하세요",
                              hintStyle: TextStyle(color: Colors.grey)
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
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "이메일주소를 입력하세요",
                              hintStyle: TextStyle(color: Colors.grey)
                          ),
                        )
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
                            onPressed: (){},
                            child:Text(
                              "인증번호 발송",
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
                        flex:2,
                        child:Container(
                            width: double.infinity,
                            child: errorMsg == null ? SizedBox.shrink():
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color:Colors.black)
                                ),
                                child:Center(child: Text(errorMsg ?? ""))
                            )
                        )
                    ),
                    Flexible(
                        flex:6,
                        child: !sentCode? SizedBox.shrink(): Column(

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
                                  child: TextField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: "인증번호를 입력하세요",
                                          hintStyle: TextStyle(color: Colors.grey),
                                          border: InputBorder.none
                                      )
                                  ),
                                ),
                              )
                            ]
                        )
                    ),
                    Flexible(
                        flex:8,
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
                            onPressed: (){},
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
}
