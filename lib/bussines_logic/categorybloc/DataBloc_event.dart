part of 'DataBloc_bloc.dart';

abstract class DataBlocEvent extends Equatable {
  const DataBlocEvent();

  @override
  List<Object> get props => [];
}

class GetData extends DataBlocEvent{
 

  GetData() : super();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class DeletData extends DataBlocEvent{
 AmmalModel ammalModel;
int id;
  DeletData({@required this.id, @required this.ammalModel}) : super();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

