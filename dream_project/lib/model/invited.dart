import 'package:hackerton_project/model/export_file.dart';

class Invited
{
  late final User inviter;
  late final int studyRoomId;
  late final String studyTitle;

  Invited({required this.inviter, required this.studyRoomId, required this.studyTitle});


  Invited.fromJson(Map<String, dynamic> invitedJson)
  {
    inviter = invitedJson["inviter"] == null ? User.nullUser : User.fromJson(invitedJson["inviter"]);
    studyRoomId = invitedJson["studyRoomId"] == null ? -1 : int.tryParse(invitedJson["studyRoomId"]) ?? -1;
    studyTitle = invitedJson["studyTitle"] ?? "";

  }

  Map<String, dynamic> toJson()
  {
    return {
      "inviter": inviter.toJson(),
      "studyRoomId": studyRoomId,
      "studyTitle": studyTitle
    };
  }

  bool isNull()
  {
    return (inviter.isNull() || studyRoomId == -1);
  }

}