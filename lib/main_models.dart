

import 'package:flutter/material.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';

class MainModels {
  MainModels({
    @required FirebaseAuthRepository authRepository,
    @required UserRepository userRepository,
    @required FeedRepository feedRepository,
  }) : _authRepository = authRepository,
       _userRepository = userRepository,
       _feedRepository = feedRepository;

  final FirebaseAuthRepository _authRepository;
  final UserRepository _userRepository;
  final FeedRepository _feedRepository;
}