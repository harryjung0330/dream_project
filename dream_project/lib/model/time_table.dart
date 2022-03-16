import 'package:hackerton_project/model/export_file.dart';

class TimeTable
{
  final int userSysId;
  final String semester;
  final String schoolYear;
  late List<Course> courseList;
  late List<Extracurricular> extraCurricularList;

  TimeTable({required this.userSysId, required this.semester, required this.schoolYear,
    required this.courseList, required this.extraCurricularList});

  TimeTable.fromJson(Map<String, dynamic> timeTableJson):
      userSysId = timeTableJson["userSysId"] == null ? -1 : int.tryParse(timeTableJson["userSysId"] as String) ?? -1,
      semester = timeTableJson["semester"] ?? "",
      schoolYear = timeTableJson["schoolYear"] ?? ""
  {
    courseList = timeTableJson["courses"] == null ? []: timeTableJson["courses"].map((course) => Course.fromJson(course)).toList();
    extraCurricularList = timeTableJson["extracurriculars"] == null ? []: timeTableJson["extracurriculars"].map((extracurricular) => Extracurricular.fromJson(extracurricular)).toList();
  }

  Map<String, dynamic> toJson()
  {
    return {
      "userSysId" : userSysId,
      "semester": semester,
      "schoolYear": schoolYear,
      "courses": courseList.map((course) => course.toJson()).toList(),
      "extracurriculars" : extraCurricularList.map((extracurricular) => extracurricular.toJson()).toList()
    };
  }

  bool isNull()
  {
    return (userSysId == -1 || semester == "" || schoolYear == "");
  }
}