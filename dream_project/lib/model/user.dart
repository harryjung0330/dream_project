class User
{
  final int userSysId;
  final String userName;
  final String school;
  final String major;
  final String profilePicturePath;

  static final nullUser = User(userSysId: -1, userName: "", school: "", major: "", profilePicturePath: "");

  User({required this.userSysId, required this.userName, required this.school,
    required this.major, required this.profilePicturePath});

  User.fromJson(Map<String, dynamic> userJson):
      userSysId = userJson["userSysId"] == null ? -1 : int.tryParse(userJson["userSysId"]) ?? -1,
      userName = userJson["userName"]?? "",
      school = userJson["school"] ?? "",
      major = userJson["major"] ?? "",
      profilePicturePath = userJson["profilePicturePath"] ?? "";

  Map<String ,dynamic> toJson()
  {
    return {
      "userSysId" : userSysId,
      "userName" : userName,
      "school" : school,
      "major" : major,
      "profilePicturePath" : profilePicturePath
    };
  }

  bool isNull()
  {
    return (userSysId == -1);
  }
}