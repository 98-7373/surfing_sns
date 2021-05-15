
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:surfing_sns/data_models/user.dart';
import 'package:surfing_sns/domain/repository/db/database_manager.dart';

class SignUpModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  final DatabaseManager dbManager;
  SignUpModel({this.dbManager});

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future signIn() async {
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
    final email = firebaseUser.email;
    if (firebaseUser == null) {
      return false;
    }
    //usersにコレクション追加
    Firestore.instance.collection('users').add(
      {
        'email': email,
        'createdAt': Timestamp.now(),
      },
    );
  }

}