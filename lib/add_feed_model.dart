
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

}