import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:surfing_sns/chat_class.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/chat_repository.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/domain/entity/feed.dart';
import 'package:surfing_sns/domain/repository/storage_repository.dart';
import 'package:uuid/uuid.dart';

class ChatModel extends ChangeNotifier {
  File imageFile;
  ChatModel({@required FeedRepository feedRepository,
    @required ChatRepository chatRepository,
    @required FirebaseAuthRepository authRepository,
    @required StorageRepository storageRepository})
      : _feedRepository = feedRepository,
        _chatRepository = chatRepository,
        _authRepository = authRepository,
        _storageRepository = storageRepository;
  // Abstractの方のrepositoryにのみ依存する
  // repositoryは内部で生成せず、コンストラクタで受け取る
  final FeedRepository _feedRepository;
  final ChatRepository _chatRepository;
  final FirebaseAuthRepository _authRepository;
  final StorageRepository _storageRepository;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _chats;

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

  String _comment;
  String get comment => _comment;

  String _commentUseId;
  String get commentUseId => _commentUseId;

  String _profileId;
  String get profileId => _profileId;

  DateTime commentDateTime;
  DateTime get _commentDateTime => commentDateTime;

  String chatId;
  String get _chatId => chatId;
  // 画面生成の際に呼び出される初期化関数
  // fetchFeedListを直接呼ばずinit経由で呼ぶ（後々処理追加するかもしれないので）
  void commentTitle(String comment) {
    _comment = comment;
    notifyListeners();
  }


  Future add(Chat chat) async {
    final String getchatId = await _getChatId();
    final CollectionReference recruitment =
    _chats.doc(getchatId).collection('chats');
    await recruitment.add(<String, dynamic>{
      'comment': comment,
      'commentUseId': chat.commentUserId,
      'profileId': chat.profileId,
      'commentDateTime': DateTime.now(),
      'chatId': chat.chatId,
    });
  }


  Future<void> init() async {
    await fetchFeedList();
    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> addFeedToFirebase() async {
    if(comment == null){
      throw('コメントを入れてください');
    }
    final String uid = _authRepository.getUid();
    final Chat chat = Chat(
      comment: _comment,
      commentUserId: _commentUseId,
      chatId: chatId,
      commentDateTime: DateTime.now(),
      profileId: uid,
    );
    await _chatRepository.add(chat, uid);
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

  Future<String> _getChatId() async {
    final String getchatId =
    await _storageRepository.loadPersistenceStorage(key_couple_id);
    return getchatId;
  }
}
