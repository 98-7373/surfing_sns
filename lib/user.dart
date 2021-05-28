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
  });
  String email;
  String password;
  String userId;
  String displayName;
  String role;
  String coupleId;
  DateTime createdAt;
  DateTime updatedAt;
}
