import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:surfing_sns/domain/repository/storage_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/domain/entity/user.dart';

class UserRepositoryImp implements UserRepository {
  UserRepositoryImp({StorageRepository storageRepository})
      : _storageRepository = storageRepository;
  final StorageRepository _storageRepository;
  File imageFile;
  final String displayName = "";
  final String bio = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _users;
  String email = "";
  static User  currentUser;


  void init() {
    _users = _firestore.collection('users');
  }

  //TODO　新規登録時にのみ使用。
  Future<void> createUsersCollection(String uid) async {
    // feedsコレクションにfeedを追加する
    final String usersId = uid;
    await _users.doc(uid).set(<String, dynamic>{
    });
    // couplesコレクションの下にusersサブコレクションを追加して
    // 自分のuserIdを格納しておく
    final CollectionReference users =
    _users.doc(usersId).collection('newuser');
    users.doc().set(<String, dynamic>{
      'userId': uid,
    });
  }
  Future<List<User>> findAll() async {
    final String getfeedId = await _getFeedId();
    final QuerySnapshot users =
    await _users.doc(getfeedId).collection('profile').get();
    // todosコレクションがない場合はnullを返す
    if (users.docs.isEmpty) {
      return null;
    }
    final List<User> result = users.docs
        .map(
          (QueryDocumentSnapshot user) =>
          User(
            userId: user['userId'],
            displayName: user['displayName'],
            photoUrl: user['photoUrl'],
            bio: user['bio'],
            imageStoragePath: user['imageStoragePath'],
          ),
    )
        .toList();
    // collectionはあるが、中に一つも要素がない場合はnullが返る
    return result;
  }
  /// ドキュメントfeeds削除処理
  @override
  Future<void> deleteFeeds(String uid,) async {
    final String getfeedId = await _getFeedId();
    await _users.doc(getfeedId).collection('profile').doc(uid).delete();
  }


  @override
  Future<void> add(User user, String uid) async {
    final String getfeedId = await _getFeedId();
    final CollectionReference recruitment =
    _users.doc(getfeedId).collection('profile');
    await recruitment.add(<String, dynamic>{
      'userId': user.userId,
      'bio': user.bio,
      'photoUrl': user.photoUrl,
      'imageStoragePath': user.imageStoragePath,
      'profileId': user.profileId,
      'displayName': user.displayName,
    });
  }

  @override
  Future<User> findById(String uid, String userId) async {
    final String getfeedId = await _getFeedId();
    final DocumentSnapshot result =
        await _users.doc(getfeedId).collection('profile').doc(userId).get();
    User user;
    if (result.id == userId) {
      user = User(
        userId: getfeedId,
        displayName: result['displayName'],
        photoUrl: result['photoUrl'],
        bio: result['bio'],
        imageStoragePath: result['imageStoragePath'],
      );
    }
    return user;
  }

  @override
  Future<bool> isExist(String userId) async {
    final String getfeedId = await _getFeedId();
    final DocumentSnapshot result =
        await _users.doc(getfeedId).collection('profile').doc(userId).get();
    return result.exists;
  }

  @override
  Future<void> updateUser(User user) async {
    final String getfeedId = await _getFeedId();
    await _users
        .doc(getfeedId)
        .collection('profile')
        .doc(user.userId)
        .update(<String, dynamic>{
      'userId': user.userId,
      'bio': user.bio,
      'photoUrl': user.photoUrl,
      'imageStoragePath': user.imageStoragePath,
      'profileId': user.profileId,
      'displayName': user.displayName,
    });
  }
  Future<String> _getFeedId() async {
    final String getfeedId =
    await _storageRepository.loadPersistenceStorage(key_couple_id);
    return getfeedId;
  }

  @override
  Future<String> uploadImageStorage(File imageFile, String storageId) async {
    final srorageRef = FirebaseStorage.instance.ref().child(storageId);
    final uploadTask = srorageRef.putFile(imageFile);
    return await uploadTask.then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
  }
}
