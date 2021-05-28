import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/user.dart';

class UserRepositoryImp implements UserRepository {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _users;

  void init() {
    _users = _firestore.collection('users');
  }

  @override
  Future<void> addUser(String uid, User user) async {
    // usersコレクションにuserを追加する
    _users.doc(uid).snapshots().listen((DocumentSnapshot event) async {
      if (!event.exists) {
        await _users.doc(uid).set(<String, dynamic>{
          'userId': uid,
          'displayName': user.displayName,
          'role': user.role,
          'coupleId': uid,
          'createdAt': user.createdAt,
          'updatedAt': user.updatedAt
        });
      }
    });
  }
}