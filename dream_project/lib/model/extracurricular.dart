import 'package:hackerton_project/model/export_file.dart';

class Extracurricular
{
  final int extracurricularId;
  String title;
  List<TimeSlot> timeSlots;

  Extracurricular({required this.extracurricularId, required this.title, required this.timeSlots});

  Extracurricular.fromJson(Map<String, dynamic> extraCurricularJson):
        extracurricularId = extraCurricularJson["extraCurricularId"] == null ? -1 :int.tryParse(extraCurricularJson["extraCurricularId"] as String)?? -1,
        title = extraCurricularJson["title"] ?? "",
        timeSlots = extraCurricularJson["timeSlots"].map((Map<String, dynamic> timeSlot){
          TimeSlot.fromJson(timeSlot);
        }).toList();

  Map<String, dynamic> toJson()
  {
    return {
      "extraCurricularId": extracurricularId,
      "title" : title,
      "timeSlots" : timeSlots.map((TimeSlot timeSlot) => timeSlot.toJson()).toList()
    };
  }

  bool isNull()
  {
    return (extracurricularId == -1 || timeSlots.isEmpty);
  }
}
