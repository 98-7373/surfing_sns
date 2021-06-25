import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/domain/entity/user.dart';

class UserRepositoryImp implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _users;
  String email = "";
  static User  currentUser;

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
          'createdAt': user.createdAt,
          'updatedAt': user.updatedAt,
          'photoUrl': user.photoUrl,
          'email': user.email,
          'bio': "",
        });
      }
    });
  }
  @override
  Future<void> addInvitedUser(String uid, User user, String coupleId) async {
    // usersコレクションにuserを追加する
    _users.doc(uid).snapshots().listen((DocumentSnapshot event) async {
      if (!event.exists) {
        await _users.doc(uid).set(<String, dynamic>{
          'userId': uid,
          'displayName': user.displayName,
          'role': user.role,
          'coupleId': coupleId,
          'createdAt': user.createdAt,
          'updatedAt': user.updatedAt
        });
      }
    });
  }

  @override
  Future<User> getUserInfoFromDbById(String uid) {
    // TODO: implement getUserInfoFromDbById
    throw UnimplementedError();
  }

  //データ取得
}