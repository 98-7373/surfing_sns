import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/auth_repository_imp.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository_imp.dart';
import 'package:surfing_sns/main_models.dart';
import 'package:surfing_sns/screen/feed_screen.dart';
import 'package:surfing_sns/view/login/login_page.dart';
import 'package:surfing_sns/view/page/signup_page.dart';
import 'package:surfing_sns/viewmodel/login_model.dart';


import 'di/providers.dart';
import 'main_model.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      MultiProvider(
        providers: <SingleChildWidget>[
          Provider<FirebaseAuthRepository>(
            create: (BuildContext context) => FirebaseAuthRepositoryImp(),
          ),
          Provider<UserRepository>(
            create: (BuildContext context) => UserRepositoryImp()..init(),
          ),
        ],
            child: MyApp(),
      )
  );

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainModels models = MainModels(
      authRepository: context.read<FirebaseAuthRepository>(),
          userRepository: context.read<UserRepository>(),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text('ログイン'),
          ),
          body: Consumer<MainModel>(builder: (context, model, child) {
            return Center(
              child: Column(
                children: [
                  RaisedButton(
                    child: Text('新規登録'),
                    onPressed: () {
                      // ここでなにか
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                  ),
                  Text(
                    model.suzuki,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  RaisedButton(
                    child: Text('押して'),
                    onPressed: () {
                      model.Changesuzuki();
                    },
                  ),
                  RaisedButton(
                    child: Text('ログイン'),
                    onPressed: () {
                      // ここでなにか
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text('Feed'),
                    onPressed: () {
                      // ここでなにか
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FeedScreen()),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
