import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackerton_project/repository/Repository.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class TotalRepository{
  String? userSysId;

  final String addrConfmKey = "devU01TX0FVVEgyMDIyMDMwNjE5MzI1OTExMjMxNTQ=";

  final String authority = "";

  final String changePersonalInfoPath = "";
  final String uploadProfilePicturePath = "";
  final String findIdPath = "";
  final String changePassPath = "";
  final String getPointPath = "";
  final String getMeetingStreamPath = "";
  final String getTimeTablePath = "";
  final String addCoursePath = "";
  final String addExtraCurricularPath = "";
  final String deleteCoursePath = "";
  final String deleteExtracCurricularPath = "";
  final String changeCoursePath = "";
  final String changeExtraCurricularPath = "";
  final String getMatchedStudentsPath = "";
  final String getStudiesPath = "";
  final String createStudyRoomPath = "";
  final String sendInvitationPath = "";
  final String acceptInvitationPath = "";
  final String rejectInvitationPath = "";
  final String searchStudentsPath = "";
  final String getInvitedPath = "";
  final String getInvitingPath = "";
  final String startMeetingPath = "";
  final String joinMeetingPath = "";
  final String getMeetingTotalNumbPath = "";
  final String getChatStreamPath = "";
  final String checkNewMsgPath = "";
  final String uploadChatPath = "";



  final String sendVerificationRequestForIdPath = "";
  final String sendVerificationCodeForIdPath = "";
  final String sendVerificationCodeForPsPath = "";
  final String sendVerificationRequestForPsPath = "";
  final String createNewPsPath = "";
  final String checkDuplicateIdPath = "";
  final String checkDuplicateNicknamePath = "";
  final String getAddrPath = "https://www.juso.go.kr/addrlink/addrLinkApi.do";
  final String phoneNumberVerificationRequestPath = "";
  final String phoneNumberVerificationCheckPath = "";
  final String signUpPath = "";
  final String logInPath = "";

  static const logInKey = "logIn";
  static const passwdKey = "passwd";
  static const tokenKey = "token";
  static const statusCode = "statusCode";

  final FlutterSecureStorage storage = FlutterSecureStorage();

  WebSocketChannel? chatChannel;
  WebSocketChannel? meetingChannel;
  Stream? meetingStream;
  Stream? chatStream;

  static final TotalRepository _totalRepository = TotalRepository._privTotalRepository();

  factory TotalRepository()
  {
    return _totalRepository;
  }

  TotalRepository._privTotalRepository()
  {

  }

  Map<String, String> authorizationHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'};

  Future<Map<String, dynamic>> sendVerificationRequestForId(Map<String,dynamic> requestBody) async
  {
    late http.Response result;
    try {
      Uri url = Uri.https(authority, sendVerificationRequestForIdPath);
      result = await http.post(
          url, body: json.encode(requestBody));
    }
    catch(e)
    {
      print(e);
      return {};
    }

    Map<String, dynamic> res = json.decode(result.body);
    res[statusCode] = result.statusCode;
     return res;

  }

  Future<Map<String, dynamic>> sendVerificationCodeForId(Map<String,dynamic> requestBody) async
  {

    late http.Response result;
    try {
      Uri url = Uri.https(authority, sendVerificationCodeForIdPath);
      result = await http.post(url, body: json.encode(requestBody));
    }
    catch(e)
    {
      print(e);
      return {};
    }

    Map<String, dynamic> res = json.decode(result.body);
    res[statusCode] = result.statusCode;
    return res;
  }


  Future<Map<String, dynamic>> sendVerificationRequestForPs(Map<String, dynamic> requestBody) async
  {
    late http.Response result;
    try {
      Uri url = Uri.https(authority, sendVerificationRequestForPsPath);
      result = await http.post(url, body: json.encode(requestBody));
    } catch (e) {
      print(e);
      return {};
    }

    Map<String, dynamic> res = json.decode(result.body);
    res[statusCode] = result.statusCode;
    return res;
  }

  Future<Map<String, dynamic>> sendVerificationCodeForPs(Map<String, dynamic> requestBody) async
  {
    late http.Response result;
    try {
      Uri url = Uri.https(authority, sendVerificationCodeForPsPath);
      result = await http.post(url, body: json.encode(requestBody));
    } on Exception catch (e) {
      print(e);
      return {};
    }

    Map<String, dynamic> res = json.decode(result.body);
    res[statusCode] = result.statusCode;
    return res;
  }

  Future<Map<String, dynamic>> createNewPs(Map<String, dynamic> requestBody) async
  {
    late http.Response result;
    try {
      Uri url = Uri.https(authority, createNewPsPath);
      result = await http.post(url, body: json.encode(requestBody));
    } on Exception catch (e) {
      print(e);
      return {};
    }

    Map<String, dynamic> res = json.decode(result.body);
    res[statusCode] = result.statusCode;
    return res;
  }

  Future<Map<String, dynamic>> checkDuplicateId(Map<String, dynamic> requestBody) async
  {
    late http.Response result;

    try {
      Uri url = Uri.https(authority, checkDuplicateIdPath);
      result = await http.post(url, body: json.encode(requestBody));
    } on Exception catch (e) {
      print(e);
      return {};
    }

    Map<String, dynamic> res = json.decode(result.body);
    res[statusCode] = result.statusCode;
    return res;
  }

  Future<Map<String, dynamic>> checkDuplicateNickname(Map<String, dynamic> requestBody) async
  {
    late http.Response result;

    try {
      Uri url = Uri.https(authority, checkDuplicateNicknamePath);
      result = await http.post(url, body: json.encode(requestBody));
    } on Exception catch (e) {
      print(e);
      return {};
    }

    Map<String, dynamic> res = json.decode(result.body);
    res[statusCode] = result.statusCode;
    return res;
  }

  Future<Map<String, dynamic>> getAddr(Map<String, dynamic> queryParameters) async
  {
    queryParameters["confmKey"] = addrConfmKey;
    queryParameters["resultType"] = "json";
    late http.Response result;

    try {
      Uri url = Uri.https(authority, getAddrPath, queryParameters);
      result = await http.get(url);
    } on Exception catch (e) {
      print(e);
      return {};
    }

    Map<String, dynamic> res = json.decode(result.body);
    res[statusCode] = result.statusCode;
    return res;
  }

  Future<Map<String, dynamic>> phoneNumberVerificationRequest (Map<String, dynamic> requestBody) async
  {
    late http.Response result;
    try {
      Uri url = Uri.https(authority, phoneNumberVerificationRequestPath);
      result = await http.post(url, body: json.encode(requestBody));
    } on Exception catch (e) {
      print(e);
      return {};
    }

    Map<String, dynamic> res = json.decode(result.body);
    res[statusCode] = result.statusCode;
    return res;
  }

  Future<Map<String, dynamic>> phoneNumberVerificationCheck (Map<String, dynamic> requestBody) async
  {
    late http.Response result;
    try {
      Uri url = Uri.https(authority, phoneNumberVerificationCheckPath);
      result = await http.post(url, body: json.encode(requestBody));
    } on Exception catch (e) {
      print(e);
      return {};
    }

    Map<String, dynamic> res = json.decode(result.body);
    res[statusCode] = result.statusCode;
    return res;
  }

  Future<Map<String, dynamic>> signUp(Map<String, dynamic> requestBody) async
  {
    late http.Response result;

    try {
      Uri url = Uri.https(authority, signUpPath);
     result = await http.post(url, body: json.encode(requestBody));
    } on Exception catch (e) {
      print(e);
      return {};
    }

    Map<String, dynamic> res = json.decode(result.body);
    res[statusCode] = result.statusCode;
    return res;
  }


  Future<Map<String, String>> getLogInData() async
  {
    Map<String, String> credentials = {};
    String? id = await storage.read(key: logInKey);
    String? pswd = await storage.read(key: passwdKey);

    if(id != null)
      credentials["id"] = id;

    if(pswd != null)
      credentials["ps"] = pswd;

    return credentials;
  }

  Future<bool> storeLoginData(String id, String pswd ) async
  {
    bool success = true;
    try
        {
        await storage.write(key: logInKey, value: id);
        await storage.write(key:passwdKey, value: pswd);
        }
        catch(e)
    {
      print(e);
      success = false;
    }

    return success;
  }

  Future<bool> storeToken(String token) async
  {
    authorizationHeader["token"] = token;

    bool success = true;
    try
    {
      await storage.write(key: tokenKey, value: token);
    }
    catch(e)
    {
      print(e);
      success = false;
    }

    return success;
  }

  Future<String?> getToken() async
  {
    String? token = await storage.read(key: tokenKey);
    return token;
  }

  Future<Map<String, dynamic>> logIn (Map<String, dynamic> logInInfo)
  async
  {
    Uri url = Uri.https(authority, logInPath);
    late http.Response result;
    try {
     result = await http.post(url, body: json.encode(logInInfo));
    }
    catch(e){
      print(e);
      return {};
    }

    Map<String,dynamic> res = json.decode( result.body);
    res[statusCode] = result.statusCode;
    return res;
  }


  Future<Map<String, dynamic>> changePersonalInfo(Map<String, dynamic> personalInfo) async
  {
    Uri url = Uri.https(authority, changePersonalInfoPath);
    http.Response result = await http.post(url, headers:
        authorizationHeader,
        body: json.encode(personalInfo));

    Map<String,dynamic> res = json.decode( result.body);
    if(result.statusCode == 200)
      res["success"] = 1;
    else
      res["sucess"] = 0;

    return res;
  }

  Future<Map<String, dynamic>> uploadProfilePicture(Map<String,dynamic> pictInfo) async
  {
    Uri url = Uri.https(authority, uploadProfilePicturePath);
    var request = http.MultipartRequest("POST", url);
    request.headers.addAll({"Authorization": authorizationHeader["Authorization"]??""});
    request.files.add(await http.MultipartFile.fromPath("profilePicture", pictInfo["path"] as String));
    request.fields["userSysId"] = pictInfo["userSysId"] as String;

    var response = await request.send();
    var res = await http.Response.fromStream(response);

    var result = json.decode(res.body);

    if(res.statusCode == 200)
      {
        result["success"] = 1;
      }
    else
      result["success"] = 0;

    return result;
  }

  //Future<Map<String, dynamic>> snsVerification (Map<String, dynamic> phoneNumb);



  //Future<Map<String, dynamic>> findPass (Map<String, dynamic> infoForFindingPasswd);   //문자로 인증후 비번 새로 변경하기!

  Future<Map<String, dynamic>> changePass(Map<String, dynamic> passInfo) async
  {
    Uri url = Uri.https(authority, changePassPath);
    http.Response result = await http.post(url,
        body: json.encode(passInfo));

    var res = json.decode(result.body);

    if(res.statusCode == 200)
    {
      res["success"] = 1;
    }
    else
      res["success"] = 0;

    return res;
  }

  Future<Map<String, dynamic>> getPoints(Map<String, dynamic> userInfo) async
  {
    Uri url = Uri.https(authority, getPointPath);
    http.Response result = await http.post(url,
        headers: authorizationHeader,
        body: json.encode(userInfo));

    return json.decode(result.body);
  }

  Future<Map<String, dynamic>> getTimeTable (Map<String, dynamic> studentInfo) async
  {
    Map<String, dynamic> queryStringParam = {
      "userSysId": studentInfo["userSysId"],
      "semester": studentInfo["semester"],
      "schoolYear" : studentInfo["schoolYear"]
    };

    Uri url = Uri.https(authority, getTimeTablePath, queryStringParam);
    http.Response result = await http.get(url ,headers: authorizationHeader);

    return json.decode(result.body);
  }

  Future<Map<String, dynamic>> addCourse (Map<String, dynamic> course) async
  {
    Uri url = Uri.https(authority, addCoursePath);
    http.Response result = await http.post(url,
        headers: authorizationHeader,
        body: json.encode(course));

    var res = json.decode(result.body);

    if(res.statusCode != 200)
    {
      res["courseId"] = -1;
    }

    return res;
  }

  Future<Map<String, dynamic>> addExtraCurricular (Map<String, dynamic> extraCurricular) async
  {
    Uri url = Uri.https(authority, addExtraCurricularPath);
    http.Response result = await http.post(url,
        headers: authorizationHeader,
        body: json.encode(extraCurricular));

    var res = json.decode(result.body);

    if(res.statusCode != 200)
    {
      res["extraCurricularId"] = -1;
    }

    return res;
  }

  Future<Map<String, dynamic>> deleteCourse (Map<String, dynamic> courseInfo) async
  {
    Map<String, String> queryStringParam = {"courseId": courseInfo["courseId"]};
    Uri url = Uri.https(authority, deleteCoursePath, queryStringParam);
    http.Response result = await http.delete(url, headers: authorizationHeader,);
    var res = json.decode(result.body);

    if(res.statusCode == 200)
    {
      res["success"] = 1;
    }
    else
      res["success"] = 0;

    return res;
  }

  Future<Map<String, dynamic>> deleteExtraCurricular (Map<String, dynamic> extraCurricularInfo) async
  {
    Map<String, String> queryStringParam = {"extraCurricularId": extraCurricularInfo["extraCurricularId"]};
    Uri url = Uri.https(authority, deleteExtracCurricularPath, queryStringParam);
    http.Response result = await http.delete(url, headers: authorizationHeader,);

    var res = json.decode(result.body);

    if(res.statusCode == 200)
    {
      res["success"] = 1;
    }
    else
      res["success"] = 0;

    return res;
  }

  Future<Map<String, dynamic>> changeCourse (Map<String, dynamic> courseInfo) async
  {
    Uri url = Uri.https(authority, changeCoursePath);
    http.Response result = await http.put(url,
        headers: authorizationHeader,
        body: json.encode(courseInfo));

    var res = json.decode(result.body);

    if(res.statusCode == 200)
    {
      res["success"] = 1;
    }
    else
      res["success"] = 0;

    return res;
  }

  Future<Map<String, dynamic>> changeExtraCurricular (Map<String, dynamic> extraCurricularInfo) async
  {
    Uri url = Uri.https(authority, changeExtraCurricularPath);
    http.Response result = await http.put(url,
        headers: authorizationHeader,
        body: json.encode(extraCurricularInfo));

    var res = json.decode(result.body);

    if(res.statusCode == 200)
    {
      res["success"] = 1;
    }
    else
      res["success"] = 0;

    return res;
  }

  Future<Map<String, dynamic>> getMatchedStudents(Map<String, dynamic> studentInfo) async
  {
    var queryStringParam = {"userSysId": studentInfo["userSysId"]};
    Uri url = Uri.https(authority, getMatchedStudentsPath, queryStringParam);
    http.Response result = await http.get(url, headers: authorizationHeader,);

    return json.decode(result.body);
  }

  Future<Map<String, dynamic>> getStudies (Map<String, dynamic> studentInfo) async
  {
    var queryStringParam = {"userSysId": studentInfo["userSysId"]};
    Uri url = Uri.https(authority, getStudiesPath, queryStringParam);
    http.Response result = await http.get(url, headers: authorizationHeader,);

    return json.decode(result.body);
  }

  Future<Map<String, dynamic>> createStudyRoom(Map<String, dynamic> userInfo) async
  {
    Uri url = Uri.https(authority, createStudyRoomPath);
    http.Response result = await http.post(url,
        headers: authorizationHeader,
        body: json.encode(userInfo));

    var res = json.decode(result.body);

    if(res.statusCode == 200)
    {
      res["success"] = 1;
    }
    else
      res["success"] = 0;

    return res;
  }

  Future<Map<String, dynamic>> sendInvitation(Map<String, dynamic> userInfo) async
  {
    Uri url = Uri.https(authority, sendInvitationPath);
    http.Response result = await http.post(url,
        headers: authorizationHeader,
        body: json.encode(userInfo));

    var res = json.decode(result.body);

    if(res.statusCode == 200)
    {
      res["success"] = 1;
    }
    else
      res["success"] = 0;

    return res;
  }

  Future<Map<String, dynamic>> acceptInvitation(Map<String, dynamic> studyInfo) async
  {
    Uri url = Uri.https(authority, acceptInvitationPath);
    http.Response result = await http.put(url,
        headers: authorizationHeader,
        body: json.encode(studyInfo));

    var res = json.decode(result.body);

    if(res.statusCode == 200)
    {
      res["success"] = 1;
    }
    else
      res["success"] = 0;

    return res;
  }

  Future<Map<String, dynamic>> rejectInvitation(Map<String, dynamic> studyInfo) async
  {
    Uri url = Uri.https(authority, rejectInvitationPath);
    http.Response result = await http.post(url,
        headers: authorizationHeader,
        body: json.encode(studyInfo));

    return json.decode(result.body);
  }

  Future<Map<String, dynamic>> searchStudents(Map<String, dynamic> searchInfo) async
  {
    var queryStringParma = {"userName": searchInfo["userName"]};
    Uri url = Uri.https(authority, searchStudentsPath, queryStringParma);
    http.Response result = await http.get(url, headers: authorizationHeader);

    return json.decode(result.body);
  }

  Future<Map<String, dynamic>> getInvited(Map<String, dynamic> getInvitedInfo) async
  {
    var queryStringParma = {"userSysId": getInvitedInfo["userSysId"]};
    Uri url = Uri.https(authority, getInvitedPath, queryStringParma);
    http.Response result = await http.get(url, headers: authorizationHeader);

    return json.decode(result.body);
  }

  Future<Map<String, dynamic>> getInviting(Map<String, dynamic> getInvitingInfo) async
  {
    var queryStringParma = {"userSysId": getInvitingInfo["userSysId"]};
    Uri url = Uri.https(authority, getInvitingPath, queryStringParma);
    http.Response result = await http.get(url, headers: authorizationHeader);

    return json.decode(result.body);
  }

  Future<Map<String, dynamic>> startMeeting (Map<String, dynamic> meetInfo) async
  {
    Uri url = Uri.https(authority, startMeetingPath);
    http.Response result = await http.post(url,
        headers: authorizationHeader,
        body: json.encode(meetInfo));

    var res = json.decode(result.body);

    if(res.statusCode == 200)
    {
      res["success"] = 1;
    }
    else
      res["success"] = 0;

    return res;
  }

  Future<Map<String, dynamic>> joinMeeting (Map<String,dynamic> meetInfo) async
  {
    Uri url = Uri.https(authority, joinMeetingPath);
    http.Response result = await http.post(url,
        headers: authorizationHeader,
        body: json.encode(meetInfo));

    var res = json.decode(result.body);

    if(result.statusCode == 200)
    {
      res["success"] = 1;
    }
    else
      res["success"] = 0;

    return res;
  }

  Future<Map<String, dynamic>> getMeetingTotalNumb (Map<String, dynamic> meetInfo) async
  {
    var queryStringParma = {"studyRoomId": meetInfo["studyRoomId"]};
    Uri url = Uri.https(authority, getMeetingTotalNumbPath, queryStringParma);
    http.Response result = await http.get(url, headers: authorizationHeader,);

    return json.decode(result.body);
  }

  //다른사람이 만났을때 실시간으로 알기위해!
  Stream getMeetingStream(Map<String, dynamic> userInfo)
  {
    final channel = WebSocketChannel.connect(
      Uri.parse(getMeetingStreamPath),
    );

    meetingChannel = channel;

    channel.sink.add(json.encode({"userSysId":userInfo["userSysId"]}));

    meetingStream = channel.stream.asBroadcastStream();

    return meetingStream!;
  }

  //실시간으로 새로운 채팅을 가져온다!
  Stream getChatStream(Map<String, dynamic> userInfo)
  {
    final channel = WebSocketChannel.connect(
      Uri.parse(getChatStreamPath),
    );

    chatChannel = channel;

    channel.sink.add(json.encode({"userSysId": userInfo["userSysId"]}));

    chatStream = channel.stream.asBroadcastStream();

    return chatStream!;
  }

  //chatId와 studyRoomId를 보내서 해당 스터디룸에서 새로운 채팅을 가져온다!
  Future<Map<String, dynamic>> checkNewMsg(Map<String, dynamic> lastChatInfo) async
  {
    var queryStringParma = {
      "studyRoomId":lastChatInfo["studyRoomId"],
      "chatId": lastChatInfo["chatId"]
    };

    Uri url = Uri.https(authority, checkNewMsgPath, queryStringParma);
    http.Response result = await http.get(url,  headers: authorizationHeader);

    return json.decode(result.body);
  }


  Future<Map<String, dynamic>> uploadChat (Map<String, dynamic> chatInfo) async
  {
    Uri url = Uri.https(authority, uploadChatPath);
    var request = http.MultipartRequest("POST", url);
    request.headers.addAll({"Authorization": authorizationHeader["Authorization"]??""});
    request.files.add(await http.MultipartFile.fromPath("chatPicture", chatInfo["path"] as String));
    request.fields["studyRoomId"] = chatInfo["studyRoomId"] as String;
    request.fields["speakerId"] = chatInfo["speakerId"] as String;
    request.fields["content"] = chatInfo["content"] as String;

    var response = await request.send();
    var res = await http.Response.fromStream(response);
    var result = json.decode(res.body);
    if(response.statusCode == 200)
      result["success"] = 1;
    else
      result["success"] = 0;

    return result;
  }

  //Future<Map<String, dynamic>> getChatsForAStudyRoom(Map<String, dynamic> studyRoomInfo);       // local database 사용!

}