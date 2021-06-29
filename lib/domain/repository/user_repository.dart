import 'dart:io';
import 'package:surfing_sns/domain/entity/user.dart';
  abstract class UserRepository {
    Future<void> createUsersCollection(String uid);
    Future<String> uploadImageStorage(File imageFile, String storageId);
    Future<List<User>> findAll();
    Future<void> add(User user, String uid);
    Future<void> deleteFeeds(String uid,);
    Future<bool>isExist(String userId);
    Future<User>findById(String uid, String userId);
    Future<void>updateUser(User user);
}