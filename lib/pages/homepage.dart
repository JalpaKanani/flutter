import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/homePageProvider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ChangeNotifierProvider<HomeProvider>(
          create: (context)=> HomeProvider(),
          child: Consumer<HomeProvider>(
            builder: (BuildContext,provider,child){
              return Column(
                children: [
                  Text(provider.eligibalityMassege.toString(),style: TextStyle(
                    color: (provider.isEligible == true)?Colors.green:Colors.red,
                  ),),


                  Padding(
                    padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter Your age'
                      ),
                      onChanged: (val){
                        provider.chekEligibility(int.parse(val));
                      },
                    ),
                  ),
                ],
              );
            }

          ),
        ),
      ),
    );
  }
}
