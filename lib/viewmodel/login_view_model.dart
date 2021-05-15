import 'package:flutter/material.dart';
import 'package:surfing_sns/viewmodel/signup_model.dart';

import 'login_model.dart';

class LoginViewModel extends ChangeNotifier{
  final SignUpModel signUpModel;
  LoginViewModel({this.signUpModel});
  


  bool isLoading = false;
  bool isSuccessful = false;

  // Future<bool> isSignIn() async {
  //   return await signUpModel.isSignIn();
  // }

  Future<void> signIn() async {
    isLoading = true;
    notifyListeners();

    isSuccessful = await signUpModel.signIn();
    isLoading = false;
    notifyListeners();
  }

}