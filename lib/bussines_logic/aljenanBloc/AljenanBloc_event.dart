part of 'AljenanBloc_bloc.dart';

abstract class AljenanBlocEvent extends Equatable {
  const AljenanBlocEvent();

  @override
  List<Object> get props => [];
}

class GetMufData extends AljenanBlocEvent{
 
String catTag;
String dataTag;
  GetMufData({@required this.catTag,@required this.dataTag}) : super();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class DeletData extends AljenanBlocEvent{
 AmmalModel ammalModel;
int id;
  DeletData({@required this.id, @required this.ammalModel}) : super();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

