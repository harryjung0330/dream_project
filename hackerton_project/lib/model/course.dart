import 'package:hackerton_project/model/export_file.dart';

class Course
{
  final int courseId;
  String title;
  String? professor;
  List<TimeSlot> timeSlots;
  late bool requestedMatching;

  Course({required this.courseId, required this.title,this.professor, required this.timeSlots, bool requestedMatch = false})
  {
    requestedMatching = requestedMatch;
  }

  Course.fromJson(Map<String, dynamic> courseJson):
        courseId = courseJson["courseId"] == null ? -1 :int.tryParse(courseJson["courseId"] as String)?? -1,
        title = courseJson["title"] ?? "",
        professor = courseJson["professor"],
        timeSlots = courseJson["timeSlots"]?.map((Map<String, dynamic> timeSlot){
            TimeSlot.fromJson(timeSlot);
        }).toList() ?? [],
        requestedMatching = courseJson["requestedMatching"];

  Map<String, dynamic> toJson()
  {
    return {
      "courseId": courseId,
      "title" : title,
      "professor": professor,
      "requestedMatching": requestedMatching ? 1: 0,
      "timeSlots" : timeSlots.map((TimeSlot timeSlot) => timeSlot.toJson()).toList()
    };
  }

  bool isNull()
  {
    return (courseId == -1 || timeSlots.isEmpty);
  }
}