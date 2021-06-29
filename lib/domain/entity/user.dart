import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class User {
  User({
    this.userId,
    this.displayName,
    this.role,
    this.coupleId,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.password,
    this.photoUrl,
    this.profileId,
    this.bio,
    this.imageStoragePath,
  });
  String profileId;
  String email;
  String password;
  String userId;
  String displayName;
  String role;
  String coupleId;
  String photoUrl;
  String bio;
  String imageStoragePath;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromMap(Map<String, dynamic> map) {
    return new User(
      userId: map['userId'] as String,
      displayName: map['displayName'] as String,
      photoUrl: map['photoUrl'] as String,
      email: map['email'] as String,
      bio: map['bio'] as String,
      imageStoragePath: map['imageStoragePath'] as String,
      profileId: map['profileId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'userId': this.userId,
      'displayName': this.displayName,
      'photoUrl': this.photoUrl,
      'email': this.email,
      'bio': this.bio,
      'imageStoragePath': this.imageStoragePath,
      'profileId': this.profileId,
    } as Map<String, dynamic>;
  }
}
