import 'dart:async';
import 'package:amall/Model/AmallModel.dart';
import 'package:amall/Provider/ThemeUtils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'DataBloc_event.dart';
part 'DataBloc_state.dart';

class DataBlocBloc extends Bloc<DataBlocEvent, DataBlocState> {
  DataBlocBloc() : super(DataBlocInitial());

  @override
  Stream<DataBlocState> mapEventToState(
    DataBlocEvent event,
  ) async* {
   
    try {
    if(event is GetData){
    yield DataBlocLoding();
     
    var box = await Hive.openBox('amal_db');
   var data;
    try {
      Map<dynamic, dynamic> js = await box.get("amal_data");

      data = AmmalModel.fromJson(js);
    } catch (e) {

    }

 

  
   
    if(data!=null){
      yield DataBlocLoaded( data: data);
    }else{
      //sataus 0 is null data or error parse json
      yield DataBlocError(status: 0,msg: ["ss"]);
    }


  }else if(event is DeletData){
    yield DataBlocLoding();
     var data=event.ammalModel;
     data.dataAmal.removeAt(event.id);
   
    var box = await Hive.openBox('amal_db');

    try {
      await box.put("amal_data",data.toJson());

    
    } catch (e) {

    }
    if(data!=null){
      yield DataBlocLoaded( data: data);
    }else{
      //sataus 0 is null data or error parse json
      yield DataBlocError(status: 0,msg: ["ss"]);
    }


  }


    


  } catch (e) {
    print("DataBlocError load error");
    print(e);
    //status -1 server error
     yield DataBlocError(status: -1,msg:["An error has occured.","Please check your connection and try again"] );
  }
  }
  }

