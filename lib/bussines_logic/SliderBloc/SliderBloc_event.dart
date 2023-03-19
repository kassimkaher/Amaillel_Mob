part of 'SliderBloc_bloc.dart';

abstract class SliderBlocEvent extends Equatable {
  const SliderBlocEvent();

  @override
  List<Object> get props => [];
}

class GetSlider extends SliderBlocEvent{
 

  GetSlider() : super();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
