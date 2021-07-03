import 'dart:io';
import 'package:surfing_sns/domain/entity/feed.dart';

abstract class FeedRepository {
  Future<void> add(Feed feed, String uid);
  Future<void> createFeedsCollection(String uid);
  Future<List<Feed>> findAll();
  Future<Feed> findById(String userId, String uid);
  Future<bool> isExist(String uid);
  Future<void> deleteFeeds(String uid,);
  Future<void> updateFeed(Feed feed);
  Future<String> uploadImageToStorage(File imageFile, String storageId);

}
