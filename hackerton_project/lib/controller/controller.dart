import 'package:flutter/cupertino.dart';
import 'package:hackerton_project/service/service.dart';

import '../model/export_file.dart';

class Controller
{
  late final Service _service;
  static final Controller _controller = Controller._privController();

  factory Controller(){
    return _controller;
  }

  Controller._privController(){
    _service = Service();
  }

  Future<DataResponse<String>> logIn(String logInId, String pswd)
  {
    return _service.logIn(logInId, pswd);
  }

  Future<DataResponse<bool>> sendVerificationRequestForId({required String userName, required String emailAddr}) async
  {
    return _service.sendVerificationRequestForId(userName: userName, emailAddr: emailAddr);
  }

  Future<DataResponse<String>> sendVerificationCodeForId({required String emailAddr, required String code}) async
  {
    return _service.sendVerificationCodeForId(emailAddr: emailAddr, code: code);
  }

  Future<DataResponse<bool>> sendVerificationRequestForPs({required String logInId, required String emailAddr}) async
  {
   return _service.sendVerificationRequestForPs(emailAddr: emailAddr, logInId: logInId);
  }

  Future<DataResponse<bool>> sendVerificationCodeForPs({required String emailAddr, required String code}) async
  {
    return _service.sendVerificationCodeForPs(emailAddr: emailAddr, code: code);
  }

  Future<DataResponse<bool>> createNewPs({required String ps, required String emailAddr}) async
  {
    return _service.createNewPs(ps: ps, emailAddr: emailAddr);
  }


  Future<DataResponse<bool>> checkDuplicateId({required String id}) async
  {
    return _service.checkDuplicateId(id: id);
  }

  Future<DataResponse<bool>> checkDuplicateNickname({required String nickName}) async
  {
    return _service.checkDuplicateNickname(nickName: nickName);
  }

  Future<DataResponse<JusoList>> getAddr(
      { required int currentPage, required int countPerPage, required String keyword}
      ) async
  {
   return _service.getAddr(currentPage: currentPage, countPerPage: countPerPage, keyword: keyword);
  }

  Future<DataResponse<bool>> phoneNumberVerificationRequest ({required String phoneNumb}) async
  {
    return _service.phoneNumberVerificationRequest(phoneNumb: phoneNumb);

  }

  Future<DataResponse<bool>> phoneNumberVerificationCheck ({required String code, required String phoneNumb}) async
  {
    return _service.phoneNumberVerificationCheck(code: code, phoneNumb: phoneNumb);
  }

  Future<DataResponse<bool>> signUp({required Me me}) async
  {
    return _service.signUp(me: me);
  }
}