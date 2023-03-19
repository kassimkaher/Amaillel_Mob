part of 'KuranBloc_bloc.dart';

abstract class KuranBlocState extends Equatable {
  const KuranBlocState();
  
  @override
  List<Object> get props => [];
}

class KuranBlocInitial extends KuranBlocState {}
class KuranBlocLoding extends KuranBlocState {}
class KuranBlocLoaded extends KuranBlocState {
KuranModel data;
KuranBlocLoaded({@required this.data});

}



class KuranBlocError extends KuranBlocState {
int status;
List<String> msg;
KuranBlocError({@required this.status ,@required this.msg});
}


