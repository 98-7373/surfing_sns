
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:surfing_sns/assign.dart';
import 'package:surfing_sns/feed.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'feed_repository.dart';
class FeedRepositoryImp implements FeedRepository {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _feeds;

  void init() {
    _feeds = _firestore.collection('feeds');
  }

  //TODO　新規登録時にのみ使用。
  Future<void> addFeedUser(String uid, Feed feed) async {
    // feedsコレクションにfeedを追加する
    _feeds.doc(uid).snapshots().listen((DocumentSnapshot event) async {
      if (!event.exists) {
        await _feeds.doc(uid).set(<String, dynamic>{
          'userId': uid,
          'caption': feed.caption,
          'imageStoragePath': feed.imageStoragePath,
          'imageUrl': feed.imageUrl,
          'locationString': feed.locationString,
          'feedId': feed.feedId,
          'title': feed.title,
        });
      }
    });
  }
  //userId元にfeedsを追加
  Future<void> add(String uid, Feed feed, String caption, String title) async {
    _feeds.doc(uid).snapshots().listen((DocumentSnapshot event) async {
      if (!event.exists) {
        await _feeds.doc(uid).set(<String, dynamic>{
          'userId': uid,
          'caption': caption,
          'imageStoragePath': feed.imageStoragePath,
          'imageUrl': feed.imageUrl,
          'locationString': feed.locationString,
          'feedId': feed.feedId,
          'title': title,
        });
      }
    });
  }

  Future<List<Feed>> findAll() async {
    //TODO userId取得
    final QuerySnapshot feeds =
    await _feeds.get();
    // todosコレクションがない場合はnullを返す
    if (feeds.docs.isEmpty) {
      return null;
    }
    final List<Feed> result = feeds.docs
        .map(
          (QueryDocumentSnapshot feed) => Feed(
        userId: feed.id,
        feedId: feed['feedId'],
        imageUrl: feed['imageUrl'],
        imageStoragePath: feed['imageStoragePath'],
        caption: feed['caption'],
        locationString: feed['locationString'],
            title: feed['title'],
      ),
    )
        .toList();
    // collectionはあるが、中に一つも要素がない場合はnullが返る
    return result;
  }

  /// uidからFeedを取得する
  @override
  Future<Feed> findById(String uid) async {
    final DocumentSnapshot result =
    await _feeds.doc(uid).get();
    Feed feed;
    if (result.id == uid) {
      // DateTime or null
      feed = Feed(
        userId: result.id,
        feedId: result['feedId'],
        imageUrl: result['imageUrl'],
        imageStoragePath: result['imageStoragePath'],
        caption: result['caption'],
        locationString: result['locationString'],
        title: result['title'],
      );
    }
    return feed;
  }
  /// uidがドキュメントがfeedsコレクションに存在するかどうかの確認
  @override
  Future<bool> isExist(String uid) async {
    final DocumentSnapshot result =
    //TODO
    await _feeds.doc().get();
    return result.exists;
  }

  /// ドキュメントfeeds削除処理
  @override
  Future<void> deleteFeeds(String uid) async {
    //TODO
    await _feeds.doc().collection('feeds').doc(uid).delete();
  }


  @override
  Future<void> updateFeed(Feed feed) async {
    await _feeds.doc(
        feed.userId)
        .update(<String, dynamic>{
      'userId': feed.userId,
      'assign': feed.assign.value,
      'title': feed.title,
      'caption': feed.caption,
    });
  }

}