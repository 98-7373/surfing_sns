import 'package:cloud_firestore/cloud_firestore.dart';
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
  @override
  Future<void> createFeedCollection(String uid, auth.User user, Feed feed) async {
    // couples/todos コレクション作成
    final CollectionReference feeds =
    _feeds.doc(uid).collection('feeds');
// 追加しているsampleTodoはlib/common/sample_dataのもの
    await feeds.doc().set(<String, dynamic>{
      'userId': uid,
      'feedId': feed.feedId,
      'imageUrl': feed.imageUrl,
      'imageStoragePath': feed.imageStoragePath,
      'caption': feed.caption,
      'locationString': feed.locationString,
    });
  }

  Future<List<Feed>> findAll() async {

    //TODO userId取得
    final QuerySnapshot feeds =
    await _feeds.doc().collection('feeds').get();
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
      ),
    )
        .toList();
    // collectionはあるが、中に一つも要素がない場合はnullが返る
    return result;
  }

  /// documentIdからFeedを取得する
  @override
  Future<Feed> findById(String documentId) async {
    final DocumentSnapshot result =
    await _feeds.doc().collection('feeds').doc(documentId).get();
    Feed feed;
    if (result.id == documentId) {
      // DateTime or null
      feed = Feed(
        userId: result.id,
        feedId: result['feedId'],
        imageUrl: result['imageUrl'],
        imageStoragePath: result['imageStoragePath'],
        caption: result['caption'],
        locationString: result['locationString'],
      );
    }
    return feed;
  }

  @override
  Future<void> add(Feed feed) async {
    final CollectionReference feeds =
    _feeds.doc().collection('feeds');
    await feeds.add(<String, dynamic>{
      'userId': feed.userId,
      'feedId': feed.feedId,
      'imageUrl': feed.imageUrl,
      'imageStoragePath': feed.imageStoragePath,
      'caption': feed.caption,
      'locationString': feed.locationString,
    });
  }


}
