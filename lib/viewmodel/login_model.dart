
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:surfing_sns/domain/repository/db/database_manager.dart';

class LoginModel extends ChangeNotifier {
  final DatabaseManager dbManager;
  LoginModel({this.dbManager});

  String mail = '';
  String password = '';

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future signUp() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください');
    }

    if (password.isEmpty) {
      throw ('パスワードを入力してください');
    }
    // todo
    final firebaseUser = await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
    final uid = firebaseUser.user.uid;
    // TODO
    Firestore.instance.collection('users').add(
      {
        'userId': uid,
        'createdAt': Timestamp.now(),
      },
    );
  }
}