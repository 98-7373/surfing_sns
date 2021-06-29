import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:surfing_sns/domain/entity/user.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/infrastructure/user_repository_imp.dart';
import 'package:uuid/uuid.dart';

class ProfileEditModel extends ChangeNotifier{
  File imageFile;
  ProfileEditModel({
    @required FirebaseAuthRepository authRepository,
    @required UserRepository userRepository,
    User user,
  }) : _authRepository = authRepository

  {
    _userRepository = userRepository;
    if (user != null){

    }
  }
  User feedUser;
  User get currentUser => UserRepositoryImp.currentUser;

  final FirebaseAuthRepository _authRepository;
  UserRepository _userRepository;
  User _user;

  String _userId;
  String get userId => _userId;

  DateTime _deadline;
  DateTime get deadline => _deadline;

  String _displayName;
  String get displayName => _displayName;

  String _profileId;
  String get profileId => _profileId;

  String _photoUrl;
  String get photoUrl => _photoUrl;

  String _imageStoragePath;
  String get imageStoragePath => _imageStoragePath;

  String _bio;
  String get bio => _bio;

  String _locationString;
  String get locationString => _locationString;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void changeTitle(String displayName) {
    _displayName = displayName;
    notifyListeners();
  }

  void changeCaption(String bio) {
    _bio = bio;
    notifyListeners();
  }

  //Feed 新規追加処理
  Future<void> addUserToFirebase() async {
    if(_displayName == null){
      throw('タイトルを入れてください');
    }
    final storageId = Uuid().v1();
    final photoUrl = await uploadImageToStorage(imageFile, storageId);
    final String uid = _authRepository.getUid();
    final User user = User(
      displayName: _displayName,
      bio: _bio,
      userId: uid,
      profileId: Uuid().v1(),
      photoUrl: photoUrl,
      imageStoragePath: storageId,
    );

    await _userRepository.add(user, uid);
  }

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    _isLoading = false;
    notifyListeners();
  }
  void changeDeadline(DateTime deadline) {
    _deadline = deadline;
    notifyListeners();
  }
  // 更新処理
  Future<void> updateUser() async {
    if (_displayName == null) {
      throw 'タイトルを記入してください';
    }
    final String uid = _authRepository.getUid();

    // documentの存在確認
    final bool isExist = await _userRepository.isExist(_user.userId);
    if (!isExist) {
      // 存在しない場合
      return;
    }
    // idから引っ張ってくる
    final User currentUser = await _userRepository.findById(uid, userId);
    final User user = User(
      userId: currentUser.userId,
      displayName: _displayName,
      bio: _bio,
      profileId: _profileId,
      photoUrl: _photoUrl,
      imageStoragePath: _imageStoragePath,
    );
    await _userRepository.updateUser(user);
  }

  setImage(File imageFile) {
    this.imageFile = imageFile;
    notifyListeners();
  }

  Future<String> uploadImageToStorage(File imageFile, String storageId) async {
    final storageRef = FirebaseStorage.instance.ref().child(storageId);
    final uploadTask = storageRef.putFile(imageFile);
    return await uploadTask.then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
  }


}