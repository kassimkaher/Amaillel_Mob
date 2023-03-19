part of 'AljenanBloc_bloc.dart';

abstract class AljenanBlocState extends Equatable {
  const AljenanBlocState();
  
  @override
  List<Object> get props => [];
}

class AljenanBlocInitial extends AljenanBlocState {}
class AljenanBlocLoding extends AljenanBlocState {}
class AljenanBlocLoaded extends AljenanBlocState {
MufatehCatModel mufatehCatModel;
MufatehItemModel mufatehItemModel;
AljenanBlocLoaded({@required this.mufatehCatModel, @required this.mufatehItemModel});

}



class AljenanBlocError extends AljenanBlocState {
int status;
List<String> msg;
AljenanBlocError({@required this.status ,@required this.msg});
}


