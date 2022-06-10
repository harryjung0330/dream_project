import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/controller.dart';
import '../model/export_file.dart';
import 'export_view.dart';

class VisitNewScreen extends StatefulWidget
{
  const VisitNewScreen({Key? key}) : super(key: key);
  static const route = "/visitNewScreen";

  @override
  State<VisitNewScreen> createState() => _VisitNewScreenState();
}

class _VisitNewScreenState extends State<VisitNewScreen> {

  Controller cont = Controller();
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController detailAddressController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  Content content = Content();
  final ScrollController _scrollController = ScrollController();
  bool isWaiting = false;

  List<Widget> contents = [];

  late double screenHeight;
  late double screenWidth;
  bool searching = false;


  @override
  void initState(){
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                    flex:36,
                    child: Stack(
                        children:[
                          whiteRoundedRectangle(),
                         addView()   //place for main widget

                        ])
                ),
              ],
            ),
          ),
          const Divider(
              height: 5,
              thickness: 2,
              endIndent: 0,
              color: Color(0xFF2799FA)
          ),
          SizedBox(
            height: widgetHeight * 0.08,
            width: double.infinity,
            child: Container(
               child: buildButtons()   //place for icon buttons
            ),
          )
        ],
      ),
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



  @override
  void dispose()
  {
    super.dispose();
    titleController.dispose();
    addressController.dispose();
    detailAddressController.dispose();
    tagsController.dispose();
  }

  Widget addView()
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon:Icon(Icons.arrow_back_ios_outlined,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    print("back button is pressed!");
                    Navigator.of(context).pop(null);
                  },
                ),
                Expanded(child: Container()),
                SizedBox(
                  height: double.infinity,
                  child: IconButton(
                    icon:isWaiting ? CircularProgressIndicator(): SvgPicture.asset('assets/logos/create.svg'),
                    onPressed: isWaiting? (){} : () async {
                      if(titleController.text == "" || tagsController.text == ""
                          ||tagsController.text == "#" || addressController.text == ""
                          || detailAddressController.text == "" || content.getContents().length == 0)
                        {
                          showAlertDialog(context, "필수정보를 입력해주세요", "필수정보를 다 입력하지 않았습니다.");
                          return;
                        }
                      setState((){
                        isWaiting = true;
                      });

                      DataResponse<VisitDetail> response = await onCreateVisit();
                      if(response.isError())
                        {
                          showAlertDialog(context, "방문기 생성 실패!", "방문기 생성을 실패하였습니다. 전에 같은 제목으로 생성한 방문기가 있는지 체크해주세요.");
                          setState((){
                            isWaiting = false;
                          });

                          return;
                        }

                      Navigator.of(context).pop(null);
                    },
                  ),
                )

              ],
            ),
          ),
          spacer(1),
          Flexible(
            flex:35,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   inputFieldName("제목"),
                    newSpacer(),
                    inputField(titleController),
                    newSpacer(),
                    inputFieldName("주소"),
                    newSpacer(),
                    rowInputField(addressController, "주소찾기", () async {
                      Juso temp = await Navigator.of(context).pushNamed(DisplayJusoScreen.route) as Juso;
                      addressController.text = temp.roadAddrPart1;
                    }),
                    newSpacer(),
                    inputFieldName("상세주소"),
                    newSpacer(),
                    inputField(detailAddressController),
                    newSpacer(),
                    inputFieldName("태그"),
                    newSpacer(),
                    inputField(tagsController),
                    newSpacer(),
                    newSpacer(),
                    newSpacer(),
                    newSpacer(),
                    ...converContentTowidgets(),
                    newSpacer(),
                    newSpacer(),
                    newSpacer(),
                    newSpacer()

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputFieldName(String name) {
    return SizedBox(
      height: screenHeight * 0.05,
      child: Text(
        name, textScaleFactor: 1.2,
      ),
    );
  }

  Widget rowInputField(TextEditingController cont, String buttonString, Function() onPressed) {
    return SizedBox(
      height: screenHeight * 0.05,
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
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(buttonString, style: TextStyle(color: Colors.white),),
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget inputField(TextEditingController cont) {
    return SizedBox(
      height: screenHeight * 0.05,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(2.0),
            fillColor: Colors.white,
            enabledBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.5),
            ),
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.5 ),
            )
        ),
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }

  Widget buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex:5,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: IconButton(onPressed: (){
              content.addText(TextContent(text:""));
              setState((){
                if(_scrollController.hasClients) {
                  _scrollController.jumpTo(_scrollController.position.maxScrollExtent + screenHeight);
                }
              });
            }, icon: SvgPicture.asset("assets/logos/text_add_button.svg")),
          ),
        ),
        spacer(1),
        Flexible(
          flex:5,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: IconButton(onPressed: (){
              content.addImage(ImageContent());
              setState((){
                if(_scrollController.hasClients) {
                  _scrollController.jumpTo(_scrollController.position.maxScrollExtent + screenHeight);
                }
              });
            }, icon: SvgPicture.asset("assets/logos/image_add_button.svg")),
          ),
        ),
        spacer(1),
        Flexible(
          flex:5,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: IconButton(onPressed: (){
              content.addSpacer(SpacerContent());
              setState((){
                if(_scrollController.hasClients) {
                  _scrollController.jumpTo(_scrollController.position.maxScrollExtent + screenHeight);
                }
              });
            }, icon: SvgPicture.asset("assets/logos/space_add_button.svg")),
          ),
        )

      ],
    );
  }

  List<Widget> converContentTowidgets()
  {
    List<Widget> list  = [];
    late Widget temp;
    for(ContentComponent comp in content.getContents())
      {
        if(comp.isText())
          {
            temp = GestureDetector(
                onLongPress: () {

                    content.removeText(comp as TextContent);
                    setState((){});


                },
                child: TextContentWidget(textContent: comp as TextContent)
            );
          }
        else if(comp.isImage())
          {
            temp = GestureDetector(
                onLongPress: (){
                  content.removeImage(comp as ImageContent);
                  setState((){});
                },
                child: ImageContentWidget(imageContent: comp as ImageContent)
            );
          }
        else{
          temp = GestureDetector(
              onLongPress: (){
                content.removeSpacer(comp as SpacerContent);
                setState((){});
              },
              child: SpacerWidget(spacer: comp as SpacerContent)
          );
        }

        list.add(temp);
      }

    return list;
  }


  Widget newSpacer()
  {
    return SizedBox(
      height: screenHeight * 0.005,
    );
  }


  Widget spacer(int flex) {
    return Flexible(
      flex: flex,
      child: Container(),
    );
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

  //------------------------------------------------------------------------------

  Future<DataResponse<VisitDetail>> onCreateVisit() async
  {

    String title = titleController.text;
    String address = addressController.text;
    String detailAddress = detailAddressController.text;
    List<String> tags = tagsController.text.split("#").where((text) => text != "").toList();


   return await cont.addVisit(title: title, address: address, detailAddress: detailAddress,
       content: content, tags: tags);
  }
}


//---------------------------- classes-------------------------------------------
class TextContentWidget extends StatelessWidget
{
  final TextContent textContent;
  TextContentWidget({Key? key, required this.textContent }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).primaryColor
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white
            ) ,
          child: TextFormField(
            onChanged: (String text){
              textContent.setText(text);
              print(textContent.getText());
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(2.0),
                fillColor: Colors.white,
                enabledBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 0.5),
                ),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 0.5 ),
                )
            ),
            style: TextStyle(
                color: Colors.black
            ),
          ),
        ),
      ),
    );
  }



}

class ImageContentWidget extends StatefulWidget
{
  final ImageContent imageContent;
  ImageContentWidget({Key? key, required this.imageContent }) : super(key: key);

  @override
  State<ImageContentWidget> createState() => _ImageContentWidgetState();
}

class _ImageContentWidgetState extends State<ImageContentWidget> {
  @override
  void initState()
  {

  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: SizedBox(
          height: screenHeight * 0.3,
          child: Container(
            child: widget.imageContent.getPath() == ""? IconButton(
                icon: SvgPicture.asset('assets/logos/camera_icon.svg'),
                onPressed: _getFromCamera,
                ):
              Image.file( File(widget.imageContent.getPath())),
          ),
        ),
      ),
    );
  }

  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery
    );

    if (pickedFile != null) {
        print(pickedFile.path);
        widget.imageContent.setPath(pickedFile.path);
    }

    setState((){});
  }
}

class SpacerWidget extends StatelessWidget
{
  const SpacerWidget({Key? key, required this.spacer}) : super(key: key);
  final SpacerContent spacer;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
          height: screenHeight * 0.1,
          width: double.infinity,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).primaryColor
              ),
            child: Center(
              child: Text("spacer", style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold),textScaleFactor: 1.5,),
            ),
          )
      ),
    );
  }
}

