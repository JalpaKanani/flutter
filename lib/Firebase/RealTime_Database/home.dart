import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Firebase/RealTime_Database/add_note.dart';


class RealTime extends StatefulWidget {
  const RealTime({Key? key}) : super(key: key);

  @override
  State<RealTime> createState() => _RealTimeState();
}

class _RealTimeState extends State<RealTime> {
  final fb = FirebaseDatabase.instance;
//late  DatabaseReference databaseReference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // databaseReference= fb;
  }

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('todos');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => addnote(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Todos',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.indigo[900],
      ),
      body: FirebaseAnimatedList(
       // query: ref,
        query: ref,
        shrinkWrap: true,
        itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation animation,int index) {

          print('${snapshot.value}');

          return GestureDetector(
            onTap: () {},
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.indigo[100],
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[900],
                    ),
                    onPressed: () {
                      ref.child(snapshot.key!).remove();
                    },
                  ),
                  title: Text(
          snapshot.value.toString(),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ),
              ),
            ),
          );
        },
      ),

    );
  }
}
