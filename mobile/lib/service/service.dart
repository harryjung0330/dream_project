
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
  
  Future<DataResponse<bool>> log_in({required String email , required String password}) async
  {
    Map<String ,dynamic> request = {
      "email": email,
      "pswd": password
    };
    
    Map<String, dynamic> response = await rep.log_in(request);
    
    late DataResponse<bool> data;
    
    int status = int.tryParse(response["status"].toString()) ?? 1;
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
          return "로그인이 성공하였습니다.";
        default:
          return "로그인을 실패했습니다.";
      }
    });

    return data;
  }

}