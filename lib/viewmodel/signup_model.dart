import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/domain/repository/storage_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/feed.dart';
import 'package:surfing_sns/user.dart';

class SignUpModel extends ChangeNotifier {
  static User currentUser;

  SignUpModel({
    @required FirebaseAuthRepository authRepository,
    @required UserRepository userRepository,
    @required StorageRepository storageRepository,
    @required FeedRepository feedRepository
  })
      : _authRepository = authRepository,
        _userRepository = userRepository,
        _storageRepository = storageRepository,
        _feedRepository = feedRepository;

  final FirebaseAuthRepository _authRepository;
  final UserRepository _userRepository;
  final StorageRepository _storageRepository;
  final FeedRepository _feedRepository;
  String email = '';
  String password = '';
  String _coupleId;
  String get coupleId => _coupleId;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<void> init({String coupleId}) async {
    if (coupleId != null) {
      _coupleId = coupleId;
    }
    notifyListeners();
  }

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }
  void endLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future signUp() async {
    if (email == null || email.isEmpty) {
      throw ('メールアドレスを入力してください');
    }
    if (password == null || password.isEmpty) {
      throw ('パスワードを入力してください');
    }
    final User user = _buildUser();
    try {
      await _authRepository.signUp(email, password);
      final String uid = _authRepository.getUid();
        await _userRepository.addUser(uid, user);
        await _feedRepository.createFeedsCollection(uid);
    } catch (e) {
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