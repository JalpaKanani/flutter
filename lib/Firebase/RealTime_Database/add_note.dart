import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Firebase/RealTime_Database/home.dart';


class addnote extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController title1 = TextEditingController();

  final fb = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
   final ref = fb.ref().child('todos');
//   final ref = fb.ref().child('todo').child('jalpa');

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todos"),
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Column(
                children: [
                  TextField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: 'title',
                    ),
                  ),
                  TextField(
                    controller: title1,
                    decoration: InputDecoration(
                      hintText: 'name',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: Colors.indigo[900],
              onPressed: () {
                insertData(title.text, title1.text);
                // String? name;
                // String? surname;
                // ref.push().set({
                //   'name':name,
                //   'title':surname,
                // }).asStream();

                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => RealTime()));
              },
              child: Text(
                "save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void insertData(String name,String city){
    fb.ref().child('todos').push().set({
      'name':name,
      'title':city,
    }).asStream();
  }

}