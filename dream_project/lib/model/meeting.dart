class Meeting
{
  late final int meetId;
  late final DateTime meetingTime;
  late final bool stillMeeting;
  late List<int> users;

  Meeting({required this.meetId, required this.meetingTime, required this.stillMeeting, required this.users});

  Meeting.fromJson(Map<String, dynamic> meetingJson)
  {
    meetId = meetingJson["meetId"] == null ? -1 :int.tryParse(meetingJson["meetId"]) ?? -1;
    meetingTime = meetingJson["meetingTime"] == null? DateTime.now() : DateTime.tryParse(meetingJson["meetingTime"]) ?? DateTime.now();
    if(meetingJson["stillMeeting"] == null)
    {
        stillMeeting = false;
    }
    else{
      int parsed = int.tryParse(meetingJson["stillMeeting"]) ?? 0;
      stillMeeting = parsed == 0 ? false: true;
    }
    users = meetingJson["users"] ?? [];
  }

  Map<String, dynamic> toJson()
  {
    return {
      "meetId": meetId,
      "meetingTime": meetingTime.toString(),
      "stillMeeting": stillMeeting ? 1 : 0,
      "users" : users
    };
  }

  bool isNull()
  {
    return (meetId == -1 || users.isEmpty);
  }

}