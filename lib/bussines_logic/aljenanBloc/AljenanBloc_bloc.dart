import 'dart:async';
import 'dart:convert';
import 'package:amall/Model/AmallModel.dart';
import 'package:amall/Model/KuranModel.dart';
import 'package:amall/Model/MufatehCatM.dart';
import 'package:amall/Model/MufatehItemM.dart';
import 'package:amall/Provider/ThemeUtils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'AljenanBloc_event.dart';
part 'AljenanBloc_state.dart';

class AljenanBloc extends Bloc<AljenanBlocEvent, AljenanBlocState> {
  AljenanBloc() : super(AljenanBlocInitial());

  @override
  Stream<AljenanBlocState> mapEventToState(
    AljenanBlocEvent event,
  ) async* {
   
    try {
    if(event is GetMufData){
    yield AljenanBlocLoding();
    
 
    

   final String response = await rootBundle.loadString('files/${event.catTag}');
    final jsondata = await json.decode(response);
  var datac= MufatehCatModel.fromJson(jsondata);


   final String responsei = await rootBundle.loadString('files/${event.dataTag}');
    final jsondatai = await json.decode(responsei);
  var datai= MufatehItemModel.fromJson(jsondatai);


   
   
    if(datac!=null){
      yield AljenanBlocLoaded(mufatehCatModel: datac,mufatehItemModel: datai);
    }else{
      //sataus 0 is null data or error parse json
      yield AljenanBlocError(status: 0,msg: ["ss"]);
    }


  }
  } catch (e) {
    print("AljenanBlocError load error");
    print(e);
    //status -1 server error
     yield AljenanBlocError(status: -1,msg:["An error has occured.","Please check your connection and try again"] );
  }
  }
  }

