import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Firebase/Signin/signin.dart';
import 'package:untitled/Firebase/home.dart';
import 'package:untitled/pages/homepage.dart';

class LoginInFireBase extends StatefulWidget {
  const LoginInFireBase({Key? key}) : super(key: key);

  @override
  State<LoginInFireBase> createState() => _LoginInFireBaseState();
}

class _LoginInFireBaseState extends State<LoginInFireBase> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginUser()async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if(email == '' || password == '' ){
      print('Fill detail ');

    }else{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if(userCredential != null){
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeFirebase()));
      };

    }on FirebaseException catch(ex) {
      print(ex.code.toString());
    }

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10,top: 40),
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'email'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: 'password'),
              ),
              SizedBox(height: 10,),
              CupertinoButton(child: Text('login'),
                 color: Colors.blue ,
                  onPressed: () {
                    loginUser();
                  }),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SigninFirebase()));
                  },
                  child: Text('Create an account'))
            ],
          ),
        ),
      ),
    );
  }
}
