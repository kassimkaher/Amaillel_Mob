import 'dart:convert';
import 'dart:io';

import 'package:amall/Model/AmallModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ManagProvider extends ChangeNotifier {
  bool addLoading = false;
  int status = -1;
  List<ItemsAmal> dataAmal;
  Future saveData(DataAmal data) async {
    var box = await Hive.openBox('amal_db');
    try {
      var js = box.get("amal_data");

      AmmalModel oldData;
      try {
        oldData = AmmalModel.fromJson(js);
      } catch (e) {}

      if (oldData != null &&
          oldData.dataAmal != null &&
          oldData.dataAmal.length > 0) {
        oldData.dataAmal.add(data);
      } else {
        oldData = AmmalModel(dataAmal: [data]);
      }
      dataAmal = [];
      await box.put("amal_data", oldData.toJson());
    } catch (e) {}

    addLoading = false;
    notifyListeners();
  }
  Future updateData(DataAmal data) async {
    print(data.toJson());
    var box = await Hive.openBox('amal_db');
    try {
      var js = box.get("amal_data");

      AmmalModel oldData;
      try {
        oldData = AmmalModel.fromJson(js);
      } catch (e) {}

      if (oldData != null &&
          oldData.dataAmal != null &&
          oldData.dataAmal.length > 0) {
int ind=  oldData.dataAmal.indexWhere((e) => e.id==data.id);

       if(ind>-1){
          oldData.dataAmal[ind]=data;
       }
      } else {
        
      }
      dataAmal = [];
      await box.put("amal_data", oldData.toJson());
    } catch (e) {}

    addLoading = false;
    notifyListeners();
  }

  Future<void> shareFile(json) async {
    var path = await getApplicationDocumentsDirectory();
    File f = File(path.path + "/file.json");
    if (f == null) return null;

    await _writeJson(json, f);
    if (await f.exists()) {
      Share.shareFiles([f.path], text: 'Great picture');
      // await FlutterShare.shareFile(
      //   title: 'Example share',
      //   text: 'Example share text',
      //   filePath:  f.path,
      // );
    } else {
      print("cant share iunlow file");
    }
  }

  Future _writeJson(dynamic _json, File _filePath) async {
    //3. Convert _json ->_jsonString
    var _jsonString = json.encode(_json);
    print('jsonString: $_jsonString\n - \n');

    //4. Write _jsonString to the _filePath
    await _filePath.writeAsString(_jsonString);
  }
 Future saveDataromOutside(List<DataAmal> data) async {
    var box = await Hive.openBox('amal_db');
    try {
      var js = box.get("amal_data");

      AmmalModel oldData;
      try {
        oldData = AmmalModel.fromJson(js);
      } catch (e) {}

      if (oldData != null &&
          oldData.dataAmal != null &&
          oldData.dataAmal.length > 0) {
        oldData.dataAmal.addAll(data);
      } else {
        oldData = AmmalModel(dataAmal: data);
      }
      dataAmal = [];
      await box.put("amal_data", oldData.toJson());
    } catch (e) {}

    addLoading = false;
    notifyListeners();
  }
  Future readJson(_filePath) async {
    
    var _fileExists = await _filePath.exists();

    if (_fileExists) {
      try {
        //1. Read _jsonString<String> from the _file.
        var _jsonString = await _filePath.readAsString();
      
        var _json = jsonDecode(_jsonString);
        if (_json != null) {
          var data = AmmalModel.fromJson(_json);
          var d = saveDataromOutside(data.dataAmal);
        }
        return _json;
      } catch (e) {
        return null;
      }
    }
  }
}
