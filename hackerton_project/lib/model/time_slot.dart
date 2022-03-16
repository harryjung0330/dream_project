class TimeSlot
{
  late int startTime;
  late int endTime;
  late int day;

  TimeSlot(this.startTime, this.endTime, this.day);

  TimeSlot.fromJson(Map<String, dynamic> timeSlot)
  {
    String start = timeSlot["startTime"] ?? "-1:-1";
    List<String> splittedStrings = start.split(":");

    startTime = (int.tryParse(splittedStrings[0]) ?? 0) * 60 + (int.tryParse(splittedStrings[1]) ?? 0);

    String end = timeSlot["endTime"] ?? "-1:-1";
    splittedStrings = end.split(":");

    endTime = (int.tryParse(splittedStrings[0]) ?? 0) * 60 + (int.tryParse(splittedStrings[1]) ?? 0);

    day = timeSlot["day"] == null ? -1 : int.tryParse(timeSlot["day"]) ?? -1;
  }

  Map<String, dynamic> toJson()
  {
    return {
      "startTime": getStartTime(),
      "endTime": getEndTime(),
      "day": day
    };
  }

  String getStartTime()
  {
    return (startTime / 60).toString() + ":"  + (startTime % 60).toString();
  }

  String getEndTime()
  {
    return (endTime / 60).toString() + ":"  + (endTime % 60).toString();
  }

  String getDay() {
    switch (day) {
      case 0:
        return "월요일";
      case 1:
        return "화요일";
      case 2:
        return "수요일";
      case 3:
        return "목요일";
      case 4:
        return "금요일";
      case 5:
        return "토요일";
      case 6:
        return "일요일";
      default:
        return "에러!";
    }
  }

  @override
  bool operator ==(Object other)
  {
    if(!(other is TimeSlot))
      return false;

    TimeSlot oth = other as TimeSlot;

    if(oth.startTime == this.startTime && oth.endTime == this.endTime && oth.day == this.day )
      {
        return true;
      }

    return false;

  }

}