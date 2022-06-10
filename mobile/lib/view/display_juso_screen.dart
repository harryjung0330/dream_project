import 'package:flutter/material.dart';

import '../controller/controller.dart';
import '../model/export_file.dart';
import 'export_view.dart';

class DisplayJusoScreen extends StatefulWidget
{
  const DisplayJusoScreen({Key? key}) : super(key: key);
  static const route = "/displayJusoScreen";

  @override
  State<DisplayJusoScreen> createState() => _DisplayJusoScreenState();
}

class _DisplayJusoScreenState extends State<DisplayJusoScreen> {

  int itemNumb = 5;

  String currentSearchKeyword = "";
  int currentPage = 1;
  int maxPage = 1;

  JusoList jusoList = JusoList();

  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    if(screenHeight < 1040)
    {
      itemNumb = 4;
    }

    return GestureDetector(
        onTap:() {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            body:
            SingleChildScrollView(
                child:SizedBox(
                    height: screenHeight,
                    width: screenWidth,

                    child:SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.1, right:screenWidth * 0.1,
                            top: screenHeight * 0.05, bottom: screenHeight * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon:Icon(Icons.arrow_back_ios_outlined),
                                    onPressed: () {
                                      goBackToPrev(context);
                                    },
                                  ),
                                  Text("주소 찾기",
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                        color:Theme.of(context).primaryColor),textScaleFactor: 1.5,),
                                ],
                              ),
                            ),

                            Flexible(
                                flex: 1,
                                child: Container()
                            ),

                            Flexible(
                                flex: 3,
                                child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border:Border.all(color:Colors.black)
                                    ),
                                    child:Row(
                                      children: [
                                        Flexible(
                                            flex:9,
                                            child: Center(
                                              child: TextField(
                                                controller: addressController,
                                                decoration: InputDecoration(
                                                    hintText: "주소 검색",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey
                                                    )
                                                ),
                                              ),
                                            )
                                        ),
                                        Flexible(
                                            flex : 1,
                                            child: Center(
                                              child: IconButton(
                                                icon: Icon(Icons.search, color: Colors.black),
                                                onPressed: (){
                                                  newSearch(context, addressController.text, itemNumb);
                                                },
                                              ),
                                            ) )
                                      ],
                                    )
                                )
                            ),

                            Flexible(
                                flex:2,
                                child:Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "아래 주소를 클릭해주세요.",
                                    textScaleFactor: 0.8,
                                    style: TextStyle(
                                        color: Colors.grey
                                    ),
                                  ),
                                )
                            ),

                            Flexible(
                              flex: 24,
                              child: Container(
                                child: JusoListItem(
                                  outsideContext: context,
                                  jusoList: jusoList,
                                  onTapFunc: null,
                                  numbToDisplay: itemNumb,),
                                decoration: BoxDecoration(
                                    border: Border.all(color:Colors.black),
                                    shape: BoxShape.rectangle
                                ),
                              ),
                            ),

                            Flexible(
                                flex:2,
                                child:Container()
                            ),

                            Flexible(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: (){
                                        prevPage(context, addressController.text, itemNumb);
                                      },
                                      icon: const Icon(Icons.arrow_left_outlined),
                                    ),
                                    Text("$currentPage/$maxPage"),
                                    IconButton(
                                      onPressed: (){
                                        nextPage(context, addressController.text, itemNumb);
                                      },
                                      icon: const Icon(Icons.arrow_right_outlined),
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                    )
                )
            )
        )
    );

  }

  void goBackToPrev(BuildContext context)
  {
    Navigator.pop(context);
  }

  void nextPage(BuildContext context, String addressKeyword, int countPerpage ) async
  {
    if(currentPage == maxPage)
    {
      return;
    }
    currentPage++;
    jusoList = await getAddress(context, addressKeyword, currentPage, countPerpage);
    setState((){});
  }

  void prevPage(BuildContext context, String addressKeyword, int countPerpage ) async
  {
    if(currentPage < 2)
    {
      return;
    }

    currentPage--;
    jusoList = await getAddress(context, addressKeyword, currentPage, countPerpage);
    setState((){});
  }

  void newSearch(BuildContext context, String addressKeyword, int countPerPage) async
  {
    jusoList = await getAddress(context, addressKeyword, currentPage, countPerPage);
    currentPage = 1;
    maxPage = (jusoList.totalCount / itemNumb).ceil();

    setState(() {

    });
  }

  Future<JusoList> getAddress(BuildContext context, String addressKeyword, int currentPage, int countPerPage) async
  {
    Controller controller = Controller();
    DataResponse<JusoList> dataResponse = await controller.getAddr(currentPage: currentPage,
        countPerPage: countPerPage, keyword: addressKeyword);

    if(dataResponse.isError())
    {
      showAlertDialog(context, "오류 발생", dataResponse.errorMsg());
      return JusoList();
    }
    else{
      return dataResponse.data ?? JusoList();
    }
  }

  showAlertDialog(BuildContext context, String title, String msg) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("이전으로"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
