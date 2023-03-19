part of 'KuranBloc_bloc.dart';

abstract class KuranBlocEvent extends Equatable {
  const KuranBlocEvent();

  @override
  List<Object> get props => [];
}

class GetKuranData extends KuranBlocEvent{
 

  GetKuranData() : super();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class DeletData extends KuranBlocEvent{
 AmmalModel ammalModel;
int id;
  DeletData({@required this.id, @required this.ammalModel}) : super();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

