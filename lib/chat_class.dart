import 'package:flutter/material.dart';

class Chat {
  String comment;
  DateTime commentDateTime;
  String commentUserId;
  String profileId;
  String chatId;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Chat({
    @required this.comment,
    @required this.commentDateTime,
    @required this.commentUserId,
    @required this.profileId,
    @required this.chatId,
  });

  Chat copyWith({
    String comment,
    DateTime commentDateTime,
    String commentUserId,
    String profileId,
    String chatId,
  }) {
    return new Chat(
      comment: comment ?? this.comment,
      commentDateTime: commentDateTime ?? this.commentDateTime,
      commentUserId: commentUserId ?? this.commentUserId,
      profileId: profileId ?? this.profileId,
      chatId: chatId ?? this.chatId,
    );
  }

  @override
  String toString() {
    return 'Chat{comment: $comment, commentDateTime: $commentDateTime, commentUserId: $commentUserId, profileId: $profileId, chatId: $chatId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat &&
          runtimeType == other.runtimeType &&
          comment == other.comment &&
          commentDateTime == other.commentDateTime &&
          commentUserId == other.commentUserId &&
          profileId == other.profileId &&
          chatId == other.chatId);

  @override
  int get hashCode =>
      comment.hashCode ^
      commentDateTime.hashCode ^
      commentUserId.hashCode ^
      profileId.hashCode ^
      chatId.hashCode;

  factory Chat.fromMap(Map<String, dynamic> map) {
    return new Chat(
      comment: map['comment'] as String,
      commentDateTime: map['commentDateTime'] as DateTime,
      commentUserId: map['commentUserId'] as String,
      profileId: map['profileId'] as String,
      chatId: map['chatId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'comment': this.comment,
      'commentDateTime': this.commentDateTime,
      'commentUserId': this.commentUserId,
      'profileId': this.profileId,
      'chatId': this.chatId,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}