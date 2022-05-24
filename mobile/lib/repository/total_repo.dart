import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class TotalRepository{
  String? userSysId;

  static const AUTHORITY = "https://5ni1uif3uc.execute-api.ap-northeast-2.amazonaws.com/test";
  static const LOG_IN_PATH = "/user/login";

  static const logInKey = "logIn";
  static const passwdKey = "passwd";
  static const tokenKey = "token";
  static const statusCode = "statusCode";

  final FlutterSecureStorage storage = FlutterSecureStorage();

  static final TotalRepository _totalRepository = TotalRepository._privTotalRepository();


  factory TotalRepository()
  {
    return _totalRepository;
  }

  TotalRepository._privTotalRepository()
  {

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

}