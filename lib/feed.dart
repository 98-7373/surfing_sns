import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:surfing_sns/assign.dart';
class Feed {
  Feed(
      {
    this.title,
    this.userId,
    this.feedId,
    this.imageUrl,
    this.imageStoragePath,
    this.caption,
    this.locationString,
    this.assign,
    bool isDone,
    this.deadline,
    this.createdAt,
    this.updatedAt,
    DateTime feedTime,
  }) : _isDone = isDone;

  final String userId;
  String title;
  final String feedId;
  String imageUrl;
  String imageStoragePath;
  String caption;
  String locationString;
  bool _isDone;
  bool get isDone => _isDone;
  AssignType assign;
  DateTime deadline;
  DateTime createdAt;
  DateTime updatedAt;

  void changeCheck(bool check) {
    _isDone = check;
  }

  factory Feed.fromMap(Map<String, dynamic> map) {
    return new Feed(
      userId: map['userId'] as String,
      caption: map['caption'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      imageStoragePath: map['imageStoragePath'] as String,
      locationString: map['locationString'] as String,
      feedId: map['feedId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'userId': this.userId,
      'caption': this.caption,
      'title': this.title,
      'imageUrl': this.imageUrl,
      'imageStoragePath': this.imageStoragePath,
      'locationString': this.locationString,
      'feedId': this.feedId,
    } as Map<String, dynamic>;
  }
}
