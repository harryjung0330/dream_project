import 'package:flutter/material.dart';

import '../model/export_file.dart';
import 'export_view.dart';

typedef void OnTapFunc(Juso jsuo, BuildContext outSideContext);

class JusoListItem extends StatelessWidget
{
  final numbToDisplay;
  final BuildContext outsideContext;
  final JusoList jusoList;
  OnTapFunc onTapFunc = (juso, outSideContext) => Navigator.pop(outSideContext, juso);

  JusoListItem({required this.outsideContext, required this.jusoList, required this.numbToDisplay, OnTapFunc? onTapFunc}){
    if(onTapFunc != null)
    {
      this.onTapFunc = onTapFunc;
    }
  }


  @override
  Widget build(BuildContext context) {
    return generateColumnBasedonList();
  }

  Widget generateColumnBasedonList()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: jusoItems(outsideContext),
    );
  }

  List<Widget> jusoItems(BuildContext context)
  {
    List<Juso> jusList = jusoList.jusoList;

    List<Widget> widgetList = [];

    int numForJusoItem = numbToDisplay;

    if(jusList.length < numbToDisplay)
    {
      numForJusoItem = jusList.length;
    }

    for(int index = 0; index < numForJusoItem; index++)
    {

      widgetList.add(Flexible(
        flex: 1,
        child: GestureDetector(
            onTap:(){
              onTapFunc(jusList[index], context);
            },
            child: Column(
              children: [
                Flexible(
                    flex: 1,
                    child: Container(
                        width: double.maxFinite,
                        child: JusoItem(jusList[index])
                    )),
                Divider(
                  thickness: 4,
                  color: Colors.grey,
                )
              ],
            )),
      ));
    }

    int numbForBlankItem = numbToDisplay - numForJusoItem;

    print(numbForBlankItem);

    for(int index = 0; index < numbForBlankItem; index++)
    {
      widgetList.add(
          Flexible(
              flex:1,
              child: Column(
                children: [
                  Flexible(
                    flex:1,
                    child: Container(
                      height: double.maxFinite,
                    ),
                  ),

                ],
              )
          )
      );
    }

    return widgetList;
  }
}