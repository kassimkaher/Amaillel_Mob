import 'dart:async';
import 'dart:convert';
import 'package:amall/Model/AmallModel.dart';
import 'package:amall/Model/KuranModel.dart';
import 'package:amall/Provider/ThemeUtils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'KuranBloc_event.dart';
part 'KuranBloc_state.dart';

class KuranBloc extends Bloc<KuranBlocEvent, KuranBlocState> {
  KuranBloc() : super(KuranBlocInitial());

  @override
  Stream<KuranBlocState> mapEventToState(
    KuranBlocEvent event,
  ) async* {
   
    try {
    if(event is GetKuranData){
    yield KuranBlocLoding();
    
 
    

   final String response = await rootBundle.loadString('files/quran.json');
    final jsondata = await json.decode(response);
  var data= KuranModel.fromJson(jsondata);


   
   
    if(data!=null){
      yield KuranBlocLoaded( data: data);
    }else{
      //sataus 0 is null data or error parse json
      yield KuranBlocError(status: 0,msg: ["ss"]);
    }


  }
  } catch (e) {
    print("KuranBlocError load error");
    print(e);
    //status -1 server error
     yield KuranBlocError(status: -1,msg:["An error has occured.","Please check your connection and try again"] );
  }
  }
  }

