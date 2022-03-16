import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget
{
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
          CustomScrollView(
            slivers:[
            SliverFillRemaining(
          hasScrollBody: false,
              child: SafeArea(
                left:false,
                right:false,
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
                              Text("회원가입",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    color:Theme.of(context).primaryColor),textScaleFactor: 1.5,),
                            ],
                          ),
                        ),
                        Flexible(  flex:2,
                            child:Container(
                            )
                        ),
                        Flexible(
                          flex:2,
                          child: Container(
                            decoration: BoxDecoration(
                              shape:BoxShape.rectangle,
                              border: Border.all(width: 0.5, color: Colors.black)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: "이름"
                                ),
                              ),
                            ),
                          )
                        ),
                        Flexible(
                          flex:1,
                          child:Container()
                        ),
                        Flexible(
                            flex:2,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape:BoxShape.rectangle,
                                  border: Border.all(width: 0.5, color: Colors.black)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Colors.grey),
                                      hintText: "주민번호 7글자"
                                  ),
                                    keyboardType: TextInputType.number
                                ),
                              ),
                            )
                        ),
                        Flexible(
                            flex:1,
                            child:Container()
                        ),
                        Flexible(
                            flex:2,
                            child: SizedBox(

                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape:BoxShape.rectangle,
                                          border: Border.all(width: 0.5, color: Colors.black)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(color: Colors.grey),
                                              hintText: "사용할 아이디"
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex:1,
                                    child: Container(),
                                  ),
                                  Flexible(
                                    flex:3,
                                    child:Container(
                                      decoration: BoxDecoration(
                                          shape:BoxShape.rectangle,
                                          border: Border.all(width: 0.5, color: Colors.black)
                                      ),
                                      child:TextButton(
                                          onPressed: (){},
                                          child:Text(
                                            "중복확인",
                                            style: TextStyle(color:Colors.grey),
                                          )
                                      ),
                                    )
                                  )
                                ],
                              ),
                            )
                        ),
                        Flexible(
                            flex:1,
                            child:Container()
                        ),
                        Flexible(
                            flex:2,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape:BoxShape.rectangle,
                                  border: Border.all(width: 0.5, color: Colors.black)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Colors.grey),
                                      hintText: "비밀번호"
                                  ),
                                ),
                              ),
                            )
                        ),
                        Flexible(
                            flex:1,
                            child:Container()
                        ),
                        Flexible(
                            flex:2,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape:BoxShape.rectangle,
                                  border: Border.all(width: 0.5, color: Colors.black)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Colors.grey),
                                      hintText: "비밀번호 다시 입력"
                                  ),
                                ),
                              ),
                            )
                        ),
                        Flexible(
                            flex:1,
                            child:Container()
                        ),
                        Flexible(
                            flex:2,
                            child: SizedBox(

                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape:BoxShape.rectangle,
                                          border: Border.all(width: 0.5, color: Colors.black)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(color: Colors.grey),
                                              hintText: "사용할 닉네임"
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex:1,
                                    child: Container(),
                                  ),
                                  Flexible(
                                      flex:3,
                                      child:Container(
                                        decoration: BoxDecoration(
                                            shape:BoxShape.rectangle,
                                            border: Border.all(width: 0.5, color: Colors.black)
                                        ),
                                        child:TextButton(
                                            onPressed: (){},
                                            child:Text(
                                              "중복확인",
                                              style: TextStyle(color:Colors.grey),
                                            )
                                        ),
                                      )
                                  )
                                ],
                              ),
                            )
                        ),
                        Flexible(
                          flex: 1,
                          child:Container()
                        ),
                        Flexible(
                            flex:2,
                            child: SizedBox(

                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape:BoxShape.rectangle,
                                          border: Border.all(width: 0.5, color: Colors.black)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(color: Colors.grey),
                                              hintText: "위치"
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex:1,
                                    child: Container(),
                                  ),
                                  Flexible(
                                      flex:3,
                                      child:Container(
                                        decoration: BoxDecoration(
                                            shape:BoxShape.rectangle,
                                            border: Border.all(width: 0.5, color: Colors.black)
                                        ),
                                        child:TextButton(
                                            onPressed: (){},
                                            child:Text(
                                              "주소찾기",
                                              style: TextStyle(color:Colors.grey),
                                            )
                                        ),
                                      )
                                  )
                                ],
                              ),
                            )
                        ),
                        Flexible(
                          flex:1,
                          child:Container()
                        ),
                        Flexible(
                            flex:2,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape:BoxShape.rectangle,
                                  border: Border.all(width: 0.5, color: Colors.black)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Colors.grey),
                                      hintText: "상세주소"
                                  ),
                                ),
                              ),
                            )
                        ),
                        //---------------------------------------------------
                        Flexible(
                          flex:1,
                          child:Container()
                        ),
                        Flexible(
                            flex:2,
                            child: SizedBox(

                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape:BoxShape.rectangle,
                                          border: Border.all(width: 0.5, color: Colors.black)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(color: Colors.grey),
                                              hintText: "휴대폰 번호"
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex:1,
                                    child: Container(),
                                  ),
                                  Flexible(
                                      flex:3,
                                      child:Container(
                                        decoration: BoxDecoration(
                                            shape:BoxShape.rectangle,
                                            border: Border.all(width: 0.5, color: Colors.black)
                                        ),
                                        child:TextButton(
                                            onPressed: (){},
                                            child:Text(
                                              "인증",
                                              style: TextStyle(color:Colors.grey),
                                            )
                                        ),
                                      )
                                  )
                                ],
                              ),
                            )
                        ),
                        Flexible(
                          flex:1,
                          child:Container()
                        ),
                        Flexible(
                            flex:2,
                            child: SizedBox(

                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape:BoxShape.rectangle,
                                          border: Border.all(width: 0.5, color: Colors.black)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(color: Colors.grey),
                                              hintText: "인증번호"
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex:1,
                                    child: Container(),
                                  ),
                                  Flexible(
                                      flex:3,
                                      child:Container(
                                        decoration: BoxDecoration(
                                            shape:BoxShape.rectangle,
                                            border: Border.all(width: 0.5, color: Colors.black)
                                        ),
                                        child:TextButton(
                                            onPressed: (){},
                                            child:Text(
                                              "확인",
                                              style: TextStyle(color:Colors.grey),
                                            )
                                        ),
                                      )
                                  )
                                ],
                              ),
                            )
                        ),
                        Flexible(
                            flex:1,
                            child:Container()
                        ),
                        Flexible(
                            flex:2,
                            child: SizedBox(

                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape:BoxShape.rectangle,
                                          border: Border.all(width: 0.5, color: Colors.black)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(color: Colors.grey),
                                              hintText: "이메일주소"
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex:1,
                                    child: Container(),
                                  ),
                                  Flexible(
                                      flex:3,
                                      child:Container(
                                        decoration: BoxDecoration(
                                            shape:BoxShape.rectangle,
                                            border: Border.all(width: 0.5, color: Colors.black)
                                        ),
                                        child:TextButton(
                                            onPressed: (){},
                                            child:Text(
                                              "중복확인",
                                              style: TextStyle(color:Colors.grey),
                                            )
                                        ),
                                      )
                                  )
                                ],
                              ),
                            )
                        ),
                        Flexible(
                          flex:2,
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
                                  "가입하기",
                                  style: TextStyle(color:Colors.grey),
                                )
                            ),
                          ),
                        )


                        
                      ],
                    )
                ),
              ),
            ),
              ]
          )
      ),
    );
  }

  void goBackToPrev(BuildContext context)
  {
    Navigator.pop(context);
  }
}
