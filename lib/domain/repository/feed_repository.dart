import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:surfing_sns/feed.dart';

abstract class FeedRepository {
  Future<void> addFeedUser(String uid,Feed feed);
  Future<List<Feed>> findAll();
  Future<Feed> findById(String uid);
  Future<void> add(String uid,Feed feed, String title, String caption);
  Future<bool> isExist(String uid);
  Future<void> deleteFeeds(String uid);
  Future<void> updateFeed(Feed feed);
}
