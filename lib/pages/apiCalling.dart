import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCalling extends StatefulWidget {
  const ApiCalling({Key? key}) : super(key: key);

  @override
  State<ApiCalling> createState() => _ApiCallingState();
}

class _ApiCallingState extends State<ApiCalling> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch api calling'),
      ),
      body: Container(
        child: FutureBuilder<List<User>>(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(snapshot.data![index].name.toString()),
                        Text(snapshot.data![index].nodeId.toString()),
                        Divider(),
                      ],
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('https://api.github.com/users'));
  print(response.body);
  List responseJson = json.decode(response.body);
  List<User> userList = createList(responseJson);
  return userList;
}




List<User> createList(List data) {
  List<User> list = [];
  for (int i = 0; i < data.length; i++) {
    String title = data[i]['login'];
    int id = data[i]['id'];
    String nodeId = data[i]['node_id'];
    User user = User(name: title, id: id, nodeId: nodeId);
    list.add(user);
  }
  return list;
}


Future<List<User>> fetch()async{
  final response = await http.get(Uri.parse('https://api.github.com/users'));
  List responseData = json.decode(response.body);
  List<User> data = create(responseData);
  return data;
}

List<User> create(List data){
  List<User> list = [];
  for(int i = 0;i< data.length;i++){
    String title = data[i]['login'];
    int id = data[i]['id'];
  User user = User(name: title,id: id);
  list.add(user);
  }
  return list;
}

class User {
  String? name;
  int? id;
  String? nodeId;

  User({this.name, this.id, this.nodeId});
}
