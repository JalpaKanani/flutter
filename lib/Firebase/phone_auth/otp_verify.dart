import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Firebase/home.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;

  const OTPScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController phoneController = TextEditingController();

  void verifyOtp() async {
    String otp = phoneController.text.trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeFirebase()));
      }
    } on FirebaseException catch (ex) {
      print(ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('verify otp'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
          children: [
            TextFormField(
              maxLength: 6,
              controller: phoneController,
              decoration: InputDecoration(
                counterText: '',
                  hintText: 'Enter OTP', label: Text('6-Degit enter')),
            ),
            SizedBox(
              height: 20,
            ),
            CupertinoButton(child: Text('Verify'), onPressed: () {})
          ],
        ),
      ),
    );
  }
}
