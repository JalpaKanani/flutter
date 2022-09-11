import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefences {
  static const intKey = 'intKey';
  static const boolkey = 'boolkey';
  static const stringList = 'stringList';
  static const stringKey = 'stringKey';
  static SharedPreferences? _prefences;

  static init() async {
    _prefences = await SharedPreferences.getInstance();

    return _prefences;
  }

  static Future? saveNumber(int n) {
    return _prefences?.setInt('intKey', n);
  }

  static int GetNumber() {
    return _prefences?.getInt('intKey') ?? 0;
  }

  static Future? savebool(bool a) {
    return _prefences!.setBool("boolkey", a);
  }

  static bool getBool() {
    return _prefences?.getBool("boolkey") ?? false;
  }

  static Future? saveList(List<String> list) {
    return _prefences!.setStringList('stringList', list);
  }

  static List<String> getList() {
    return _prefences!.getStringList('stringList') ?? [];
  }

  static Future? saveString(String text) {
    return _prefences!.setString('stringKey', text);
  }


  static String getString(){
    return _prefences!.getString('stringKey')?? '';
  }
}
