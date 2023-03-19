part of 'SliderBloc_bloc.dart';

abstract class SliderBlocState extends Equatable {
  const SliderBlocState();
  
  @override
  List<Object> get props => [];
}

class SliderBlocInitial extends SliderBlocState {}
class SliderBlocLoding extends SliderBlocState {}
class SliderBlocLoaded extends SliderBlocState {
TopModel data;
SliderBlocLoaded({@required this.data});

}



class SliderBlocError extends SliderBlocState {
int status;
List<String> msg;
SliderBlocError({@required this.status ,@required this.msg});
}


