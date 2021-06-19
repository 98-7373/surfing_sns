import 'package:flutter/material.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'domain/repository/storage_repository.dart';

class MainModels extends ChangeNotifier {
  MainModels({
    @required FirebaseAuthRepository authRepository,
    @required UserRepository userRepository,
    @required FeedRepository feedRepository,
    @required StorageRepository storageRepository,
  }) : _authRepository = authRepository,
       _userRepository = userRepository,
       _feedRepository = feedRepository,
       _storageRepository = storageRepository;

  final FirebaseAuthRepository _authRepository;
  final UserRepository _userRepository;
  final FeedRepository _feedRepository;
  final StorageRepository _storageRepository;
}