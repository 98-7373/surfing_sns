import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:surfing_sns/feed.dart';

class FeedModel extends ChangeNotifier {
  List<Feed> feeds = [];

  Future fetchFeeds() async {
    final docs =
      await  Firestore.instance
          .collection("feeds").get();
    final feeds = docs.docs.map((docs) => Feed(docs)).toList();
    this.feeds = feeds;
    notifyListeners();
  }

}
