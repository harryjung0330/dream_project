import 'package:hackerton_project/model/export_file.dart';

class MatchedUser extends User
{
  final String matchedCourse;

  MatchedUser({required userSysId, required userName, required school,
    required major, required profilePicturePath, required this.matchedCourse}):super(
    userSysId: userSysId, userName: userName, school: school, major:major, profilePicturePath:  profilePicturePath
  );

  MatchedUser.fromJson(Map<String, dynamic> matchedUserJson):
        matchedCourse = matchedUserJson["matchedCourse"] ?? "",
        super.fromJson(matchedUserJson);

  Map<String, dynamic> toJson()
  {
    Map<String, dynamic> superJson = super.toJson();
    superJson["matchedCourse"] = matchedCourse;

    return superJson;
  }

  bool isNull()
  {
    return super.isNull() || matchedCourse == "";
  }
}