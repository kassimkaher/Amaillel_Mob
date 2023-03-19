import 'dart:async';
import 'dart:convert';
import 'package:amall/Model/AmallModel.dart';
import 'package:amall/Model/SliderModel.dart';
import 'package:amall/Provider/ThemeUtils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'SliderBloc_event.dart';
part 'SliderBloc_state.dart';

class SliderBlocBloc extends Bloc<SliderBlocEvent, SliderBlocState> {
  SliderBlocBloc() : super(SliderBlocInitial());

  @override
  Stream<SliderBlocState> mapEventToState(
    SliderBlocEvent event,
  ) async* {
   
    try {
    if(event is GetSlider){
    yield SliderBlocLoding();
     
  
   final String response = await rootBundle.loadString('images/slider.json');
    final jsondata = await json.decode(response);
   
  var data= TopModel.fromJson(jsondata);
  yield SliderBlocLoaded(data: data);

  }

    


  } catch (e) {
    print("SliderBlocError load error");
    print(e);
    //status -1 server error
     yield SliderBlocError(status: -1,msg:["An error has occured.","Please check your connection and try again"] );
  }
  }
  }

