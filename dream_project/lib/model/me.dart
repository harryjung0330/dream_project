import 'juso_list.dart';

class Me
{
  late final int userSysId;
  late String userName;
  late String birthDateAndGender;
  late String userLogInId;
  late String userPs;
  late String phoneNumb;
  late String emailAddr;
  late String roadAddress;
  late String detailAddress;
  late String? school;
  late String? major;
  late String? profilePicturePath;


  Me({required this.userSysId, required this.userName, required this.userLogInId, required this.birthDateAndGender,
        required this.userPs, required this.phoneNumb, required this.emailAddr, required this.roadAddress,
        required this.detailAddress, this.school, this.major,
        this.profilePicturePath});

  Me.fromJson(Map<String, dynamic> meJson)
  {
    userSysId = meJson["userSysId"] == null ? -1 :int.tryParse(meJson["userSysId"] as String)?? -1;
    userName = meJson["userName"] ?? "";
    birthDateAndGender = meJson["birthDateAndGender"] ?? "";
    userLogInId = meJson["userLogInId"] ?? "";
    userPs = meJson["userPs"] ?? "";
    phoneNumb = meJson["phoneNumb"] ?? "";
    emailAddr = meJson["emailAddr"] ?? "";
    roadAddress = meJson["roadAddress"] ?? "";
    detailAddress = meJson["detailAddress"] ?? "";
    school = meJson["school"];
    major = meJson["major"];
    profilePicturePath = meJson["profilePicturePath"];

  }

  Map<String, dynamic> toJson()
  {
    return {
      "userSysId": userSysId,
      "userName": userName,
      "birthDateAndGender": birthDateAndGender,
      "userLogInId" : userLogInId,
      "userPs" : userPs,
      "phoneNumb": phoneNumb,
      "emailAddr": emailAddr,
      "roadAddress": roadAddress,
      "detailAddress" : detailAddress,
      "school": school,
      "major": major,
      "profilePicturePath": profilePicturePath,
    };
  }

}