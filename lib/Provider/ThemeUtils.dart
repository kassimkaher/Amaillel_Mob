
import 'dart:io';

import 'package:amall/Builder/themeBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class ThemeUtils extends ChangeNotifier{
  ThemeData _themeData;
  bool login=false;

  String firebaseToken;
  BuildContext context;
 
  
  ThemeUtils(this._themeData){
    _themeData=themeBuilder(SchedulerBinding.instance.window.platformBrightness==ThemeMode.light?1:0);
  }
  getThem()=>_themeData;
  setThem(ThemeData themeData){
_themeData = themeData;

notifyListeners();

  }

}