import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surfing_sns/domain/repository/db/database_manager.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/viewmodel/login_view_model.dart';

// ①:アプリで使う全て
List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];
// ②:他のどのクラスにも依存しない
List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(create: (_) => DatabaseManager()
  ),
];
// ③:②で登録したクラスに依存
List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager,UserRepository>(
      update: (_, dbManager, repo) => UserRepository(dbManager: dbManager),
  ),
];
// ④:UIから直接使う（参照）②、③で登録したクラスは使える
List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(
        userRepository: Provider.of<UserRepository>(context, listen: false)
      ),
  ),
];
