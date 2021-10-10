import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:surfing_sns/chat_class.dart';
import 'package:surfing_sns/domain/repository/chat_repository.dart';
import 'package:surfing_sns/domain/repository/storage_repository.dart';
import 'package:uuid/uuid.dart';

class ChatRepositoryImp implements ChatRepository {
  ChatRepositoryImp({StorageRepository storageRepository})
      : _storageRepository = storageRepository;
  final StorageRepository _storageRepository;
  File imageFile;
  final String comment = "";
  final String caption = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _chats;

  void init() {
    _chats = _firestore.collection('chats');
  }

  //TODO　新規登録時にのみ使用。
  Future<void> createChatsCollection(String uid) async {
    // chatsコレクションにfeedを追加する
    final String chatsId = uid;
    await _chats.doc(uid).set(<String, dynamic>{
    });
    // couplesコレクションの下にusersサブコレクションを追加して
    // 自分のuserIdを格納しておく
    final CollectionReference users =
    _chats.doc(chatsId).collection('users');
    users.doc().set(<String, dynamic>{
      'userId': uid,
    });
  }

  @override
  Future<void> add(Chat chat, String uid) async {
    final String getchatId = await _getChatId();
    final CollectionReference recruitment =
    _chats.doc(getchatId).collection('comment');
    await recruitment.add(<String, dynamic>{
      'comment': chat.comment,
      'commentUseId': chat.commentUserId,
      'profileId': chat.profileId,
      'commentDateTime': DateTime.now(),
      'chatId': chat.chatId,
    });
  }

  Future<void> get(Chat chat,) async {
   await _chats.doc(comment).get();

  }
  //UUid取ってきて、次追加する
  Future<void> feed(String uid, Chat chat, String caption, String title,
      String imageUrl, String feedId, File imageFile) async {
    final storageId = Uuid().v1();
    final imageUrl = await uploadImageToStorage(imageFile, storageId);
    final feed = Chat(
      chatId: Uuid().v1(),
      profileId: uid,
      comment: chat.comment,
      commentUserId: chat.commentUserId,
      commentDateTime: DateTime.now(),

    );
    await insertChat(feed);
  }
  //TODO chatに追加
  Future<void> insertChat(Chat chat) async {
    await _chats.doc(chat.commentUserId).collection("comment").add(chat.toMap());
  }

  //TODO 取得
  @override
  Future<List<Chat>> findAll() async {
    final String getchatId = await _getChatId();
    final QuerySnapshot chats =
    await _chats.doc(getchatId).collection('comment').get();
    // chatsコレクションがない場合はnullを返す
    if (chats.docs.isEmpty) {
      return null;
    }
    final List<Chat> result = chats.docs
        .map(
          (QueryDocumentSnapshot chat) => Chat(
            commentUserId: chat.id,
            comment: comment,
            profileId: chat['profileId'],
            commentDateTime: chat['commentDateTime'],
            chatId: chat['chatId'],

      ),
    )
        .toList();
    // collectionはあるが、中に一つも要素がない場合はnullが返る
    return result;
  }
  /// uidからFeedを取得する
  /// uidがドキュメントがchatsコレクションに存在するかどうかの確認
  @override
  Future<bool> isExist(String uid) async {
    final String getchatId = await _getChatId();
    final DocumentSnapshot result =
    await _chats.doc(getchatId).collection('comment').doc(uid).get();
    return result.exists;
  }

  @override
  Future<Chat> findById(String userId, String uid) async {
    final String getchatId = await _getChatId();
    final DocumentSnapshot result =
    await _chats.doc(getchatId).collection('comment').doc(userId).get();
    Chat chat;
    if (result.id == userId) {
      chat = Chat(
        commentUserId: result.id,
        comment: result['comment'],
        profileId: result['profileId'],
        commentDateTime: result['commentDateTime'],
        chatId: result['chatId'],
      );
    }
    return chat;
  }

  @override
  Future<String> uploadImageToStorage(File imageFile, String storageId) async {
    final srorageRef = FirebaseStorage.instance.ref().child(storageId);
    final uploadTask = srorageRef.putFile(imageFile);
    return await uploadTask.then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
  }

  @override
  Future<void> deleteChats(String uid) async {
    final String getchatId = await _getChatId();
    await _chats.doc(getchatId).collection('comment').doc(uid).delete();
  }

  @override
  Future<void> updateChat(Chat chat) async {
    final String getchatId = await _getChatId();
    await _chats
        .doc(getchatId)
        .collection('comment')
        .doc(chat.commentUserId)
        .update(<String, dynamic>{
      'comment': chat.comment,
      'commentUseId': chat.commentUserId,
      'profileId': chat.profileId,
      'chatId': chat.chatId,
      'commentDateTime': DateTime.now(),
    });
  }

  Future<String> _getChatId() async {
    final String getchatId =
    await _storageRepository.loadPersistenceStorage(key_couple_id);
    return getchatId;
  }
}
