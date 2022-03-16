import 'dart:async';

abstract class Repository
{
  Future<Map<String, dynamic>?> logIn (Map<String, dynamic> logInInfo);

  Future<Map<String, dynamic>> singUp (Map<String, dynamic> logInInfo);

  Future<Map<String, dynamic>> changePersonalInfo(Map<String, dynamic> personalInfo);
  Future<Map<String, dynamic>> uploadProfilePicture(Map<String,dynamic> personalInfo);

  Future<Map<String, dynamic>> snsVerification (Map<String, dynamic> phoneNumb);
  Future<Map<String, dynamic>> findId (Map<String, dynamic> infoForFindingId);         //문자로 아이디 보내기
  Future<Map<String, dynamic>> findPass (Map<String, dynamic> infoForFindingPasswd);   //문자로 인증후 비번 새로 변경하기!
  Future<Map<String, dynamic>> changePass(Map<String, dynamic> passInfo);
  Future<Map<String, dynamic>> getPoints(Map<String, dynamic> userInfo);

  Future<Map<String, dynamic>> checkDuplicateId (Map<String, dynamic> id);
  Future<Map<String, dynamic>> getTimeTable (Map<String, dynamic> studentInfo);
  Future<Map<String, dynamic>> addCourse (Map<String, dynamic> course);
  Future<Map<String, dynamic>> addExtraCurricular (Map<String, dynamic> extraCurricular);
  Future<Map<String, dynamic>> deleteCourse (Map<String, dynamic> courseInfo);
  Future<Map<String, dynamic>> deleteExtraCurricular (Map<String, dynamic> extraCurricularInfo);
  Future<Map<String, dynamic>> changeCourse (Map<String, dynamic> courseInfo);
  Future<Map<String, dynamic>> changeExtraCurricular (Map<String, dynamic> extraCurricularInfo);
  Future<Map<String, dynamic>> getMatchedStudents(Map<String, dynamic> studentInfo);
  Future<Map<String, dynamic>> getStudies (Map<String, dynamic> studentInfo);
  Future<Map<String, dynamic>> createStudyRoom(Map<String, dynamic> userInfo);
  Future<Map<String, dynamic>> sendInvitation(Map<String, dynamic> userInfo);
  Future<Map<String, dynamic>> acceptInvitation(Map<String, dynamic> studyInfo);
  Future<Map<String, dynamic>> rejectInvitation(Map<String, dynamic> studyInfo);
  Future<Map<String, dynamic>> searchStudents(Map<String, dynamic> searchInfo);
  Future<Map<String, dynamic>> getInvited(Map<String, dynamic> getInvitedInfo);
  Future<Map<String, dynamic>> getInviting(Map<String, dynamic> getInvitingInfo);

  Future<Map<String, dynamic>> startMeeting (Map<String, dynamic> meetInfo);                  //same stream as joinMeeting and getMeetingStream
  Future<Map<String, dynamic>> joinMeeting (Map<String,dynamic> meetInfo);
  Future<Map<String, dynamic>> getMeetingTotalNumb (Map<String, dynamic> meetInfo);
  Stream getMeetingStream(Map<String, dynamic> userInfoAndStudyRoomInfo);


  Stream getChatStream(Map<String, dynamic> userInfoAndStudyRoomInfo);               //get new chat using this stream
  Future<Map<String, dynamic>> checkNewMsg(Map<String, dynamic> lastChatInfo);
  Future<Map<String, dynamic>> uploadChat (Map<String, dynamic> chatInfo);

  Future<Map<String, dynamic>> getChatsForAStudyRoom(Map<String, dynamic> studyRoomInfo);


}
