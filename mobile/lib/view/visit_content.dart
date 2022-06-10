import 'package:flutter/material.dart';

import '../model/export_file.dart';

class VisitContent extends StatelessWidget
{
  final Content content;
  const VisitContent({Key? key, required Content this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: convertContents(spacerHeight: screenHeight * 0.1),
    );
  }

  List<Widget> convertContents({required double spacerHeight})
  {
    List<Widget> widgets = [];

    for(ContentComponent component in content.getContents())
    {
      if(component.isText())
      {
          widgets.add(Text((component as TextContent).getText(), textScaleFactor: 1.5,));
      }
      else if(component.isImage())
        {
          widgets.add(Image.network(((component as ImageContent).getPath())));
        }
      else{
        widgets.add(SizedBox(height: spacerHeight,));
      }
    }

    return widgets;
  }


}
