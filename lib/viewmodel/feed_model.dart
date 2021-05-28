import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:surfing_sns/feed.dart';
import 'package:surfing_sns/user.dart';

class FeedModel extends ChangeNotifier {
  List<Feed> feeds = [];

  Future fetchFeeds() async {
    final docs = await Firestore.instance.collection("feeds").get();
    //['title] = userId 更新
    final feeds = docs.docs.map((docs) => Feed(docs)).toList();
    this.feeds = feeds;
    notifyListeners();
  }

  Future deleteFeed(Feed feed) async {
    await Firestore.instance
        .collection("feeds")
        .doc(feed.documentId)
        .delete();
  }
}
