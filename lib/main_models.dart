

import 'package:flutter/material.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';

class MainModels {
  MainModels({
    @required FirebaseAuthRepository authRepository,
    @required UserRepository userRepository,

  }) : _authRepository = authRepository,
       _userRepository = userRepository;

  final FirebaseAuthRepository _authRepository;
  final UserRepository _userRepository;
}