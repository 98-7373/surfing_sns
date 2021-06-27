import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/storage_repository.dart';
import 'package:surfing_sns/domain/entity/feed.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:surfing_sns/domain/entity/user.dart';
import 'package:uuid/uuid.dart';
import '../domain/repository/feed_repository.dart';
class FeedRepositoryImp implements FeedRepository {
  FeedRepositoryImp({StorageRepository storageRepository})
      : _storageRepository = storageRepository;
  final StorageRepository _storageRepository;
  File imageFile;
  final String title = "";
  final String caption = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _feeds;

  void init() {
    _feeds = _firestore.collection('feeds');
  }

  //TODO　新規登録時にのみ使用。
  Future<void> createFeedsCollection(String uid) async {
    // feedsコレクションにfeedを追加する
    final String feedsId = uid;
    await _feeds.doc(uid).set(<String, dynamic>{
    });
    // couplesコレクションの下にusersサブコレクションを追加して
    // 自分のuserIdを格納しておく
    final CollectionReference users =
    _feeds.doc(feedsId).collection('users');
    users.doc().set(<String, dynamic>{
      'userId': uid,
    });
  }
  @override
  Future<void> add(Feed feed, String uid) async {
    final String getfeedId = await _getFeedId();
    final CollectionReference recruitment =
    _feeds.doc(getfeedId).collection('recruitment');
    await recruitment.add(<String, dynamic>{
      'title': feed.title,
      'caption': feed.caption,
      'imageUrl': feed.imageUrl,
      'userId': feed.userId,
      'imageStoragePath': feed.imageStoragePath,
      'feedId': feed.feedId,
    });
  }

  //UUid取ってきて、次追加する
  Future<void> feed(String uid, Feed feed, String caption, String title,
      String imageUrl, String feedId, File imageFile) async {
    final storageId = Uuid().v1();
    final imageUrl = await uploadImageToStorage(imageFile, storageId);
    final feed = Feed(
      feedId: Uuid().v1(),
      userId: uid,
      imageUrl: imageUrl,
      title: title,
      caption: caption,
      imageStoragePath: storageId,
    );
    await insertFeed(feed);
  }
  //TODO feedに追加
  Future<void> insertFeed(Feed feed) async {
    await _feeds.doc(feed.userId).collection("recruitment").add(feed.toMap());
  }
  //TODO 取得
  @override
  Future<List<Feed>> findAll() async {
    final String getfeedId = await _getFeedId();
    final QuerySnapshot feeds =
    await _feeds.doc(getfeedId).collection('recruitment').get();
    // todosコレクションがない場合はnullを返す
    if (feeds.docs.isEmpty) {
      return null;
    }
    final List<Feed> result = feeds.docs
        .map(
          (QueryDocumentSnapshot feed) => Feed(
        userId: feed.id,
        title: feed['title'],
        caption: feed['caption'],
        imageUrl: feed['imageUrl'],
        imageStoragePath: feed['imageStoragePath'],
        feedId: feed['feedId'],
      ),
    )
        .toList();
    // collectionはあるが、中に一つも要素がない場合はnullが返る
    return result;
  }
  /// uidからFeedを取得する
  /// uidがドキュメントがfeedsコレクションに存在するかどうかの確認
  @override
  Future<bool> isExist(String uid) async {
    final String getfeedId = await _getFeedId();
    final DocumentSnapshot result =
    await _feeds.doc(getfeedId).collection('recruitment').doc(uid).get();
    return result.exists;
  }

  /// ドキュメントfeeds削除処理
  @override
  Future<void> deleteFeeds(String uid,) async {
    final String getfeedId = await _getFeedId();
    await _feeds.doc(getfeedId).collection('recruitment').doc(uid).delete();
  }

  @override
  Future<void> updateFeed(Feed feed) async {
    final String getfeedId = await _getFeedId();
    await _feeds
        .doc(getfeedId)
        .collection('recruitment')
        .doc(feed.userId)
        .update(<String, dynamic>{
      'title': feed.title,
      'caption': feed.caption,
      'imageUrl': feed.imageUrl,
      'imageStoragePath': feed.imageStoragePath,
      'feedId': feed.feedId,
      'userId': feed.userId,
    });
  }
  @override
  Future<Feed> findById(String userId, String uid) async {
    final String getfeedId = await _getFeedId();
    final DocumentSnapshot result =
    await _feeds.doc(getfeedId).collection('recruitment').doc(userId).get();
    Feed feed;
    if (result.id == userId) {
      feed = Feed(
          userId: result.id,
          title: result['title'],
          caption: result['caption'],
          imageUrl: result['imageUrl'],
          feedId: result['feedId'],
          imageStoragePath: result['imageStoragePath']
      );
    }
    return feed;
  }

  @override
  Future<String> uploadImageToStorage(File imageFile, String storageId) async {
    final srorageRef = FirebaseStorage.instance.ref().child(storageId);
    final uploadTask = srorageRef.putFile(imageFile);
    return await uploadTask.then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
  }

  Future<String> _getFeedId() async {
    final String getfeedId =
    await _storageRepository.loadPersistenceStorage(key_couple_id);
    return getfeedId;
  }

}
