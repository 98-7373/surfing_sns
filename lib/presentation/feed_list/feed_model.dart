import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:surfing_sns/chat_class.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/chat_repository.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/domain/entity/feed.dart';

class FeedModel extends ChangeNotifier {
  FeedModel({@required FeedRepository feedRepository,
             @required ChatRepository chatRepository})
      : _feedRepository = feedRepository,
        _chatRepository = chatRepository;
  // Abstractの方のrepositoryにのみ依存する
  // repositoryは内部で生成せず、コンストラクタで受け取る
  final FeedRepository _feedRepository;
  final ChatRepository _chatRepository;

  // Abstractの方のrepositoryにのみ依存する
  // repositoryは内部で生成せず、コンストラクタで受け取る
  // Feedのリストのプライベートフィールド
  // ゲッターだけ定義し、値の変更はfetchFeedListによってのみ行われる
  List<Feed> _feedList;
  List<Chat> _chatList;
  List<Feed> get feedList => _feedList;
  List<Chat> get chatList => _chatList;

  bool _isLoading = true;
  bool get isLoading => _isLoading;



  // 画面生成の際に呼び出される初期化関数
  // fetchFeedListを直接呼ばずinit経由で呼ぶ（後々処理追加するかもしれないので）
  Future<void> init() async {
    await fetchFeedList();
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
  Future<void> fetchFeedList() async {
    _feedList = await _feedRepository.findAll();
    notifyListeners();
  }

  //削除処理
  Future<void> deleteFeeds(String uid) async {
    await _feedRepository.deleteFeeds(uid);
    await fetchFeedList();
    notifyListeners();
  }

  //chat
  Future<void> initChat() async {
    await fetchChatList();
    _isLoading = false;
    notifyListeners();
  }
  Future<void> fetchChatList() async {
    _chatList = await _chatRepository.findAll();
    notifyListeners();
  }

  //削除処理
  Future<void> deleteChats(String uid) async {
    await _chatRepository.deleteChats(uid);
    await fetchChatList();
    notifyListeners();
  }
}
