import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:surfing_sns/data_models/user.dart';

class SignUpModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  static User currentUser;

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future signIn() async {
    try {
      if (mail.isEmpty) {
        throw ('メールアドレスを入力してください');
      }

      if (password.isEmpty) {
        throw ('パスワードを入力してください');
      }
      // todo
      final firebaseUser = (await _auth.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      )).user;
      final uid = firebaseUser.uid;
    } catch (e){
      print("sign in error caught!");
      return false;
    }
  }
}