import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';

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
      final String uid = firebaseUser.uid;
      if (firebaseUser == null) {
        return false;
      }
      return true;
    } catch (e){
      print("sign in error caught!");
      return false;
    }
  }
}