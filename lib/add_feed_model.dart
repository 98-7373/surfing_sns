import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/feed.dart';
import 'domain/repository/auth_repository.dart';
import 'domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AddFeeModel extends ChangeNotifier {
  String feedTitle = "";
  AddFeeModel({
    @required FeedRepository feedRepository,
    Feed feed,
    FirebaseAuthRepository authRepository,
    UserRepository userRepository,
}) {
    _feedRepository = feedRepository;
    if (feed != null){
      _feed = feed;
      _userId = userId;
      _caption = caption;
      _locationString = locationString;
      _imageStoragePath = imageStoragePath;
      _imageUrl = imageUrl;
      _feedId = feedId;
    }
  }

  FeedRepository _feedRepository;
  Feed _feed;

  String _userId;
  String get userId => _userId;

  String _feedId;
  String get feedId => _feedId;

  String _imageUrl;
  String get imageUrl => _imageUrl;

  String _imageStoragePath;
  String get imageStoragePath => _imageStoragePath;

  String _caption;
  String get caption => _caption;

  String _locationString;
  String get locationString => _locationString;



  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  //TODO 新規追加処理
  Future addFeedToFirebase() async {
    if(feedTitle.isEmpty){
      throw(' タイトルを入れてください');
    }
    final Feed feed = Feed(
      userId: _userId,
      feedId: _feedId,
      caption: _caption,
      imageStoragePath: _imageStoragePath,
      imageUrl: _imageUrl,
      locationString: _locationString,
    );
    await _feedRepository.add(feed);
  }


  Future updateFeed(Feed feed) async {
    final document = Firestore.instance.collection('feeds').doc(feed.userId);
    await document.update({
      'title': feedTitle,

    },
    );
  }

}