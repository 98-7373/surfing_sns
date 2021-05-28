import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:surfing_sns/feed.dart';

class AddFeeModel extends ChangeNotifier {
  String feedTitle = "";

  Future addFeedToFirebase() async {
    if(feedTitle.isEmpty){
      throw(' タイトルを入れてください');
    }
    Firestore.instance.collection("feeds").add(
      {
      'title': feedTitle,
    },
    );
  }
  Future updateFeed(Feed feed) async {
    final document = Firestore.instance.collection('feeds').doc(feed.documentId);
    await document.update({
      'title': feedTitle,

    },
    );
    
  }

}