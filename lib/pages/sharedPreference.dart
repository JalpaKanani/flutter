import 'package:flutter/material.dart';
import 'package:untitled/providers/sharePreference.dart';

class SharedPrefHome extends StatefulWidget {
  const SharedPrefHome({Key? key}) : super(key: key);

  @override
  State<SharedPrefHome> createState() => _SharedPrefHomeState();
}

class _SharedPrefHomeState extends State<SharedPrefHome> {
  int _number = 0;
  bool cheked = false;
  String text = '';
  TextEditingController textEditingController = TextEditingController();
  List<String> contries = ['INDIA', 'USA', 'PAKISTAN', 'CHINA'];
  List<String> selectedItem = [];

  @override
  void initState() {
    _number = MySharedPrefences.GetNumber();
    cheked = MySharedPrefences.getBool();
    selectedItem = MySharedPrefences.getList();
    text = MySharedPrefences.getString();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_number}',
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _number++;
                        MySharedPrefences.saveNumber(_number);
                      });
                    },
                    child: Text('increment'))
              ],
            ),
            CheckboxListTile(
              value: cheked,
              onChanged: (value) {
                //  cheked = value!;
                setState(() {
                  cheked = !cheked;
                  MySharedPrefences.savebool(cheked);
                });
              },
              title: Text('TRUE/FALSE'),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: contries.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    value: selectedItem.contains(contries[index]),
                    onChanged: (value) {
                      setState(() {
                        if (selectedItem.contains(contries[index])) {
                          selectedItem.remove(contries[index]);
                        } else {
                          selectedItem.add(contries[index]);
                        }
                      });
                    },
                    title: Text(contries[index]),
                  );
                }),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    print(selectedItem);
                    MySharedPrefences.saveList(selectedItem);
                  });
                },
                child: Text('Save List')),
            SizedBox(height: 20,),
            Text(text),

            TextField(
              controller: textEditingController,
              onChanged: (v) {
                MySharedPrefences.saveString(text);
                print(text);
              },

            ),
            ElevatedButton(onPressed: (){
              setState(() {
                text = textEditingController.text;
                MySharedPrefences.saveString(text);
              });

            }, child: Text('feild')),
          ],
        ),
      ),
    );
  }
}


