import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../controller/controller.dart';
import '../model/export_file.dart';
import 'export_view.dart';

class LikedVisitsScreen extends StatefulWidget
{
  const LikedVisitsScreen({Key? key}) : super(key: key);
  static const route = "/likedVisitScreen";

  @override
  State<LikedVisitsScreen> createState() => _LikedVisitsScreenState();
}

class _LikedVisitsScreenState extends State<LikedVisitsScreen> {

  late List<Visit> likedVisits;

  @override
  void initState(){
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    likedVisits = ModalRoute.of(context)!.settings.arguments as List<Visit>;

    return MainFrame(mainWidget: Column(
      children: [
        Flexible(
            flex: 2,
            child: Row(
              children: [IconButton(
                icon:Icon(Icons.arrow_back_ios_outlined,
                    color: Theme.of(context).primaryColor),
                onPressed: () {
                  print("back button is pressed!");
                  Navigator.of(context).pop(null);
                },
              ),
                spacer(1),
                Text("관심 방문기", textScaleFactor: 1.2, style: TextStyle(color: Theme.of(context).primaryColor),),
                spacer(20)
              ],
            )
        ),
        Flexible(
            flex: 20,
            child:  visitView(likedVisits, screenHeight * 0.2)
        ),
      ],
    ), iconButtons: RowButton(pressedButton: RowButton.MY_INFO_BUTTON)
    );
  }

  @override
  void dispose()
  {
    super.dispose();
  }

  Widget visitView(List<Visit> visits, double tileHeight)
  {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return visitComponent(visits[index], tileHeight);
        },
        separatorBuilder: (a, b) => const Divider(
            height: 5,
            thickness: 1,
            endIndent: 0,
            color: Color(0xFF2799FA)
        ),
        itemCount: visits.length);
  }


  Widget visitComponent(Visit visit, double tileHeight)
  {
    return GestureDetector(
        onTap: () async{
          await Navigator.pushNamed(context, VisitLikeDetailScreen.route, arguments: visit);
          setState((){});
        },
        child: VisitComponent(tileHeight: tileHeight, visit: visit)
    );
  }



  Widget spacer(int flex) {
    return Flexible(
      flex: flex,
      child: Container(),
    );
  }



}
