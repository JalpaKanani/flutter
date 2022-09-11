import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  bool? isEligible;
  String? eligibalityMassege = "";

  void chekEligibility(int age) {
    if (age > 18) {
      isEligible = true;
      eligibalityMassege = 'you are eligible';
      notifyListeners();
    } else {
      isEligible = false;
      eligibalityMassege = 'you are not eligible';
      notifyListeners();
    }
  }
}
