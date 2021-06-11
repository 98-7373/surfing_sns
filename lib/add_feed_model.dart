import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:surfing_sns/assign.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/feed.dart';
import 'domain/repository/auth_repository.dart';
import 'domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AddFeeModel extends ChangeNotifier {

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
      _locationString = _feed.locationString;
      _imageStoragePath = _feed.imageStoragePath;
      _deadline = _feed.deadline;
      _imageUrl = _feed.imageUrl;
      _feedId = _feed.feedId;
      _assign = _feed.assign;
    }
  }
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

  // 内部はAssignTypeで保持して、表示はStringに切り替える
  AssignType _assign;
  String get assign => _assign.jpnValue;


  void changeTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void changeCaption(String caption) {
    _caption = caption;
    notifyListeners();
  }
  void changeAssign(AssignType assign) {
    _assign = assign;
    notifyListeners();
  }

  //Feed 新規追加処理
  Future<void> addFeedToFirebase() async {
    if(_title == null){
      throw(' タイトルを入れてください');
    }
    if(caption == null){
      throw(' 詳細を入れてください');
    }
    final Feed feed = _buildFeed();
    try {
      final String uid = _authRepository.getUid();
      await _feedRepository.addFeedUser(uid,feed);
      await _feedRepository.add(uid, feed, caption, title);
    } catch(e) {
      throw ('error');
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
  void changeDeadline(DateTime deadline) {
    _deadline = deadline;
    notifyListeners();
  }

  // 更新処理
  Future<void> updateFeed() async {
    if (_feed == null) {
      throw 'タイトルを記入してください';
    }
    // documentの存在確認
    final bool isExist = await _feedRepository.isExist(_feed.userId);
    if (!isExist) {
      // 存在しない場合
      return;
    }
    // idから引っ張ってくる
    final Feed currentFeed = await _feedRepository.findById(_feed.userId);
    // isDoneとcreatedAtは変更しない
    final Feed feed = Feed(
      userId: currentFeed.userId,
      updatedAt: DateTime.now(),
      title: title,
      caption: caption,
    );
    await _feedRepository.updateFeed(feed);
  }
  //TODO
  Feed _buildFeed() {
    return Feed(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}