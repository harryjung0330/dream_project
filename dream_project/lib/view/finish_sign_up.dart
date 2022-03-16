import 'package:flutter/material.dart';

class FinishSignUpScreen extends StatefulWidget
{
  const FinishSignUpScreen({Key? key}) : super(key: key);

  @override
  State<FinishSignUpScreen> createState() => _FinishSignUpScreenState();
}

class _FinishSignUpScreenState extends State<FinishSignUpScreen> {

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
                            },
                          ),
                          Text("회원가입 완료!",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color:Theme.of(context).primaryColor),textScaleFactor: 1.5,),
                        ],
                      ),
                    ),
                    Flexible(
                        flex:4,
                        child:Container()
                    ),
                    Flexible(
                        flex:4,
                        child:Text("회원가입이 성공적으로 완료되었습니다!", textScaleFactor: 1.7,)
                    ),
                    Flexible(
                        flex: 20,
                        child: Container()
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
                              "로그인 페이지로 이동",
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
}
