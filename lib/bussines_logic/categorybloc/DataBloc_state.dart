part of 'DataBloc_bloc.dart';

abstract class DataBlocState extends Equatable {
  const DataBlocState();
  
  @override
  List<Object> get props => [];
}

class DataBlocInitial extends DataBlocState {}
class DataBlocLoding extends DataBlocState {}
class DataBlocLoaded extends DataBlocState {
AmmalModel data;
DataBlocLoaded({@required this.data});

}



class DataBlocError extends DataBlocState {
int status;
List<String> msg;
DataBlocError({@required this.status ,@required this.msg});
}


