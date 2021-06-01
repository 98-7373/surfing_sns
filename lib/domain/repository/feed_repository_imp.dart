import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:surfing_sns/feed.dart';
import 'package:surfing_sns/user.dart';

import 'feed_repository.dart';

class FeedRepositoryImp implements FeedRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _feeds;

  void init() {
    _feeds = _firestore.collection('feeds');
  }

  @override
  Future<void> createFeedCollection(String uid, User user, Feed feed) async {
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

}

