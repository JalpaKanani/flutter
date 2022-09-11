import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/Firebase/Login/login.dart';
import 'package:untitled/Firebase/phone_auth/phone.dart';
import 'package:untitled/signin/Sign_in_email.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

class HomeFirebase extends StatefulWidget {
  const HomeFirebase({Key? key}) : super(key: key);

  @override
  State<HomeFirebase> createState() => _HomeFirebaseState();
}

class _HomeFirebaseState extends State<HomeFirebase> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  File? profilePic;

  void logout() {
    FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginInFireBase()));
  }

  void saveUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String ageString = ageController.text.trim();

    int age = int.parse(ageString);

    nameController.clear();
    emailController.clear();
    ageController.clear();

    if (name != '' && email != '' && profilePic != null) {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('profilePic')
          .child(Uuid().v1())
          .putFile(profilePic!);

      //realtime progress
      StreamSubscription taskSubscription =
          uploadTask.snapshotEvents.listen((snapshot) {
        double percentage =
            snapshot.bytesTransferred / snapshot.totalBytes * 100;

        print(percentage.toString());
      });

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      taskSubscription.cancel();
      Map<String, dynamic> userData = {
        'name': name,
        'email': email,
        'age': age,
        'profilePic': downloadUrl,
        'sampleArray': [name, email, age]
      };
      FirebaseFirestore.instance.collection('users').add(userData);
      print('user created');
    } else {
      print('please fill all field');
    }
    ;

    setState(() {
      profilePic = null;
    });
  }

  Future deleteUser(id) async {
    FirebaseFirestore.instance.collection('users').doc(id).delete();
    // await FirebaseFirestore.instance.collection('users').doc(id).delete();
    print('user dalete');
  }

  //app close hoy tyare notification parthi screen open karva mate nu function
  void getInitialMessage() async {
    RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      if (remoteMessage.data['page'] == 'email') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      }else if(remoteMessage.data['page'] == 'phone'){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PhoneFireBase()));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          //SnackBar(content: Text(message.notification!.body.toString()),duration: Duration(seconds: 10),backgroundColor: Colors.green,));
            SnackBar(
              content: Text('invalide page'),
              duration: Duration(seconds: 6),
              backgroundColor: Colors.red,
            ));

      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) {
      //print('message received${message.notification!.title}');
      ScaffoldMessenger.of(context).showSnackBar(
          //SnackBar(content: Text(message.notification!.body.toString()),duration: Duration(seconds: 10),backgroundColor: Colors.green,));
          SnackBar(
        content: Text(message.data['myname']),
        duration: Duration(seconds: 10),
        backgroundColor: Colors.green,
      ));
    });

    //app background ma oprn hoy tyare notifiction tap kariye to app open thay
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(   SnackBar(
          content: Text('App was open by a notification'),
          duration: Duration(seconds: 10),
          backgroundColor: Colors.green));
    });

    //app close hoy and notification tap kariye tyare APP  open thay
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              CupertinoButton(
                onPressed: () async {
                  XFile? selectedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (selectedImage != null) {
                    File convertedFile = File(selectedImage.path);
                    setState(() {
                      profilePic = convertedFile;
                    });
                  } else {
                    print('Not Selected image');
                  }
                },
                padding: EdgeInsets.zero,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      (profilePic != null) ? FileImage(profilePic!) : null,
                ),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email Address'),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(hintText: 'enter age'),
              ),
              SizedBox(height: 10),
              CupertinoButton(
                  child: Text('Save'),
                  onPressed: () {
                    saveUser();
                  }),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  // stream: FirebaseFirestore.instance.collection('users').snapshots(),
                  //   stream: FirebaseFirestore.instance.collection('users').where('sampleArray',arrayContainsAny:[24,21]).snapshots(),
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where(
                        'age',
                      )
                      .orderBy('age', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> userData =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(userData['profilePic']),
                                  ),
                                  title: Text(userData['name'] +
                                      '(${userData['age']})'),
                                  subtitle: Text(userData['email']),
                                  trailing: IconButton(
                                    onPressed: () {
                                      deleteUser(snapshot.data!.docs[index].id);
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                );
                              }),
                        );
                      } else {
                        return Text('No data');
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
