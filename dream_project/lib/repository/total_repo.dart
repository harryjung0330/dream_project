import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class TotalRepository{
  String? userSysId;

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

}