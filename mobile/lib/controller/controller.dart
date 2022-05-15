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

}