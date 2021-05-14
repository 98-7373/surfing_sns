import 'package:flutter/material.dart';
import 'package:surfing_sns/data_models/user.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  LoginViewModel({this.userRepository});
   String email = '';
   String password = '';

  bool isLoading = false;
  bool isSuccessful = false;
  Future<bool> isSignIn() async {
    return await userRepository.isSignIn();
  }

  Future<void> signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();

    isSuccessful = await userRepository.signIn(email, password);
    isLoading = false;
    notifyListeners();
  }

}