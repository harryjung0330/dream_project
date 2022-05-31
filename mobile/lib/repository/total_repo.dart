import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class TotalRepository{
  String? userSysId;

  static const AUTHORITY = "https://5ni1uif3uc.execute-api.ap-northeast-2.amazonaws.com/test";
  static const LOG_IN_PATH = "/user/login";
  static const SEND_CODE_SIGNUP_PATH = "/user/email/sendcode";
  static const VERIFY_CODE_SIGNUP_PATH = "/user/email/verifycode";
  static const CHECK_DUPLICATE_NICKNAME_PATH = "/user/nickname/checkduplicate";
  static const SIGNUP_PATH = "/user";
  static const RECOMMEND_ARTICLE_PATH = "/articles/recommendation";
  static const SEARCH_ARTICLE_PATH = '/articles/search';
  static const RECOMMEND_VISIT_PATH = "/visits/recommendation";
  static const SEARCH_VISIT_PATH = "/visits/search";



  static const statusCode = "statusCode";

  final FlutterSecureStorage storage = FlutterSecureStorage();
  static const logInKey = "logIn";
  static const passwdKey = "passwd";
  static const tokenKey = "token";

  static final TotalRepository _totalRepository = TotalRepository._privTotalRepository();




  factory TotalRepository()
  {
    return _totalRepository;
  }

  TotalRepository._privTotalRepository()
  {

  }


  Future<void> recordCredentials({required String token, required String email, required String password }) async
  {
    try
    {
      print("recording: token: " + token + " email: " + email + " password: " + password);

      await storage.write(key: tokenKey, value: token);
      await storage.write(key: logInKey, value: email);
      await storage.write(key: passwdKey, value: password);

      print("recording credentials success!");
    }
    catch(e)
    {
      print("error occurred while recoding credentials");
      print(e);
    }
    print("recording credentials done!");


  }


  Future<Map<String, String?>> getLogInPassword() async
  {
    Map<String, String?> retMap = {};
    try
    {
      print("getting login and password:");
      retMap[logInKey] = await storage.read(key: logInKey);
      retMap[passwdKey] = await storage.read(key: passwdKey);

      print("reading credentials result:");
      print(retMap);

    }
    catch(e)
    {
      print("error occurred while reading credentials");
      print(e);
    }
    return retMap;
  }

  Future<String?> getToken() async
  {
    String? ret;
    try
    {
      print("getting login and password:");
      ret = await storage.read(key:tokenKey);

      print("reading token result:");
      print(ret);

    }
    catch(e)
    {
      print("error occurred while reading token");
      print(e);
    }
    return ret;
  }

  Future<Map<String, dynamic>> log_in(Map<String, dynamic> log_in_info) async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json"
    };

    try {
      Uri url = Uri.parse(AUTHORITY + LOG_IN_PATH);
      result = await http.post(
          url, body: json.encode(log_in_info), headers: header);

      print("login:");
      print(result.body);

      if(result.statusCode == 200){
        Map<String, dynamic> res = json.decode(result.body);
        res[statusCode] = result.statusCode;
        return res;
      }
      else{
        return {};
      }
    }
    catch(e)
    {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> send_code_signup(String email) async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json"
    };

    print("sending code to " + email);

    try {
      Uri url = Uri.parse(AUTHORITY + SEND_CODE_SIGNUP_PATH + "/" + email);
      print("url" + url.toString());
      result = await http.post(
          url,  headers: header);

      print("send code signup:");
      print(result.body);

      if(result.statusCode == 200){
        Map<String, dynamic> res = json.decode(result.body);
        res[statusCode] = result.statusCode;
        return res;
      }
      else{
        return {};
      }
    }
    catch(e)
    {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> verify_code_signup(Map<String, dynamic> requestBody) async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json"
    };

    print("verifying code request body:");
    print(requestBody.toString());

    try {
      Uri url = Uri.parse(AUTHORITY + VERIFY_CODE_SIGNUP_PATH);
      print("url" + url.toString());
      result = await http.post(
          url,  body: json.encode(requestBody), headers: header);

      print("verify code signup:");
      print(result.body);

      if(result.statusCode == 200){
        Map<String, dynamic> res = json.decode(result.body);
        res[statusCode] = result.statusCode;
        return res;
      }
      else{
        return {};
      }
    }
    catch(e)
    {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> check_duplicate_nickname(String nickname) async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json"
    };

    print("checking duplicate nickname: " + nickname);

    try {
      Uri url = Uri.parse(AUTHORITY + CHECK_DUPLICATE_NICKNAME_PATH + "/" + nickname);
      print("url: " + url.toString());
      result = await http.get(
          url,  headers: header);

      print("send code signup:");
      print(result.body);

      if(result.statusCode == 200){
        Map<String, dynamic> res = json.decode(result.body);
        res[statusCode] = result.statusCode;
        return res;
      }
      else{
        return {};
      }
    }
    catch(e)
    {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> signup(Map<String, dynamic> requestBody) async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json"
    };

    print("signing up body:");
    print(requestBody.toString());

    try {
      Uri url = Uri.parse(AUTHORITY + SIGNUP_PATH);
      print("url:" + url.toString());
      result = await http.post(
          url,  body: json.encode(requestBody), headers: header);

      print("sign up response:");
      print(result.body);

      if(result.statusCode == 200){
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));

        print("sign up response:");
        print(res);

        res[statusCode] = result.statusCode;
        return res;
      }
      else{
        return {};
      }
    }
    catch(e)
    {
      print(e);
      return {};
    }
  }


  Future<Map<String, dynamic>> getRecommendedArticles(String token) async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json",
      "Authorization": token
    };

    print("sending traffic for recommended article");

    try {
      Uri url = Uri.parse(AUTHORITY + RECOMMEND_ARTICLE_PATH);
      print("url:" + url.toString());
      result = await http.get(
          url,  headers: header);


      if(result.statusCode == 200){
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));

        print("recommended response:");
        print(res);

        res[statusCode] = result.statusCode;
        return res;
      }
      else{
        Map<String, dynamic> t = {};
        t[statusCode] = result.statusCode;
        return {};
      }
    }
    catch(e)
    {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> searchArticles({required String token, required String keyword}) async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json",
      "Authorization": token
    };

    print("sending traffic for searching articles");

    try {
      Uri url = Uri.parse(AUTHORITY + SEARCH_ARTICLE_PATH + "/" + keyword);
      print("url:" + url.toString());
      result = await http.get(
          url,  headers: header);


      if(result.statusCode == 200){
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));

        print("search articles response:");
        print(res);

        res[statusCode] = result.statusCode;
        return res;
      }
      else{
        Map<String, dynamic> t = {};
        t[statusCode] = result.statusCode;
        return {};
      }
    }
    catch(e)
    {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> readArticle({required String token, required String title, required int fetchTime}) async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json",
      "Authorization": token
    };

    print("sending traffic to read article");

    try {
      Uri url = Uri.parse(AUTHORITY + "/articles/read/title/" + title + "/fetchTime/" + fetchTime.toString());
      print("url:" + url.toString());
      result = await http.post(
          url,  headers: header);


      if(result.statusCode == 200){
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));

        print("read article response:");
        print(res);

        res[statusCode] = result.statusCode;
        return res;
      }
      else{
        Map<String, dynamic> t = {};
        t[statusCode] = result.statusCode;
        return {};
      }
    }
    catch(e)
    {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> recommendVisits({required String token}) async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json",
      "Authorization": token
    };

    print("sending traffic for searching articles");

    try {
      Uri url = Uri.parse(AUTHORITY + RECOMMEND_VISIT_PATH);
      print("url:" + url.toString());
      result = await http.get(
          url,  headers: header);


      if(result.statusCode == 200){
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));

        print("search articles response:");
        print(res);

        res[statusCode] = result.statusCode;
        return res;
      }
      else{
        Map<String, dynamic> t = {};
        t[statusCode] = result.statusCode;
        return {};
      }
    }
    catch(e)
    {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> likeVisit({required String token, required String title, required String writer})
  async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json",
      "Authorization": token
    };

    print("sending traffic for liking visit");

    try {
      Uri url = Uri.parse(AUTHORITY + "/visits/heart/title/" + title + "/writer/" + writer);
      print("url:" + url.toString());

      result = await http.post(
          url,  headers: header);


      if(result.statusCode == 200){
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));

        print("like visit response:");
        print(res);

        res[statusCode] = result.statusCode;
        return res;
      }
      else{
        Map<String, dynamic> t = {};
        t[statusCode] = result.statusCode;
        return {};
      }
    }
    catch(e)
    {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> unlikeVisit({required String token, required String title, required String writer})
  async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json",
      "Authorization": token
    };

    print("sending traffic for unliking visit");

    try {
      Uri url = Uri.parse(AUTHORITY + "/visits/heart/title/" + title + "/writer/" + writer);
      print("url:" + url.toString());

      result = await http.delete(
          url,  headers: header);


      if(result.statusCode == 200){
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));

        print("unlike visit response:");
        print(res);

        res[statusCode] = result.statusCode;
        return res;
      }
      else{
        Map<String, dynamic> t = {};
        t[statusCode] = result.statusCode;
        return {};
      }
    }
    catch(e)
    {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> searchVisit({required String token, required String keyword}) async
  {
    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json",
      "Authorization": token
    };

    print("sending traffic for searching visits");

    try {
      Uri url = Uri.parse(AUTHORITY + SEARCH_VISIT_PATH + "/" + keyword);
      print("url:" + url.toString());
      result = await http.get(
          url,  headers: header);


      if(result.statusCode == 200){
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));

        print("search visit response:");
        print(res);

        res[statusCode] = result.statusCode;
        return res;
      }
      else{
        Map<String, dynamic> t = {};
        t[statusCode] = result.statusCode;
        return {};
      }
    }
    catch(e)
    {
      print(e);
      return {};
    }
  }

}