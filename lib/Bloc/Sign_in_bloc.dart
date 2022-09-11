

import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/Bloc/sign_in_event.dart';
import 'package:untitled/Bloc/sign_in_state.dart';


class SignInBloc extends Bloc<SigninEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInTextChangeEvent>((event, emit) {
      if (EmailValidator.validate(event.email) == false) {
        emit(SignInErrorState('Please enter a valid email address'));
      } else if (event.password.length <= 7) {
        emit(SignInErrorState('Please enter a valid password'));
      } else {
        emit(SignInValidState());
      }
    });
    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadingState());
    });
  }
}
