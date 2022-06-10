import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hackerton_project/view/export_view.dart';
import 'package:hackerton_project/view/main_frame.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/controller.dart';
import '../model/export_file.dart';

class GraphDataScreen extends StatefulWidget
{
  const GraphDataScreen({Key? key}) : super(key: key);
  static const route = "/graphDataScreen";

  @override
  State<GraphDataScreen> createState() => _GraphDataScreenState();
}

class _GraphDataScreenState extends State<GraphDataScreen> {
  Controller cont = Controller();

  String generalAddress = "서울시";
  String detailAddress = "";
  bool callFindGraph = false;

  late DetailDropDownMenu detailDropDownMenu;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return MainFrame(mainWidget: Column(
      children: [
        Flexible(
          flex:3,
          child: Row(
            children: [
              spacer(1),
              Flexible( flex: 8, child: dropDownMenuForGeneral()),
              spacer(1),
              Flexible(flex: 8, child: dropDownMenuForDetail()),
              spacer(1)
            ],
          ),
        ),
        spacer(2),
        Flexible(
          flex:20,
          child: callFindGraph? getGraphFutureBuilder(): Container()
        ),
        spacer(1)

      ],
    ),
        iconButtons: RowButton(pressedButton: RowButton.STAT_BUTTON,));
  }

  Widget dropDownMenuForGeneral()
  {
    return FutureBuilder( future: getGeneralAddressList(),
        builder:(BuildContext context, AsyncSnapshot<dynamic> snapShot){
          if(snapShot.connectionState == ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator());
          }
          else if(snapShot.connectionState == ConnectionState.done)
          {
            if(snapShot.hasError)
            {
              print(snapShot.error);
              print("error has occurred!");
              return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요."));
            }
          }
          DataResponse<List<String>> data = snapShot.hasData ? snapShot.data: [];
          if(data.errorCode == -1)
          {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(LogInScreen.route, (Route<dynamic> route) => false);
          }
          else if(data.errorCode == 1 || data.data == null)
          {
            print("error code is 1");

            return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요"));
          }

          List<String> addresses = data.data!;

          return GeneralDropDownMenu(address: addresses, onChanged: onChangedGeneral, initialVal: generalAddress,);
  });
  }

  Widget spacer(int flex) {
    return Flexible(
      flex: flex,
      child: Container(),
    );
  }

  Widget dropDownMenuForDetail()
  {
    return FutureBuilder( future: getDetailAddressList(),
        builder:(BuildContext context, AsyncSnapshot<dynamic> snapShot){
          if(snapShot.connectionState == ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator());
          }
          else if(snapShot.connectionState == ConnectionState.done)
          {
            if(snapShot.hasError)
            {
              print(snapShot.error);
              print("error has occurred!");
              return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요."));
            }
          }
          DataResponse<List<String>> data = snapShot.hasData ? snapShot.data: [];
          if(data.errorCode == -1)
          {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(LogInScreen.route, (Route<dynamic> route) => false);
          }
          else if(data.errorCode == 1 || data.data == null)
          {
            print("error code is 1");

            return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요"));
          }

          List<String> addresses = data.data!;
          detailAddress = detailAddress == ""? data.data![0]: detailAddress;

          detailDropDownMenu = DetailDropDownMenu(detailAddress: addresses, onChanged: onChangedDetail, initialVal: detailAddress,);

          return detailDropDownMenu;
        });
  }
  
  Widget getGraphFutureBuilder()
  {
    return FutureBuilder( future: getRealEsateData(),
        builder:(BuildContext context, AsyncSnapshot<dynamic> snapShot){
          if(snapShot.connectionState == ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator());
          }
          else if(snapShot.connectionState == ConnectionState.done)
          {
            if(snapShot.hasError)
            {
              print(snapShot.error);
              print("error has occurred!");
              return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요."));
            }
          }
          DataResponse<List<RealEstateData>> data = snapShot.hasData ? snapShot.data: [];
          if(data.errorCode == -1)
          {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(LogInScreen.route, (Route<dynamic> route) => false);
          }
          else if(data.errorCode == 1 || data.data == null)
          {
            print("error code is 1");

            return Center(child: Text("에러가 발생했습니다. 새로고침을 해주세요"));
          }

          List<RealEstateData> realEstateData = data.data!;
         

          return getGraph(realEstateData);
        });
  }

  Widget getGraph(List<RealEstateData> data)
  {
    return SfCartesianChart(
      title: ChartTitle(text: '지역별 평당 아파트 평균 가격', textStyle: TextStyle(color: Theme.of(context).primaryColor)),
      series: <ChartSeries>[
        LineSeries<RealEstateData, double>(
            dataSource: data,
            xValueMapper: (RealEstateData data, _) => double.parse(data.researchYear.toString() +"."+ data.researchMonth.toString()),
            yValueMapper: (RealEstateData data, _) => (double.parse(data.price) * 3 / 10).toInt(),
            dataLabelSettings: DataLabelSettings(isVisible:true, ),
            )
      ],
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: "조사날짜"),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}만원',
      )
    );
  }


  Future<DataResponse<List<String>>> getGeneralAddressList() async
  {

    return await cont.getGeneralAddress();
  }

  Future<DataResponse<List<String>>> getDetailAddressList() async{

    return await cont.getDetailAddress(generalAddress);

  }

  Future<DataResponse<List<RealEstateData>>> getRealEsateData() async{
    return await cont.getRealEstateData(generalAddress: generalAddress, detailAddress: detailAddress);
  }

  //-----------------------------------------------------------------
  void onChangedGeneral(String value) async
  {
    generalAddress = value;
    DataResponse<List<String>> val = await getDetailAddressList();
    detailDropDownMenu.reset(val.data ?? []);
    print("generalAddress:" + generalAddress);
    detailAddress = val.data == null? "": val.data![0];

  }

  void onChangedDetail(String value)
  {

      detailAddress = value;
      print("detailAddress: " + detailAddress);
      callFindGraph = true;
      setState((){});
  }
}

class GeneralDropDownMenu extends StatefulWidget {
  final Function onChanged;
  String initialVal;
   GeneralDropDownMenu({Key? key, required this.address, required this.onChanged, required this.initialVal }) : super(key: key);
  final List<String> address;
  @override
  State<GeneralDropDownMenu> createState() => _GeneralDropDownMenuState();

}

class _GeneralDropDownMenuState extends State<GeneralDropDownMenu> {

  late String generalAddress;

  @override
  void initState()
  {
    super.initState();
    generalAddress = widget.initialVal;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        items: dropDownMenuList(widget.address),
        value: generalAddress,
        onChanged: (value){
            print(value);
            setState((){
              generalAddress = value as String ?? generalAddress;
              widget.onChanged(value);
            });

          });
  }

  List<DropdownMenuItem<String>> dropDownMenuList(List<String> addresses)
  {
    List<DropdownMenuItem<String>> menuItems = [];

    for(String t in addresses)
    {
      menuItems.add(DropdownMenuItem(
        value: t,
        child: Text(t),
      ));
    }

    return menuItems;
  }



}

class DetailDropDownMenu extends StatefulWidget {
  late final ValueNotifier<List<String>> valueNotifier;
  final Function onChanged;
  String initialVal;
  DetailDropDownMenu({Key? key, required List<String> detailAddress, required this.onChanged, required this.initialVal}) : super(key: key){
    valueNotifier = ValueNotifier(detailAddress);
  }

  @override
  State<DetailDropDownMenu> createState() => _DetailDropDownMenuState();

  void reset(List<String> detailAddress)
  {
    valueNotifier.value = detailAddress;

  }

}

class _DetailDropDownMenuState extends State<DetailDropDownMenu> {

  late String detailAddress;
  late List<String> addresses1;

  @override
  void initState()
  {
    addresses1 = widget.valueNotifier.value;
    detailAddress = widget.initialVal;
    print("initial value initState: " + detailAddress );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.valueNotifier,
        builder:(BuildContext context, List<String> addresses, Widget? child){
              return DropdownButton(
                  value: initialValue(addresses),
                  items: dropDownMenuList(addresses),
                  onChanged: (value){
                    print(value);
                    setState((){
                      print("set state of onchagned detail Menu called!");
                      this.addresses1 = addresses;
                      detailAddress = value as String;
                      print("detail address in set State: " + detailAddress);
                      widget.onChanged(value);
                    });

                  });
        }
    );
  }


  String initialValue(List<String> addresses)
  {
    bool resetCalled = true;

    if(addresses1.length == addresses.length)
    {
      bool allSame = true;

      for(int i = 0 ; i < addresses1.length; i++)
        {
          if(addresses1[i] != addresses[i])
            {
              allSame = false;
              break;
            }
        }

      if(allSame)
        {
          resetCalled = false;
        }
    }


    print("resetCalled: ");
    print(resetCalled);
    String inital = resetCalled? addresses[0]: detailAddress;
    print("initial: " + inital);
    
    return inital;
  }

   /*

  String initialValue(List<String> addresses){
    if(detailAddress == "")
      {
        detailAddress = addresses[0];
      }

    return detailAddress;
  }

   */


  List<DropdownMenuItem<String>> dropDownMenuList(List<String> addresses)
  {
    List<DropdownMenuItem<String>> menuItems = [];

    for(String t in addresses)
    {
      menuItems.add(DropdownMenuItem(
        value: t,
        child: Text(t,
        overflow: TextOverflow.ellipsis),
      ));
    }

    return menuItems;
  }
}



