import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:surfing_sns/domain/entity/feed.dart';
import 'package:surfing_sns/domain/entity/user.dart';

abstract class FeedRepository {
  Future<void> add(Feed feed, String uid);
  Future<void> createFeedsCollection(String uid);
  Future<List<Feed>> findAll();
  Future<Feed> findById(String userId, String uid);
  Future<void> feed(String uid,Feed feed, String title, String caption, String imageUrl, String feedId, File imageFile);
  Future<bool> isExist(String uid);
  Future<void> deleteFeeds(String uid,);
  Future<void> updateFeed(Feed feed);
  Future<void> insertFeed(Feed feed);
  Future<String> uploadImageToStorage(File imageFile, String storageId);
}
