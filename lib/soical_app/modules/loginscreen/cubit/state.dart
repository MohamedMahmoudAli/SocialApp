
abstract class socialLoginState {}

class socialLoginInitialState extends socialLoginState {}

class socialLoginLoadingState extends socialLoginState {}

class socialLoginSuccessState extends socialLoginState {
  final String uid;

  socialLoginSuccessState(this.uid);
}

class socialLoginErrorState extends socialLoginState {
  final String error;
  socialLoginErrorState(this.error);
}

class socialChangePasswordState extends socialLoginState {}