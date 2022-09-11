import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/Bloc/Sign_in_bloc.dart';
import 'package:untitled/Bloc/sign_in_event.dart';
import 'package:untitled/Bloc/sign_in_state.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in email'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          child: Column(
            children: [
              BlocBuilder<SignInBloc,SignInState>(builder: (context, state) {
                if (state is SignInErrorState) {
                  return Text(
                    state.errorMassage,
                    style: TextStyle(color:Colors.red),
                  );
                }
                else{
                return Container();
               }
              }),
              SizedBox(height: 10,),
              TextFormField(
                controller: _emailController,
                onChanged: (val) {
                  BlocProvider.of<SignInBloc>(context).add(
                    SignInTextChangeEvent(
                        _emailController.text, _passwordController.text),
                  );
                },
                decoration: InputDecoration(hintText: 'Email address'),
              ),
              TextFormField(
                controller: _passwordController,
                onChanged: (val) {
                  BlocProvider.of<SignInBloc>(context).add(
                    SignInTextChangeEvent(
                        _emailController.text, _passwordController.text),
                  );
                },
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                if(state is SignInLoadingState){
                  return CircularProgressIndicator();
                }
                return CupertinoButton(
                    onPressed: () {
                      print('valid1');
                      if (state is SignInValidState) {
                        BlocProvider.of<SignInBloc>(context).add(
                          SignInSubmittedEvent(_emailController.text, _passwordController.text),
                        );
                      }
                    },
                    color:
                        (state is SignInValidState) ? Colors.blue : Colors.grey,
                    child: Text('Sign In'));

              })
            ],
          ),
        ),
      ),
    );
  }
}
