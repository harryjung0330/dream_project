import 'package:hackerton_project/model/export_file.dart';

class Inviting
{
  late final User invited;
  late final String state;
  late final int studyRoomId;
  late final String studyTitle;

  Inviting({required this.invited, required this.state, required this.studyRoomId, required this.studyTitle});

  Inviting.fromJson(Map<String, dynamic> invitingJson)
  {
    invited = invitingJson["invited"] == null ? User.nullUser : User.fromJson(invitingJson["invited"]);
    studyRoomId = invitingJson["studyRoomId"] == null ? -1 : int.tryParse(invitingJson["studyRoomId"]) ?? -1;
    studyTitle = invitingJson["studyTitle"] ?? "";
    state = invitingJson["state"] ?? "";
  }

  Map<String, dynamic> toJson()
  {
    return {
      "invited": invited.toJson(),
      "state": state,
      "studyRoomId": studyRoomId,
      "studyTitle" : studyTitle
    };
  }

  bool isNull()
  {
    return (invited.isNull() || state == "" || studyRoomId == -1);
  }
}