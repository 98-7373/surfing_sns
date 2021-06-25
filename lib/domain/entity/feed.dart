
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Feed {
  String title;
  String imageUrl;
  String caption;
  String userId;
  String feedId;
  String imageStoragePath;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Feed({
    @required this.title,
    @required this.imageUrl,
    @required this.caption,
    @required this.userId,
    @required this.feedId,
    @required this.imageStoragePath,
  });

  Feed copyWith({
    String title,
    String imageUrl,
    String caption,
    String userId,
    String feedId,
    String imageStoragePath,
  }) {
    return new Feed(
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      caption: caption ?? this.caption,
      userId: userId ?? this.userId,
      feedId: feedId ?? this.feedId,
      imageStoragePath: imageStoragePath ?? this.imageStoragePath,
    );
  }

  @override
  String toString() {
    return 'Feed{title: $title, imageUrl: $imageUrl, caption: $caption, userId: $userId, feedId: $feedId, imageStoragePath: $imageStoragePath}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Feed &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          imageUrl == other.imageUrl &&
          caption == other.caption &&
          userId == other.userId &&
          feedId == other.feedId &&
          imageStoragePath == other.imageStoragePath);

  @override
  int get hashCode =>
      title.hashCode ^
      imageUrl.hashCode ^
      caption.hashCode ^
      userId.hashCode ^
      feedId.hashCode ^
      imageStoragePath.hashCode;

  factory Feed.fromMap(Map<String, dynamic> map) {
    return new Feed(
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      caption: map['caption'] as String,
      userId: map['userId'] as String,
      feedId: map['feedId'] as String,
      imageStoragePath: map['imageStoragePath'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'title': this.title,
      'imageUrl': this.imageUrl,
      'caption': this.caption,
      'userId': this.userId,
      'feedId': this.feedId,
      'imageStoragePath': this.imageStoragePath,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}