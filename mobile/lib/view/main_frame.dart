import 'package:flutter/material.dart';

class MainFrame extends StatelessWidget {

  final Widget mainWidget;
  final Widget iconButtons;

  MainFrame({required this.mainWidget, required this.iconButtons});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double mainWidgetWidth = screenWidth * 0.9;
    final double mainWidgetHeight = screenHeight * 0.95;

    Widget mainWidget = Stack(
      children: [
        backGround(screenHeight, context),
        frontStack(mainWidgetWidth, mainWidgetHeight ,context)

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

  Widget backGround(double screenHeight, context)
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

  Widget frontStack(double widgetWidth, double widgetHeight, BuildContext context)
  {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: widgetWidth,
            height: widgetHeight * 0.92 ,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2
                  )
              ),
              child: Stack(
                  children:[
                    whiteRoundedRectangle(context),
                   mainWidget        //place for main widget

                  ]),
            ),
          ),
          const Divider(
              height: 0,
              thickness: 2,
              endIndent: 0,
              color: Color(0xFF2799FA)
          ),
          SizedBox(
            height: widgetHeight * 0.08,
            width: double.infinity,
            child: Container(
              child: iconButtons            //place for icon buttons
            ),
          )
        ],
      ),
    );
  }

  Widget whiteRoundedRectangle(BuildContext context)
  {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 2
            ),
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
        )
    );
  }



  Widget spacer(int flex)
  {
    return Flexible(
      flex: flex,
      child: Container(),
    );
  }


}