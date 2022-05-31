
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

  String? token = null;

  factory Service()
  {
    return _serve;
  }

  Service._privService(){
    rep = TotalRepository();
  }
  
  Future<DataResponse<bool>> log_in({required String email , required String password}) async
  {
    Map<String ,dynamic> request = {
      "email": email,
      "pswd": password
    };
    
    Map<String, dynamic> response = await rep.log_in(request);
    
    late DataResponse<bool> data;
    
    int status = int.tryParse(response["status"].toString()) ?? 1;

    token = response["token"];


    if(status == 0 && token != null)
    {
        rep.recordCredentials(token: token!, email: email, password: password);
        data = DataResponse<bool>(data: true, errorCode: status);
    }
    else{
      data = DataResponse<bool>(data:false, errorCode: status);
    }
    
    data.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "로그인이 성공하였습니다.";
        default:
          return "로그인을 실패했습니다.";
      }
    });

    return data;
  }

  Future<DataResponse<bool>> send_code_signup({required String email}) async
  {

    Map<String, dynamic> response = await rep.send_code_signup(email);

    late DataResponse<bool> data;

    int status = int.tryParse(response["status"]?.toString()??"1") ?? 1;
    if(status == 0)
    {
      data = DataResponse<bool>(data: true, errorCode: status);
    }
    else{
      data = DataResponse<bool>(data:false, errorCode: status);
    }

    data.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "이메일 전송 성공!";
        default:
          return "이메일 전송 실패!";
      }
    });

    return data;
  }

  Future<DataResponse<bool>> verify_code_signup({required String email, required String code}) async
  {

    Map<String,dynamic > request = {
      "email": email,
      "code": code
    };

    Map<String, dynamic> response = await rep.verify_code_signup(request);

    late DataResponse<bool> data;

    int status = int.tryParse(response["status"]?.toString()??"1") ?? 1;
    if(status == 0)
    {
      data = DataResponse<bool>(data: true, errorCode: status);
    }
    else{
      data = DataResponse<bool>(data:false, errorCode: status);
    }

    data.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "인증 성공";
        case 1:
          return "해당 이메일에 코드를 전송하지 않았습니다.";
        default:
          return "코드가 틀립니다.";
      }
    });

    return data;
  }

  Future<DataResponse<bool>> check_duplicate_nickname({required String nickname}) async
  {

    Map<String, dynamic> response = await rep.check_duplicate_nickname(nickname);

    late DataResponse<bool> data;

    int status = int.tryParse(response["status"]?.toString()??"1") ?? 1;
    if(status == 0)
    {
      data = DataResponse<bool>(data: true, errorCode: status);
    }
    else{
      data = DataResponse<bool>(data:false, errorCode: status);
    }

    data.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "닉네임 사용가능";
        default:
          return "닉네임 사용불가능";
      }
    });

    return data;
  }

  Future<DataResponse<bool>> sign_up({required String name,required String email,
    required String code, required String pswd, required nickname}) async {
    Map<String, dynamic> request = {
      "name": name,
      "email": email,
      "code": code,
      "pswd": pswd,
      "nickname": nickname
    };

    Map<String, dynamic> response = await rep.signup(request);

    int status = int.tryParse((response["status" ] ?? "1").toString()) ?? 1;

    print("resulting status: " + status.toString());

    late DataResponse<bool> ret;
    if(status == 0)
    {
        ret = DataResponse(data: true, errorCode: status);
    }
    else
    {
      ret = DataResponse(data: false, errorCode: status);
    }


    ret.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "회원가입 성공!";
        default:
          return "회원가입 실패!";
      }
    });

    return ret;
  }

  Future<DataResponse<List<Article>>> getRecommendedArticles() async
  {

    if(token == null)
    {
        token = await getNewCredential();
        if(token == null)
        {
          return DataResponse(errorCode: -1);
        }
    }

    Map<String, dynamic> response = await rep.getRecommendedArticles(token!);

    //unauthorize일시 다시!
    if(response[TotalRepository.statusCode] == 401)
    {
      token = await getNewCredential();
      if(token == null)
        {
          return DataResponse(errorCode: -1);
        }

      response = await rep.getRecommendedArticles(token!);
    }

    int status = int.tryParse((response["status" ] ?? "-1").toString()) ?? -1;

    print("resulting status: " + status.toString());

    late DataResponse<List<Article>> ret;
    if(status == 0)
    {
      List<Article> articles = [];
      List<dynamic> jsonList = response["articles"]  ?? [];

      for(dynamic t in jsonList)
      {
        articles.add(Article.fromJson(t as Map<String, dynamic>));
      }

      return DataResponse(data: articles, errorCode:status);
    }
    else
    {
      ret = DataResponse( errorCode: status);
    }


    ret.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case -1:
          return "다시 로그인 하세요!";
        case 0:
          return "기사 추천 성공";
        default:
          return "기사 추천 실패";
      }
    });

    return ret;
  }

  Future<DataResponse<List<Article>>> searchArticles({required String keyword}) async
  {

    if(token == null)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }
    }

    Map<String, dynamic> response = await rep.searchArticles(token: token!, keyword: keyword);

    //unauthorize일시 다시!
    if(response[TotalRepository.statusCode] == 401)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }

      response = await rep.searchArticles(token: token!, keyword: keyword);
    }

    int status = int.tryParse((response["status" ] ?? "-1").toString()) ?? -1;

    print("resulting status: " + status.toString());

    late DataResponse<List<Article>> ret;
    if(status == 0)
    {
      List<Article> articles = [];
      List<dynamic> jsonList = response["articles"]  ?? [];

      for(dynamic t in jsonList)
      {
        articles.add(Article.fromJson(t as Map<String, dynamic>));
      }

      return DataResponse(data: articles, errorCode:status);
    }
    else
    {
      ret = DataResponse( errorCode: status);
    }


    ret.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case -1:
          return "다시 로그인 하세요!";
        case 0:
          return "기사 추천 성공";
        default:
          return "기사 추천 실패";
      }
    });

    return ret;
  }

  Future<DataResponse<bool>> readArticles({required String title, required int fetchTime }) async
  {

    if(token == null)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }
    }

    Map<String, dynamic> response = await rep.readArticle(token: token!, title: title, fetchTime: fetchTime);

    //unauthorize일시 다시!
    if(response[TotalRepository.statusCode] == 401)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }

      response = await rep.readArticle(token: token!, title: title, fetchTime: fetchTime);
    }

    int status = int.tryParse((response["status" ] ?? "-1").toString()) ?? -1;

    print("resulting status: " + status.toString());

    late DataResponse<bool> ret;
    if(status == 0)
    {


      return DataResponse(data: true, errorCode:status);
    }
    else
    {
      ret = DataResponse(data: false, errorCode: status);
    }


    ret.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case -1:
          return "다시 로그인 하세요!";
        case 0:
          return "기사 검색 성공";
        default:
          return "기사 검색 실패";
      }
    });

    return ret;
  }

  Future<DataResponse<List<Visit>>> recommendVisit() async
  {

    if(token == null)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }
    }

    Map<String, dynamic> response = await rep.recommendVisits(token: token!);

    //unauthorize일시 다시!
    if(response[TotalRepository.statusCode] == 401)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }

      response = await rep.recommendVisits(token: token!);
    }

    int status = int.tryParse((response["status" ] ?? "-1").toString()) ?? -1;

    print("resulting status: " + status.toString());

    late DataResponse<List<Visit>> ret;
    if(status == 0)
    {
      List<Visit> visits = [];
      List<dynamic> jsonList = response["visits"]  ?? [];

      for(dynamic t in jsonList)
      {
        visits.add(Visit.fromJson(t as Map<String, dynamic>));
      }

      print("visits:");
      print(visits);

      return DataResponse(data: visits, errorCode:status);
    }
    else
    {
      ret = DataResponse( errorCode: status);
    }


    ret.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case -1:
          return "다시 로그인 하세요!";
        case 0:
          return "방문기 추천 성공";
        default:
          return "방문기 추천 실패";
      }
    });

    return ret;
  }

  Future<DataResponse<bool>> likeVisit({required String title, required String writer}) async
  {

    if(token == null)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }
    }

    Map<String, dynamic> response = await rep.likeVisit(token: token!,
      title: title, writer: writer);

    //unauthorize일시 다시!
    if(response[TotalRepository.statusCode] == 401)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }

      response = await rep.likeVisit(token: token!,
          title: title, writer: writer);
    }

    int status = int.tryParse((response["status" ] ?? "-1").toString()) ?? -1;

    print("resulting status: " + status.toString());

    late DataResponse<bool> ret;
    if(status == 0)
    {

      return DataResponse(data: true, errorCode:status);
    }
    else
    {
      ret = DataResponse( data: false, errorCode: status);
    }


    ret.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case -1:
          return "다시 로그인 하세요!";
        case 0:
          return "방문기 좋아요 성공";
        default:
          return "방문기 좋아요 실패";
      }
    });

    return ret;
  }

  Future<DataResponse<bool>> unlikeVisit({required String title, required String writer}) async
  {

    if(token == null)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }
    }

    Map<String, dynamic> response = await rep.unlikeVisit(token: token!,
        title: title, writer: writer);

    //unauthorize일시 다시!
    if(response[TotalRepository.statusCode] == 401)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }

      response = await rep.unlikeVisit(token: token!,
          title: title, writer: writer);
    }

    int status = int.tryParse((response["status" ] ?? "-1").toString()) ?? -1;

    print("resulting status: " + status.toString());

    late DataResponse<bool> ret;
    if(status == 0)
    {

      return DataResponse(data: true, errorCode:status);
    }
    else
    {
      ret = DataResponse( data: false, errorCode: status);
    }


    ret.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case -1:
          return "다시 로그인 하세요!";
        case 0:
          return "방문기 싫어요 성공";
        default:
          return "방문기 싫어요 실패";
      }
    });

    return ret;
  }

  Future<DataResponse<List<Visit>>> searchVisit({required String keyword}) async
  {

    if(token == null)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }
    }

    Map<String, dynamic> response = await rep.searchVisit(token: token!, keyword: keyword);

    //unauthorize일시 다시!
    if(response[TotalRepository.statusCode] == 401)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }

      response = await rep.searchVisit(token: token!, keyword: keyword);
    }

    int status = int.tryParse((response["status" ] ?? "-1").toString()) ?? -1;

    print("resulting status: " + status.toString());

    late DataResponse<List<Visit>> ret;
    if(status == 0)
    {
      List<Visit> visits = [];
      List<dynamic> jsonList = response["visits"]  ?? [];

      for(dynamic t in jsonList)
      {
        visits.add(Visit.fromJson(t as Map<String, dynamic>));
      }

      return DataResponse(data: visits, errorCode:status);
    }
    else
    {
      ret = DataResponse( errorCode: status);
    }


    ret.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case -1:
          return "다시 로그인 하세요!";
        case 0:
          return "방문기 검색 성공";
        default:
          return "방문기 검색 실패";
      }
    });

    return ret;
  }

  Future<String?> getNewCredential() async
  {
    Map<String, String?> credential = await rep.getLogInPassword();
    String? email = credential[TotalRepository.logInKey];
    String? pswd = credential[TotalRepository.passwdKey];

    if(email == null || pswd == null)
    {
      return null;
    }

    await log_in(email: email, password: pswd);

    return token;

  }
}