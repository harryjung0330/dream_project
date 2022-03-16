
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:hackerton_project/model/export_file.dart';
import 'package:hackerton_project/repository/total_repo.dart';

class Service
{
  static const statusCode = "statusCode";

  TotalRepository rep = TotalRepository();

  static final _serve = Service._privService();

  factory Service()
  {
    return _serve;
  }

  Service._privService(){
    rep = TotalRepository();
  }

  Future<DataResponse<String>> logIn(String logInId, String passwd) async
  {
    Map<String,dynamic> temp = await rep.logIn({"id": logInId, "ps": passwd});
    DataResponse<String> tempStr;
    if(!temp.isEmpty && temp["userSysId"] != null)
    {
      tempStr = DataResponse(data:temp["userSysId"] ?? "");
    }
    else{
      tempStr = DataResponse(errorCode: 0 );

    }
    tempStr.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "Something happened";
        default:
          return "something that I don't know happened!";
      }
    });

   return tempStr;
  }

  Future<Map<String, String>> getLogInData() async
  {
    Map<String,String> temp = await rep.getLogInData();
    return temp;
  }


  Future<bool> uploadProfilePicture(String picturePath, int userSysId) async
  {
    var res = await rep.uploadProfilePicture({"userSysId" : userSysId, "path" : picturePath});

    return res["success"] == 1? true :false;
  }

  //-------------------------------------------------------------------------------------------------------------------
  //이름과 이메일을 가지고 서버에게 이메일로 인증번호를 보내달라고 요청, 성공하면 status - 1
  Future<DataResponse<bool>> sendVerificationRequestForId({required String userName, required String emailAddr}) async
  {
    var res = await rep.sendVerificationRequestForId({"userName" : userName, "emailAddr": emailAddr});
    DataResponse<bool> tempBool;
    if(!res.isEmpty && res["status"] != null)
    {
      tempBool = DataResponse(data:res["status"]);
    }
    else{
      tempBool = DataResponse(errorCode: 0 );

    }
    tempBool.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "Something happened";
        default:
          return "something that I don't know happened!";
      }
    });

    return tempBool;

  }

  Future<DataResponse<String>> sendVerificationCodeForId({required String emailAddr, required String code}) async
  {
    var res = await rep.sendVerificationCodeForId({"emailAddr" : emailAddr, "code": code});
    DataResponse<String> tempStr;

    if(!res.isEmpty && res["userLogInId"] != null)
    {

      tempStr = DataResponse(data:res["userLogInId"]);
    }
    else{
      tempStr = DataResponse(errorCode: 0 );

    }
    tempStr.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "Something happened";
        default:
          return "something that I don't know happened!";
      }
    });

    return tempStr;
  }

  Future<DataResponse<bool>> sendVerificationRequestForPs({required String logInId, required String emailAddr}) async
  {
    var res = await rep.sendVerificationCodeForPs({"id": logInId, "emailAddr": emailAddr});
    DataResponse<bool> tempBool;

    if(!res.isEmpty && res["status"] != null)
    {
      tempBool = DataResponse(data:res["status"]);
    }
    else{
      tempBool = DataResponse(errorCode: 0 );

    }
    tempBool.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "Something happened";
        default:
          return "something that I don't know happened!";
      }
    });

    return tempBool;
  }

  Future<DataResponse<bool>> sendVerificationCodeForPs({required String emailAddr, required String code}) async
  {
    var res = await rep.sendVerificationCodeForPs({"emailAddr": emailAddr, "code": code});

    DataResponse<bool> tempBool;

    if(!res.isEmpty && res["status"] != null)
    {
      tempBool = DataResponse(data:res["status"]);
    }
    else{
      tempBool = DataResponse(errorCode: 0 );
    }

    tempBool.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "Something happened";
        default:
          return "something that I don't know happened!";
      }
    });

    return tempBool;
  }

  Future<DataResponse<bool>> createNewPs({required String ps, required String emailAddr}) async
  {
    var res = await rep.createNewPs({"ps": ps, "emailAddr": emailAddr});

    DataResponse<bool> tempBool;

    if(!res.isEmpty && res["status"] != null)
    {
      tempBool = DataResponse(data:res["status"]);
    }
    else{
      tempBool = DataResponse(errorCode: 0 );
    }

    tempBool.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "Something happened";
        default:
          return "something that I don't know happened!";
      }
    });

    return tempBool;
  }


  Future<DataResponse<bool>> checkDuplicateId({required String id}) async
  {
    var res = await rep.checkDuplicateId({"id": id});
    DataResponse<bool> tempBool;

    if(!res.isEmpty && res["status"] != null)
    {
      tempBool = DataResponse(data:res["status"]);
    }
    else{
      tempBool = DataResponse(errorCode: 0 );
    }

    tempBool.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "Something happened";
        default:
          return "something that I don't know happened!";
      }
    });

    return tempBool;
  }

  Future<DataResponse<bool>> checkDuplicateNickname({required String nickName}) async
  {
    var res = await rep.checkDuplicateNickname({"nickName": nickName});

    DataResponse<bool> tempBool;

    if(!res.isEmpty && res["status"] != null)
    {
      tempBool = DataResponse(data:res["status"]);
    }
    else{
      tempBool = DataResponse(errorCode: 0 );
    }

    tempBool.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "Something happened";
        default:
          return "something that I don't know happened!";
      }
    });

    return tempBool;
  }

  Future<DataResponse<JusoList>> getAddr(
  { required int currentPage, required int countPerPage, required String keyword}
  ) async
  {
    var res = await rep.getAddr({"currentPage": currentPage, "countPerPage": countPerPage, "keyword": keyword});
    DataResponse<JusoList> temp;
    try {
      if (res["results"] == null) {
        temp = DataResponse(errorCode: 0);
      }
      else if (res["results"]["common"]["errorMessage"] == "정상") {
        temp = DataResponse(data: JusoList.fromJson(res["results"]));
      }
      else {
        temp = DataResponse(errorCode: 1);
      }
    }
    catch(e)
    {
      print(e);
      temp = DataResponse(errorCode: 2);
    }
    temp.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "요청에 실패했습니다. 다시 시도해 주세요.";
        case 1:
          return "api의 호출 결과값이 에러입니다.";
        case 2:
          return "api 포맷이 틀립니다.";
      }
    }
    );

    return temp;
  }

  Future<DataResponse<bool>> phoneNumberVerificationRequest ({required String phoneNumb}) async
  {
    var res = await rep.phoneNumberVerificationRequest({"phoneNumb": phoneNumb});

    DataResponse<bool> tempBool;

    if(!res.isEmpty && res["status"] != null)
    {
      tempBool = DataResponse(data:res["status"]);
    }
    else{
      tempBool = DataResponse(errorCode: 0 );
    }

    tempBool.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "Something happened";
        default:
          return "something that I don't know happened!";
      }
    });

    return tempBool;

  }

  Future<DataResponse<bool>> phoneNumberVerificationCheck ({required String code, required String phoneNumb}) async
  {
    var res = await rep.phoneNumberVerificationCheck({"code": code, "phoneNumb": phoneNumb});

    DataResponse<bool> tempBool;

    if(!res.isEmpty && res["status"] != null)
    {
      tempBool = DataResponse(data:res["status"]);
    }
    else{
      tempBool = DataResponse(errorCode: 0 );
    }

    tempBool.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "Something happened";
        default:
          return "something that I don't know happened!";
      }
    });

    return tempBool;
  }

  Future<DataResponse<bool>> signUp({required Me me}) async
  {
    var res = await rep.signUp({"user": me.toJson()});

    DataResponse<bool> tempBool;

    if(!res.isEmpty && res["status"] != null)
    {
      tempBool = DataResponse(data:res["status"]);
    }
    else{
      tempBool = DataResponse(errorCode: 0 );
    }

    tempBool.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "Something happened";
        default:
          return "something that I don't know happened!";
      }
    });

    return tempBool;
  }

 // ---------------------------------------------------------------------------------------------------------------

  Future<bool> changePasswd(String userLoginId, String passwd) async
  {
    var res = await rep.changePass({"userLoginId" : userLoginId, "userPasswd" : passwd});

    return res["success"] == 1 ? true: false;
  }

  Future<int> getPoints(int userSysId) async
  {
    var res = await rep.getPoints({"userSysId" : userSysId});

    return res["earnedPoints"] ?? 0;

  }


  Future<List<TimeTable>> getTimeTables(int userSysId) async
  {
    List<TimeTable> retList = [];
    var res = await rep.getTimeTable({"userSysId": userSysId});
    Map<String ,dynamic> timeTables = res["timeTables"];
    for(Map<String, dynamic> timeTable in timeTables as List)
    {
      retList.add(TimeTable.fromJson(timeTable));
    }

    return retList;
  }

  Future<Course> addCourse(String? professor, String title, List<TimeSlot> timeSlots, bool requestedMatching,
      int userSysId, String semester, String schoolYear) async
  {
    var passMap = {
      "professor": professor,
      "title": title,
      "timeSlots": timeSlots.map((timeSlot) => timeSlot.toJson()).toList(),
      "requestedMatching": requestedMatching,
      "userSysId": userSysId,
      "semester": semester,
      "schoolYear": schoolYear
    };

    var res = await rep.addCourse(passMap);
    int courseId = res["courseId"] ?? -1;

    return Course(courseId: courseId, title:title,timeSlots: timeSlots,requestedMatch: requestedMatching,
    professor:  professor );
  }

  Future<Extracurricular> addExtracurricular(String title, List<TimeSlot> timeSlots, int userSysId,
      String semester, String schoolYear) async
  {
    var passMap = {
      "title": title,
      "timeSlots": timeSlots.map((timeSlot) => timeSlot.toJson()).toList(),
      "userSysId": userSysId,
      "semester" : semester,
      "schoolYear": schoolYear
    };

    var res = await rep.addExtraCurricular(passMap);
    int extraId = res["extraCurricularId"] ?? -1;

    return Extracurricular(extracurricularId: extraId, title: title, timeSlots: timeSlots);
  }

  Future<bool> deleteCourse(int courseId) async
  {
    var passMap = {
      "courseId": courseId
    };

    var res = await rep.deleteCourse(passMap);
    return res["sucess"] == 1? true: false;
  }

  Future<bool> deleteExtracurricular(int extracurricularId) async{
    var passMap = {
      "extraCurricularId": extracurricularId
    };

    var res = await rep.deleteExtraCurricular(passMap);
    return res["sucess"] == 1 ? true: false;
  }

  Future<Course?> changeCourse(Course aCourse, {required String title, String? professor,
  required bool requestedMatching, required List<TimeSlot> timeSlots}) async
  {
    aCourse.title = title;
    aCourse.professor = professor;
    aCourse.requestedMatching = requestedMatching;
    aCourse.timeSlots = timeSlots;

    var res = await rep.changeCourse(aCourse.toJson());

    if(res["success"] == 1)
      {
        return aCourse;
      }
    else
      return null;

  }

  Future<Extracurricular?> changeExtracurricular(Extracurricular aExtra, {required String title,
    required List<TimeSlot> timeSlots}) async
  {
    aExtra.title = title;
    aExtra.timeSlots = aExtra.timeSlots;

    var res = await rep.changeExtraCurricular(aExtra.toJson());

    if(res["success"] == 1)
      return aExtra;
    else
      return null;
  }

  Future<List<MatchedUser>> getMatchedUser(int userSysId) async
  {
    var passedMap = {
      "userSysId": userSysId
    };
    var res = await rep.getMatchedStudents(passedMap);

    List<MatchedUser> users = res["users"].map((user) => MatchedUser.fromJson(user)).toList();

    return users;
  }

  Future<List<StudyRoom>> getStudyRooms(int userSysId) async
  {
    var passMap = {
      "userSysId": userSysId
    };

    var res = await rep.getStudies(passMap);

    List<StudyRoom> retList = res["studyRooms"].map((study) => StudyRoom.fromJson(study)).toList();

    return retList;
  }

  Future<bool> createStudy(String title, int userSysId ) async
  {
    var passMap = {
      "userSysId": userSysId,
      "title": title
    };

    var res = await rep.createStudyRoom(passMap);

    if(res["success"] == 0)
      return false;
    else
      return true;
  }

  Future<bool> sendInvitation(int inviter, int invited, int studyRoomId) async
  {
    var passMap = {
      "inviter": inviter,
      "invited": invited,
      "studyRoomId": studyRoomId
    };

    var res = await rep.createStudyRoom(passMap);

    if(res["success"] == 0)
      return false;
    else
      return true;

  }

  Future<bool> acceptInvitation(int inviter, int invited, int studyRoomId) async
  {
    var passMap = {
      "inviter" : inviter,
      "invited": invited,
      "studyRoomId": studyRoomId
    };

    var res = await rep.acceptInvitation(passMap);

    if(res["success"] == 0)
      return false;
    else
      return true;
  }

  Future<bool> rejectInvitation(int inviter, int invited, int studyRoomId) async
  {
    var passMap = {
      "inviter" : inviter,
      "invited": invited,
      "studyRoomId": studyRoomId
    };

    var res = await rep.rejectInvitation(passMap);

    if(res["success"] == 0)
      return false;
    else
      return true;
  }

  Future<List<User>> searchStudents(String userName) async
  {
    var passMap = {
      "userName": userName
    };

    var res = await rep.searchStudents(passMap);

    List<User> users = res["users"].map((user) => User.fromJson(user));

    return users;
  }

  Future<List<Invited>> getInvited(int userSysId) async
  {
    var passMap = {
      "userSysId": userSysId
    };

    var res = await rep.getInvited(passMap);

    List<Invited> invites = res["invited"].map((invited) => Invited.fromJson(invited));

    return invites;
  }

  Future<List<Inviting>> getInviting(int userSysId) async
  {
    var passMap = {
      "userSysId": userSysId
    };

    var res = await rep.getInviting(passMap);

    List<Inviting> invitings = res["inviting"].map((inviting) => Inviting.fromJson(inviting));

    return invitings;
  }

  Future<bool> startMeeting(int studyRoomId, int userSysId, String xCoord, String yCoord) async
  {
    Map<String, dynamic > passMap = {
      "userSysId": userSysId,
      "studyRoomId":studyRoomId,
      "xCoord" :xCoord,
      "yCoord" :yCoord
    };

    var res = await rep.startMeeting(passMap);

    if(res["success"] == 0)
      return false;
    else
      return true;
  }

  Future<bool> joinMeeting(int studyRoomId, int userSysId, String xCoord, String yCoord) async
  {
    Map<String, dynamic > passMap = {
      "userSysId": userSysId,
      "studyRoomId":studyRoomId,
      "xCoord" :xCoord,
      "yCoord" :yCoord
    };

    var res = await rep.joinMeeting(passMap);

    if(res["success"] == 0)
      return false;
    else
      return true;
  }

  Future<List<Meeting>> getTotalMeetings(int studyRoomId) async
  {
    Map<String, dynamic > passMap = {
      "studyRoomId":studyRoomId

    };

    var res = await rep.getMeetingTotalNumb(passMap);

    return res["meetings"].map((meeting) => Meeting.fromJson(meeting)).toList();

  }

  Future<List<Chat>> checkNewMsg({required int studyRoomId, required int chatId}) async
  {
    Map<String, dynamic > passMap = {
      "studyRoomId":studyRoomId,
      "chatId": chatId
    };

    var res = await rep.checkNewMsg(passMap);

    return res["chats"].map((chat) => Chat.fromJson(chat)).toList();
  }

  Future<Stream<Chat>> getChatStream({required int userSysId}) async
  {
    Map<String, dynamic > passMap = {
      "userSysId": userSysId
    };

    Stream<dynamic> chatStream = await rep.getChatStream(passMap);
    StreamTransformer<dynamic, Chat> transformer = StreamTransformer<dynamic, Chat>.fromHandlers(
      handleData: (dynamic value,Sink<Chat> sink )
          {
            sink.add(Chat.fromJson(json.decode(value as String)));
          },
        handleError: (error, trace, sink)
          {
            print(error);
            print(trace);
          },
      handleDone:(sink)
      {
        sink.close();
      }
    );

    return chatStream.transform(transformer);
  }

  Future<Stream<Meeting>> getMeetingStream (int userSysId) async
  {
  Map<String, dynamic > passMap = {
    "userSysId": userSysId
  };

  Stream<dynamic> meetingStream = await rep.getMeetingStream(passMap);
  StreamTransformer<dynamic, Meeting> transformer = StreamTransformer<dynamic, Meeting>.fromHandlers(
      handleData: (dynamic value,Sink<Meeting> sink )
      {
        sink.add(Meeting.fromJson(json.decode(value as String)));
      },
      handleError: (error, trace, sink)
      {
        print(error);
        print(trace);
      },
      handleDone:(sink)
      {
        sink.close();
      }
  );

  return meetingStream.transform(transformer);
  }

  Future<bool> uploadChat(Chat chat, String? picturePath) async
  {
    var passMap = chat.toJson();
    passMap["path"]  = picturePath;

    var res = await rep.uploadChat(passMap);

    return res["success"] == 1 ? true : false;
  }

}