import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/user.dart';

class SignUpModel extends ChangeNotifier {
  SignUpModel({
    @required FirebaseAuthRepository authRepository,
    @required UserRepository userRepository})

      : _authRepository = authRepository,
        _userRepository = userRepository;
  final FirebaseAuthRepository _authRepository;
  final UserRepository _userRepository;
  String mail = '';
  String password = '';

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future signUp() async {
      if (mail == null || mail.isEmpty) {
        throw ('メールアドレスを入力してください');
      }
      if (password == null || password.isEmpty) {
        throw ('パスワードを入力してください');
      }
      final User user = _buildUser();
      try {
        await _authRepository.signUp(mail, password);
        final String uid = _authRepository.getUid();
        await _userRepository.addUser(uid, user);
      } catch(e) {
        throw ('error');
      }
      notifyListeners();
  }



  User _buildUser() {
    return User(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}