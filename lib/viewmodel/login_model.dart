import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:surfing_sns/user.dart';
import 'package:surfing_sns/viewmodel/signup_model.dart';

class LoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  final SignUpModel signUpModel;
  LoginModel({this.signUpModel});

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future signIn() async {
      if (mail.isEmpty) {
        throw ('メールアドレスを入力してください');
      }

      if (password.isEmpty) {
        throw ('パスワードを入力してください');
      }
      // todo
      final result = await _auth.signInWithEmailAndPassword(
        email: mail,
        password: password,);
      final uid = result.user.uid;
      final User fire = _buildUser();

      if (uid ==  null) {
        return false;
      }
  }


  User _buildUser() {
    return User(
        createdAt: DateTime.now()
    );
  }
}