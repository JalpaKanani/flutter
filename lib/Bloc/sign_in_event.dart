abstract class SigninEvent {}

class SignInTextChangeEvent extends SigninEvent {
  final String email;
  final String password;

  SignInTextChangeEvent(this.email, this.password);
}

class SignInSubmittedEvent extends SigninEvent {
  final String email;
  final String password;

  SignInSubmittedEvent(this.email,this.password);
}
