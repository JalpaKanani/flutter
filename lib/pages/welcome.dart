import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/Bloc/Sign_in_bloc.dart';
import 'package:untitled/signin/Sign_in_email.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => SignInBloc(),
                                  child: SignIn(),
                                )));
                  },
                  child: Text('Sign in email')),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () {}, child: Text('Sign in google'))
            ],
          ),
        ),
      ),
    );
  }
}
