import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/domain/entity/user.dart';

class LoginModel extends ChangeNotifier {
  LoginModel({
    @required FirebaseAuthRepository authRepository,
    @required UserRepository userRepository})

      : _authRepository = authRepository,
        _userRepository = userRepository;
  final FirebaseAuthRepository _authRepository;
  final UserRepository _userRepository;


  String email = '';
  String password = '';

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<void> init() async {
    notifyListeners();
  }

  Future<void> login() async {
    if (email == null || email.isEmpty) {
      throw 'メールアドレスを入力してください';
    }
    if (password == null || password.isEmpty) {
      throw 'パスワードを入力してください';
    }
    try {
      await _authRepository.login(email, password);
      final String uid = _authRepository.getUid();
    } catch (e) {
      throw ('エラー');
    }
    notifyListeners();
  }


}