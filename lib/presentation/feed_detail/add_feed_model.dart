import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/infrastructure/user_repository_imp.dart';
import 'package:surfing_sns/domain/entity/feed.dart';
import 'package:surfing_sns/domain/entity/user.dart';
import 'package:uuid/uuid.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AddFeeModel extends ChangeNotifier {
  File imageFile;
  AddFeeModel({
    @required FirebaseAuthRepository authRepository,
    @required FeedRepository feedRepository,
    Feed feed,
  }) : _authRepository = authRepository

  {
    _feedRepository = feedRepository;
    if (feed != null){
      _feed = feed;
      _title = feed.title;
      _userId = _feed.userId;
      _caption = _feed.caption;
      _imageUrl = _feed.imageUrl;
    }
  }
  User feedUser;
  User get currentUser => UserRepositoryImp.currentUser;

  final FirebaseAuthRepository _authRepository;
  FeedRepository _feedRepository;
  Feed _feed;

  String _userId;
  String get userId => _userId;

  DateTime _deadline;
  DateTime get deadline => _deadline;

  String _title;
  String get title => _title;

  String _feedId;
  String get feedId => _feedId;

  String _imageUrl;
  String get imageUrl => _imageUrl;

  String _imageStoragePath;
  String get imageStoragePath => _imageStoragePath;

  String _caption;
  String get caption => _caption;

  String _locationString;
  String get locationString => _locationString;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  void changeTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void changeCaption(String caption) {
    _caption = caption;
    notifyListeners();
  }

  //Feed 新規追加処理
  Future<void> addFeedToFirebase() async {
    if(_title == null){
      throw('タイトルを入れてください');
    }
    final storageId = Uuid().v1();
    final imageUrl = await uploadImageToStorage(imageFile, storageId);
    final String uid = _authRepository.getUid();
    final Feed feed = Feed(
      title: _title,
      caption: _caption,
      userId: uid,
      feedId: Uuid().v1(),
      imageUrl: imageUrl,
      imageStoragePath: storageId,
    );
    await _feedRepository.add(feed, uid);
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
  Future<void> updateFeed() async {
    if (_title == null) {
      throw 'タイトルを記入してください';
    }
    final String uid = _authRepository.getUid();

    // documentの存在確認
    final bool isExist = await _feedRepository.isExist(_feed.userId);
    if (!isExist) {
      // 存在しない場合
      return;
    }
    // idから引っ張ってくる
    final Feed currentFeed = await _feedRepository.findById(uid, userId);
    final Feed feed = Feed(
      userId: currentFeed.userId,
      title: _title,
      caption: _caption,
      imageUrl: _imageUrl,
      imageStoragePath: _imageStoragePath,
      feedId: _feedId,
    );
    await _feedRepository.updateFeed(feed);
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
