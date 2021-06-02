import 'package:firebase_auth/firebase_auth.dart';
import 'package:surfing_sns/feed.dart';

abstract class FeedRepository {
  Future<void> createFeedCollection(String uid, User user, Feed feed);
  Future<List<Feed>> findAll();
  Future<Feed> findById(String documentId);
  Future<void> add(Feed feed);
}
