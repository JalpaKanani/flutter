

abstract class SignInState{}

class SignInInitialState extends SignInState{}

class SignInInValidState extends SignInState{}

class SignInValidState extends SignInState{}
class SignInErrorState extends SignInState{
   final String errorMassage;
   SignInErrorState(this.errorMassage);
}
class SignInLoadingState extends SignInState{}