import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:surfing_sns/assign.dart';
class Feed {
  Feed({
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
}
