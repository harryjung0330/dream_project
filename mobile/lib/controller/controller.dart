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

  Future<DataResponse<bool>> log_in({required String email, required String password}) async{

    DataResponse<bool> response = await _service.log_in(email: email, password: password);

    return response;
  }

  Future<DataResponse<bool>> send_code_signup({required String email}) async{

    DataResponse<bool> response = await _service.send_code_signup(email: email);

    return response;
  }

  Future<DataResponse<bool>> verify_code_signup({required String code, required String email}) async{

    DataResponse<bool> response = await _service.verify_code_signup(email: email, code: code);

    return response;
  }

  Future<DataResponse<bool>> check_duplicate_nickname({ required String nickname}) async{

    DataResponse<bool> response = await _service.check_duplicate_nickname(nickname: nickname);

    return response;
  }

  Future<DataResponse<bool>> sign_up({required String name,required String email,
    required String code, required String pswd, required nickname}) async
  {
    DataResponse<bool> ret = await _service.sign_up(name: name, email: email, code: code, pswd: pswd, nickname: nickname);

    return ret;
  }

  Future<DataResponse<List<Article>>> getRecommendedArticles() async
  {
    return await _service.getRecommendedArticles();
  }

  Future<DataResponse<List<Article>>> getSearchArticles({required String keyword}) async{
    return await _service.searchArticles(keyword: keyword);
  }

  Future<DataResponse<bool>> readArticles({required String title, required int fetchTime}) async{
    return await _service.readArticles(title: title, fetchTime:fetchTime);
  }

  Future<DataResponse<List<Visit>>> getRecommendVisits() async{
    return await _service.recommendVisit();
  }

  Future<DataResponse<bool>> likeVisit({required String title, required String writer}) async{
    return await _service.likeVisit(title: title, writer: writer);
  }

  Future<DataResponse<bool>> unlikeVisit({required String title, required String writer}) async{
    return await _service.unlikeVisit(title: title, writer: writer);
  }

  Future<DataResponse<List<Visit>>> getSearchVisits({required String keyword}) async{
    return await _service.searchVisit(keyword: keyword);
  }

}