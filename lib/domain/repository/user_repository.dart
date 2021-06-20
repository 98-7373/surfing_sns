import 'package:flutter/material.dart';
import 'package:surfing_sns/user.dart';
  abstract class UserRepository {
    Future<void> addUser(String uid, User user);
    Future<User>getUserInfoFromDbById(String uid);
    Future<void> addInvitedUser(String uid, User user, String coupleId);
}