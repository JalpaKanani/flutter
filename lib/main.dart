import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/Firebase/Login/login.dart';
import 'package:untitled/Firebase/RealTime_Database/home.dart';
import 'package:untitled/Firebase/home.dart';
import 'package:untitled/Firebase/services/notification.dart';
import 'package:untitled/pages/apiCalling.dart';
import 'package:untitled/pages/homepage.dart';
import 'package:untitled/pages/razorPay.dart';
import 'package:untitled/pages/sharedPreference.dart';
import 'package:untitled/pages/sql_list.dart';
import 'package:untitled/pages/welcome.dart';
import 'package:untitled/providers/deHelper.dart';
import 'package:untitled/providers/sharePreference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //  options: DefaultFirebaseOptions.currentPlatform
      );
  await NotificationService.initialize();

  //QuerySnapshot snapshot=await FirebaseFirestore.instance.collection('users').get();
  // DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //     .collection('users')
  //     .doc('9CXLfTv7oRnZcC2sz6ZO')
  //     .get();
  // print(snapshot.data());
// FirebaseFirestore _firestore=FirebaseFirestore.instance;
//
//   Map<String,dynamic> newUSerData = {
//     'name':'Jalpa1',
//     'email': 'Jalpakanani1@gmail.com'
//
//   };
//save
 // await _firestore.collection('users').add(newUSerData);
//  await _firestore.collection('users').doc('kanani').set(newUSerData);
//   await _firestore.collection('users').doc('kanani').update({'email': 'jalpakannai2@gmail.com'});
//   print('New user Saved!');

  //fetch
  // for(var doc in snapshot.docs){
  //   print(doc.data().toString());
  // }
//await _firestore.collection('users').doc('kanani').delete();

  await MySharedPrefences.init();
  await DatabaseHandler().initializeDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RealTime(),
      //home: ListScreen(),
      // home: (FirebaseAuth.instance.currentUser) != null
      //     ? HomeFirebase()
      //     : LoginInFireBase(),
      debugShowCheckedModeBanner: false,
    );
  }
}
