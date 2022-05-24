import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget
{
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? emailErrorMsg = null;
  String? codeErrorMsg = null;
  String? passwordReErrorMsg = null;
  String? nicknameErrorMsg = null;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordReController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double mainWidgetWidth = screenWidth * 0.85;
    final double mainWidgetHeight = screenHeight * 0.8;


    Widget mainWidget = Stack(
      children: [
        backGround(screenHeight),
        frontWidget(widgetWidth: mainWidgetWidth, widgetHeight: mainWidgetHeight)

      ],
    );

    return safteyBackground( mainWidget, screenHeight, screenWidth);
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
              spacer(2),
              backButton(),
              spacer(1),
              inputForm()
            ],
          ),
        ),
      ),
    );
  }

  Widget inputForm()
  {
    return Flexible(
      flex:20,
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
          Flexible(
            flex: 1,
            child: Text(
              "이름",
           )
          ),
          spacer(1),
          Flexible(
              flex: 1,
              child: inputField(nameController)
          ),
          spacer(1),
          Flexible(
            flex:1,
            child: Text(
              "이메일"
            )
          ),
          rowInputField(emailController, "인증하기"),
          Flexible(
            flex:1,
            child: emailErrorMsg == null? Container(height: double.infinity): Text(emailErrorMsg!, style: TextStyle(color: Colors.red),)
          )

        ],
      ),
    );
  }

  Flexible rowInputField(TextEditingController cont, String buttonString) {
    return Flexible(
          flex:1,
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
                  child: ElevatedButton(
                    child: Text(buttonString, style: TextStyle(color: Colors.white),),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
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
            isDense: true,
            contentPadding: EdgeInsets.all(8),
          fillColor: Colors.white,
          enabledBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 0.5),
          ),
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.5 ),
            )
        )
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
        flex:2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon:Icon(Icons.arrow_back_ios_outlined,
              color: Colors.white),
              onPressed: () {
              },
            ),
            Text("회원가입",
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
}


