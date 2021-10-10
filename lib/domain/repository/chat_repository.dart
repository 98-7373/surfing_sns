import 'dart:io';
import 'package:surfing_sns/chat_class.dart';

abstract class ChatRepository {
  Future<void> add(Chat chat, String uid);
  Future<void> createChatsCollection(String uid);
  Future<List<Chat>> findAll();
  Future<Chat> findById(String userId, String uid);
  Future<bool> isExist(String uid);
  Future<void> deleteChats(String uid,);
  Future<void> updateChat(Chat chat);
  Future<void> get(Chat chat,);
  Future<String> uploadImageToStorage(File imageFile, String storageId);

}