import 'package:cloud_firestore/cloud_firestore.dart';

import 'feed_repository.dart';

class FeedRepositoryImp implements FeedRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _feeds;

  void init() {
    _feeds = _firestore.collection('feeds');
  }
}

