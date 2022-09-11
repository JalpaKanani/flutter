import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Firebase/home.dart';
import 'package:untitled/pages/homepage.dart';

class SigninFirebase extends StatefulWidget {
  const SigninFirebase({Key? key}) : super(key: key);

  @override
  State<SigninFirebase> createState() => _SigninFirebaseState();
}

class _SigninFirebaseState extends State<SigninFirebase> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void createUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();


    if(email == '' || password == '' || cPassword == '' ){
     print('Fill detail ');

    }else if(password != cPassword){
      print('password do not matched');

    }else{
    try{
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print('user created');
      
      if(userCredential != null){
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context ,MaterialPageRoute(builder:(context)=>HomeFirebase() ));
        
        
      }
    }on FirebaseException catch(ex){
      print(ex.code.toString());
    }

    };

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
              TextFormField(
                controller: cPasswordController,
                decoration: InputDecoration(hintText: 'ConfirmPassword'),
              ),
              SizedBox(
                height: 10,
              ),
              CupertinoButton(
                  child: Text('Signin'), color: Colors.blue, onPressed: () {
                    createUser();


              }),
            ],
          ),
        ),
      ),
    );
  }
}
