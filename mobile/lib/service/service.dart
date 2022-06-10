
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:hackerton_project/model/export_file.dart';
import 'package:hackerton_project/model/real_estat_data.dart';
import 'package:hackerton_project/repository/total_repo.dart';
import 'package:intl/intl.dart';

class Service
{
  static const statusCode = "statusCode";

  TotalRepository rep = TotalRepository();

  static final _serve = Service._privService();

  String? token = null;
  Map<String, dynamic>? codeJson = null;

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

  Future<DataResponse<bool>> send_code_ps({required String email}) async
  {

    Map<String, dynamic> response = await rep.send_code_findps(email: email);

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
        case 1:
          return "해당 이메일은 가입되지 않음";
        case 2:
          return "해당 이메일에 보내기 실패";
        default:
          return "이메일 전송 실패!";
      }
    });

    return data;
  }

  Future<DataResponse<bool>> verify_code_ps({required String email, required String code}) async
  {

    Map<String, String> request = {
      "email": email,
      "code": code
    };

    Map<String, dynamic> response = await rep.verify_code_findps(requestBody: request);

    late DataResponse<bool> data;

    int status = int.tryParse(response["status"]?.toString()??"-1") ?? -1;
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
          return "";
        case 1:
          return "해당 이메일에 코드를 보내지 않음";
        case 2:
          return "코드가 틀립니다.";
        default:
          return "에러가 발생했습니다. 다시 시도해 주세요.";
      }
    });

    return data;
  }

  Future<DataResponse<bool>> create_new_ps({required String email, required String code, required String password}) async
  {

    Map<String, String> request = {
      "email": email,
      "code": code,
      "password": password
    };

    Map<String, dynamic> response = await rep.create_new_ps(requestBody: request);

    late DataResponse<bool> data;

    int status = int.tryParse(response["status"]?.toString()??"-1") ?? -1;
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
          return "성공";
        case 1:
          return "해당 이메일에 코드인증이 안됐습니다. 다시 인증을 해주세요.";
        case 2:
          return "인증을 한지 시간이 너무 오래 지났습니다. 다시 인증을 해주세요.";
        case 3:
          return "코드가 틀립니다.";
        default:
          return "에러가 발생했습니다. 다시 시도해 주세요.";
      }
    });

    return data;
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
    if(response[TotalRepository.statusCode] == 403)
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
        Article temp = Article.fromJson(t as Map<String, dynamic>);
        if(temp.isValid()) {
          articles.add(temp);
        }
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

  Future<DataResponse<List<Article>>> getRecentViewArticles() async
  {

    if(token == null)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }
    }

    Map<String, dynamic> response = await rep.getRecentViewArticles(token: token!);

    //unauthorize일시 다시!
    if(response[TotalRepository.statusCode] == 403)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }

      response = await rep.getRecentViewArticles(token: token!);
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
        Article temp = Article.fromJson(t as Map<String, dynamic>);
        if(temp.isValid()) {
          articles.add(temp);
        }
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
    if(response[TotalRepository.statusCode] == 403)
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
        Article temp = Article.fromJson(t as Map<String, dynamic>);
        if(temp.isValid()) {
          articles.add(temp);
        }
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
    if(response[TotalRepository.statusCode] == 403)
    {
      print("the resulting status is 403");
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

  Future<DataResponse<UserInfo>> getUserInfo() async{
    if(token == null)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }
    }

    Map<String, dynamic> response = await rep.getUserInfo(token: token!);

    //unauthorize일시 다시!
    if(response[TotalRepository.statusCode] == 403 || response == {})
    {
      print("getting new credentials");
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }

      response = await rep.getUserInfo(token: token!);
    }

    int status = int.tryParse((response["status" ] ?? "-1").toString()) ?? -1;

    print("resulting status: " + status.toString());

    late DataResponse<UserInfo> ret;
    if(status == 0)
    {
      String nickname = response["nickname"] ?? "";
      String email = response["email"] ?? "";

      UserInfo userInfo = UserInfo(nickname: nickname, email: email);

      ret = DataResponse(data: userInfo, errorCode: status);
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
          return "유저정보 조회 성공";
        default:
          return "유저정보 조회 실패";
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
    if(response[TotalRepository.statusCode] == 403)
    {
      print("getting new credentials");
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

  Future<DataResponse<List<Visit>>> getLikedVisit() async
  {

    if(token == null)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }
    }

    Map<String, dynamic> response = await rep.getLikedVisits(token: token!);

    //unauthorize일시 다시!
    if(response[TotalRepository.statusCode] == 403)
    {
      print("getting new credentials");
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }

      response = await rep.getLikedVisits(token: token!);
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
          return "좋아요한 방문기 추천 성공";
        default:
          return "좋아요한 방문기 추천 실패";
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
    if(response[TotalRepository.statusCode] == 403)
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
    if(response[TotalRepository.statusCode] == 403)
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
    if(response[TotalRepository.statusCode] == 403)
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

  Future<DataResponse<VisitDetail>> getVisitDetail({required String writer, required String title}) async
  {

    if(token == null)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }
    }

    Map<String, dynamic> response = await rep.getDetailVisit(token: token!, writer: writer, title: title);

    //unauthorize일시 다시!
    if(response[TotalRepository.statusCode] == 403)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }

      response = await rep.getDetailVisit(token: token!, writer: writer, title: title);
    }

    int status = int.tryParse((response["status" ] ?? "-1").toString()) ?? -1;

    print("resulting status: " + status.toString());

    late DataResponse<VisitDetail> ret;
    if(status == 0)
    {
      VisitDetail data = VisitDetail.fromJson(response["visit"]  ?? {});

      return DataResponse(data: data, errorCode:status);
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
          return "방문기 상세조회 성공";
        default:
          return "방문기 상세조회 실패";
      }
    });

    return ret;
  }

  Future<DataResponse<VisitDetail>> addVisit({
    required String title, required List<String> tags, required String address,
    required String detailAddress, required Content content}) async
  {

    List<Map<String,dynamic>> contentToJson = content.toJson();
    List<String> paths = [];
    for(ContentComponent contentComponent in content.getContents())
      {
        if(contentComponent.isImage())
          {
            if((contentComponent as ImageContent).getPath() != "")
              {
                paths.add((contentComponent as ImageContent).getPath());
              }
          }
      }

    if(token == null)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }
    }

    Map<String, dynamic> response = await rep.addVisit(token: token!, title: title,
      tags:  tags, content: contentToJson, imagePaths: paths, address:  address, detailAddress:  detailAddress);

    //unauthorize일시 다시!
    if(response[TotalRepository.statusCode] == 403)
    {
      token = await getNewCredential();
      if(token == null)
      {
        return DataResponse(errorCode: -1);
      }

      response = await rep.addVisit(token: token!,  title: title,
          tags:  tags, content: contentToJson, imagePaths: paths, address:  address, detailAddress:  detailAddress);
    }

    int status = int.tryParse((response["status" ] ?? "-1").toString()) ?? -1;

    print("resulting status: " + status.toString());

    late DataResponse<VisitDetail> ret;
    if(status == 0)
    {
      VisitDetail data = VisitDetail.fromJson(response["visit"]  ?? {});

      return DataResponse(data: data, errorCode:status);
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
          return "방문기 생성 성공";
        default:
          return "방문기 생성 실패";
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

  Future<DataResponse<JusoList>> getAddr(
      { required int currentPage, required int countPerPage, required String keyword}
      ) async
  {
    var res = await rep.getAddr({"currentPage": currentPage, "countPerPage": countPerPage, "keyword": keyword});
    DataResponse<JusoList> temp;
    try {;
    if (res["results"] == null) {
      temp = DataResponse(errorCode: 0);
    }
    else if (res["results"]["common"]["errorMessage"] == "정상") {
      print(res.toString());
      temp = DataResponse(data: JusoList.fromJson(res["results"]));
    }
    else {
      print(res.toString());
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
          return res["results"]["common"]["errorMessage"] ?? "다른 키워드를 사용하거나 나중에 다시 시도 해주세요.";
        case 2:
          return "api 포맷이 틀립니다.";
      }
    }
    );

    return temp;
  }

  Future<DataResponse<List<RealEstateData>>> getData(
      {  required String generalAddress, required String detailAddress}
      ) async
  {

    if(codeJson == null)
      {
        final String response = await rootBundle.loadString('assets/region_code.json');
        codeJson = await json.decode(response);

      }

    late String code;
    try {
      code = codeJson![generalAddress]["code"] +
          codeJson![generalAddress][detailAddress];
    }
    catch(e)
    {
      print("could not find code for addresses below:");
      print(generalAddress + " " + detailAddress);
      print(e);
      return DataResponse(errorCode: -1);
    }


    Map<String,String> requestParams = {
      "page": "1",
      "perPage":"10",
      "cond[REGION_CD::EQ]":code,
      "cond[RESEARCH_DATE::LTE]": getLessThanDate(),
      "cond[RESEARCH_DATE::GTE]":getGtThanDate(),
      "cond[APT_TYPE::EQ]": "1",
      "cond[TR_GBN::EQ]": "S",
      "cond[PRICE_GBN::EQ]":"AU"
    };

    var res = await rep.getRealEstateData(requestParams);

    print("response:");
    print(res);


    late DataResponse<List<RealEstateData>> temp;
    try {;
        List<RealEstateData> aList = [];

        for(dynamic t in res["data"]?? [])
        {
          aList.add(RealEstateData.fromJson(t as Map<String, dynamic>));
        }

        aList.sort((d1, d2){
          return d1.isGreater(d2);
        });

        aList = aList.sublist(aList.length - 4, aList.length);
        print("sortedList:");
        print(aList);

        temp = DataResponse(data: aList, errorCode:  0);
    }
    catch(e)
    {
      print(e);
      temp = DataResponse(errorCode: 2);
    }

    temp.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "요청 성공";
        case -1:
          return  "json 파일 읽기 실패";
        default:
          return "api 에러";
      }
    }
    );

    return temp;
  }

  Future<DataResponse<List<RealEstateData>>> getJeonSaeData(
      {  required String generalAddress, required String detailAddress}
      ) async
  {

    if(codeJson == null)
    {
      final String response = await rootBundle.loadString('assets/region_code.json');
      codeJson = await json.decode(response);

    }

    late String code;
    try {
      code = codeJson![generalAddress]["code"] +
          codeJson![generalAddress][detailAddress];
    }
    catch(e)
    {
      print("could not find code for addresses below:");
      print(generalAddress + " " + detailAddress);
      print(e);
      return DataResponse(errorCode: -1);
    }


    Map<String,String> requestParams = {
      "page": "1",
      "perPage":"10",
      "cond[REGION_CD::EQ]":code,
      "cond[RESEARCH_DATE::LTE]": getLessThanDate(),
      "cond[RESEARCH_DATE::GTE]":getGtThanDate(),
      "cond[APT_TYPE::EQ]": "1",
      "cond[TR_GBN::EQ]": "D",
      "cond[PRICE_GBN::EQ]":"AU"
    };

    var res = await rep.getRealEstateData(requestParams);

    print("response:");
    print(res);


    late DataResponse<List<RealEstateData>> temp;
    try {;
    List<RealEstateData> aList = [];

    for(dynamic t in res["data"]?? [])
    {
      aList.add(RealEstateData.fromJson(t as Map<String, dynamic>));
    }

    aList.sort((d1, d2){
      return d1.isGreater(d2);
    });

    aList = aList.sublist(aList.length - 4, aList.length);
    print("sortedList:");
    print(aList);

    temp = DataResponse(data: aList, errorCode:  0);
    }
    catch(e)
    {
      print(e);
      temp = DataResponse(errorCode: 2);
    }

    temp.setErrorMsgCode(errorMsgCode: (int errorCode){
      switch(errorCode){
        case 0:
          return "요청 성공";
        case -1:
          return  "json 파일 읽기 실패";
        default:
          return "api 에러";
      }
    }
    );

    return temp;
  }

  String getLessThanDate()
  {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    String retString = formattedDate.substring(0,4) + formattedDate.substring(5,7);

    print("getLessThanDate:" + retString);

    return retString;

  }

  String getGtThanDate()
  {
    var now = new DateTime.now();
    DateTime prev = now.subtract(Duration(days: 180));
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(prev);
    String retString = formattedDate.substring(0,4) + formattedDate.substring(5,7);

    print("getGtThanDate:" + retString);

    return retString;

  }

  Future<DataResponse<List<String>>> getGeneralAddressList() async
  {
    if(codeJson == null)
    {
      try {
        final String response = await rootBundle.loadString(
            'assets/region_code.json');
        codeJson = await json.decode(response);
      }
      catch(e){
        print(e);
        return DataResponse(errorCode: 1);
      }
    }

    return DataResponse(data: codeJson!.keys.toList());


  }

  Future<DataResponse<List<String>>> getDetailAddressList(String generalAddress) async
  {
    if(codeJson == null)
    {
      try {
        final String response = await rootBundle.loadString(
            'assets/region_code.json');
        codeJson = await json.decode(response);
      }
      catch(e){
        print(e);
        return DataResponse(errorCode: 1);
      }
    }
    List<String> ret = codeJson![generalAddress].keys.toList();
    ret.remove("code");
    print(ret);
    return DataResponse(data: ret);


  }

}