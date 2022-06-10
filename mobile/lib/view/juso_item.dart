import 'package:flutter/material.dart';

import '../model/export_file.dart';

class JusoItem extends StatelessWidget
{

  final Juso juso;

  JusoItem(this.juso);

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
        Padding(
            padding: EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 1,
                    child: Text("[ " + juso.zipNo + " ]", style: TextStyle(color: Colors.red) )
                ),
                Flexible(
                    flex: 1,
                    child: Container()),
                Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Colors.blue),
                            ),
                            child:Text(
                                "도로명",
                                style: TextStyle(color: Colors.blue)
                            ),
                          ),
                        ),
                        Flexible(
                            flex: 1,
                            child: Container()
                        ),
                        Flexible(
                            flex: 10,
                            child: Text(juso.roadAddrPart1)
                        ),

                      ],
                    )
                ),

                Flexible(
                    flex: 1,
                    child: Container()),

              ],
            )
        )
    );
  }
}