
abstract class socialRegisterState {}

class socialRegisterInitialState extends socialRegisterState {}

class socialRegisterLoadingState extends socialRegisterState {}

class socialRegisterSuccessState extends socialRegisterState {

}

class socialRegisterErrorState extends socialRegisterState {
  final String error;

  socialRegisterErrorState( this.error);
}

class socialChangePasswordRegisterState extends socialRegisterState {}
class socialusercreateLoadingState extends socialRegisterState {}

class socialusercreateSuccessState extends socialRegisterState {

}

class socialusercreateErrorState extends socialRegisterState {
  final String error;

  socialusercreateErrorState( this.error);
}