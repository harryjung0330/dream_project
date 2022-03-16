import 'package:flutter/material.dart';

class CreateNewPsCreateScreen extends StatefulWidget
{
  const CreateNewPsCreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPsCreateScreen> createState() => _CreateNewPsCreateScreenState();
}

class _CreateNewPsCreateScreenState extends State<CreateNewPsCreateScreen> {
  bool notMatched = true;
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
                      child:TextField(
                        decoration: InputDecoration(
                          hintText: "새로운 비밀번호를 입력하세요",
                          hintStyle: TextStyle(color: Colors.grey)
                        )
                      )
                    ),
                    Flexible(
                      flex:2,
                      child:Container()
                    ),
                    Flexible(
                      flex:2,
                      child:TextField(
                        decoration:InputDecoration(
                            hintText: "새 비밀번호를 다시 입력하세요",
                            hintStyle: TextStyle(color: Colors.grey)
                        )
                      )
                    ),
                    Flexible(
                      flex:4,
                      child:Container()
                    ),
                    Flexible(
                      flex:2,
                      child: !notMatched? SizedBox.shrink():
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border:Border.all(width: 1, color: Colors.black)
                        ),
                          child: Center(
                              child: Text("비밀번호가 일치하지 않습니다."))
                      )
                    ),
                    Flexible(
                      flex:14,
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
}
