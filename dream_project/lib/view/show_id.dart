import 'package:flutter/material.dart';

class ShowIdScreen extends StatefulWidget
{
  late final String logInId;
  late final String userName;

  ShowIdScreen(String logInId, String userName)
  {
    this.logInId = logInId;
    this.userName = userName;
  }

  @override
  State<ShowIdScreen> createState() => _ShowIdScreenState();
}

class _ShowIdScreenState extends State<ShowIdScreen> {
  late final String userName = widget.userName;
  late final String userId = widget.logInId;

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
                          Text("아이디 찾기",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color:Theme.of(context).primaryColor),textScaleFactor: 1.2,),
                        ],
                      ),
                    ),
                    Flexible(
                      flex:2,
                      child:Container(
                      )
                    ),
                    Flexible(
                      flex:2,
                      child:Text("$userName" + "님의 아이디는", textScaleFactor: 1.2,)
                    ),
                    Flexible(
                      flex:1,
                      child:Container()
                    ),
                    Flexible(
                      flex:2,
                      child:Container(
                        decoration:BoxDecoration(
                          shape: BoxShape.rectangle,
                          border:Border.all(width: 1, color: Colors.black)
                        ),
                        child:Center(
                          child: Text(
                            userId
                          ),
                        )
                      )
                    ),
                    Flexible(
                      flex:22,
                      child:Container()
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
