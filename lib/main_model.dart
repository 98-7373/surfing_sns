


import 'package:flutter/material.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';

class MainModel extends ChangeNotifier {
  String suzuki = "suzukiko";

  void Changesuzuki() {
    suzuki = "鈴木さん";
    notifyListeners();
  }
}