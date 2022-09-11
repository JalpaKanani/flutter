import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Firebase/phone_auth/otp_verify.dart';

class PhoneFireBase extends StatefulWidget {
  const PhoneFireBase({Key? key}) : super(key: key);

  @override
  State<PhoneFireBase> createState() => _PhoneFireBaseState();
}

class _PhoneFireBaseState extends State<PhoneFireBase> {
  TextEditingController phoneController = TextEditingController();

  void verifyPhone()async{
    String phone = '+91' + phoneController.text.trim();

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
        codeSent: (verificationId,tokenId){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(verificationId: verificationId,)));

        },
        verificationCompleted: (credential){},
        verificationFailed: (ex){
        print(ex.code.toString());
        },
        timeout: Duration(seconds: 30),

        codeAutoRetrievalTimeout: (verificationId){}
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(hintText: 'Enter ph-no'),
              ),
              SizedBox(
                height: 10,
              ),
              CupertinoButton(
                child: Text('SignIn'),
                onPressed: () {
                  verifyPhone();
                },
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
