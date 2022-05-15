
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


}