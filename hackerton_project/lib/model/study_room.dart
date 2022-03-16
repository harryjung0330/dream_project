
import 'package:hackerton_project/model/export_file.dart';

class StudyRoom{
  late final int studyRoomId;
  late String title;
  late List<User> users;
  late int owner;

  StudyRoom({required this.studyRoomId, required this.title, required this.users, required this.owner});

  StudyRoom.fromJson(Map<String, dynamic> studyRoomJson)
  {
    studyRoomId = studyRoomJson["studyRoomId"] == null ? -1 : (int.tryParse(studyRoomJson["studyRoomId"] as String) ?? -1 );
    title = studyRoomJson["studyTitle"] ?? "";
    users = studyRoomJson["users"] == null ? [] : studyRoomJson["users"].map((Map<String, dynamic> user)
    {
      User.fromJson(user);
    }).toList();
    owner = studyRoomJson["owner"] == null ? -1 : (int.tryParse(studyRoomJson["owner"] as String) ?? -1);

  }

  Map<String, dynamic> toJson()
  {
    return {
      "studyRoomId" : studyRoomId,
      "studyTitle": title,
      "users": users.map((user) => user.toJson()).toList(),
      "owner" : owner
    };
  }

  bool isNull()
  {
    return studyRoomId == -1 || users.isEmpty;
  }
}