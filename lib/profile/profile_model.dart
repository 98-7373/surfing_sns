import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:surfing_sns/domain/entity/user.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/infrastructure/user_repository_imp.dart';

class ProfileModel extends ChangeNotifier {
  ProfileModel({@required UserRepository userRepository})
      : _userRepository = userRepository;
  // Abstractの方のrepositoryにのみ依存する
  // repositoryは内部で生成せず、コンストラクタで受け取る
  final UserRepository _userRepository;

  // Abstractの方のrepositoryにのみ依存する
  // repositoryは内部で生成せず、コンストラクタで受け取る
  // Feedのリストのプライベートフィールド
  // ゲッターだけ定義し、値の変更はfetchFeedListによってのみ行われる
  List<User> _userList;
  List<User> get userList => _userList;
  bool _isLoading = true;
  bool get isLoading => _isLoading;


  // 画面生成の際に呼び出される初期化関数
  // fetchFeedListを直接呼ばずinit経由で呼ぶ（後々処理追加するかもしれないので）
  Future<void> init() async {
    await fetchUserList();
    _isLoading = false;
    notifyListeners();
  }
  // 非同期処理の開始時に呼び、isLoadingをtrueに変更する
  void startLoading() {
    _isLoading = true;
  }
  // 非同期処理の終了時に呼び、isLoadingをfalseに変更する
  void endLoading() {
    _isLoading = false;
  }
  // repositoryのメソッドを呼んでTodoのリストを取得する
  // コンストラクタではFeedRepositoryImpの方を渡しているので
  // 実際の処理はそちらを参照すること
  Future<void> fetchUserList() async {
    _userList = await _userRepository.findAll();
    notifyListeners();
  }

  Future<void> deleteFeeds(String uid) async {
    await _userRepository.deleteFeeds(uid);
    await fetchUserList();
    notifyListeners();
  }
}
