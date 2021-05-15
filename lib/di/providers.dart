import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surfing_sns/domain/repository/db/database_manager.dart';
import 'package:surfing_sns/viewmodel/login_model.dart';
import 'package:surfing_sns/viewmodel/login_view_model.dart';
import 'package:surfing_sns/viewmodel/signup_model.dart';


List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(
    create: (_) => DatabaseManager(),
  )
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, SignUpModel>(
    update: (_, dbManager, repo) => SignUpModel(dbManager: dbManager),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(
        signUpModel: Provider.of<SignUpModel>(context, listen: false)
    ),
  ),
];
