import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surfing_sns/presentation/signup/signup_page.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/infrastructure/auth_repository_imp.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/infrastructure/feed_repository_imp.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/infrastructure/user_repository_imp.dart';
import 'package:surfing_sns/main_models.dart';
import 'package:surfing_sns/presentation/login/login_page.dart';
import 'domain/repository/storage_repository.dart';
import 'infrastructure/storage_repository_imp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: <SingleChildWidget>[
      Provider<StorageRepository>(
        create: (BuildContext context) => StorageRepositoryImp(),
      ),
      Provider<FirebaseAuthRepository>(
        create: (BuildContext context) => FirebaseAuthRepositoryImp(),
      ),
      Provider<UserRepository>(
        create: (BuildContext context) => UserRepositoryImp(
          storageRepository: context.read<StorageRepository>(),
        )..init(),
      ),
      Provider<FeedRepository>(
        create: (BuildContext context) => FeedRepositoryImp(
          storageRepository: context.read<StorageRepository>(),
        )..init(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color colors = Color(0xff090a0a);
    final MainModels model = MainModels(
      authRepository: context.read<FirebaseAuthRepository>(),
      userRepository: context.read<UserRepository>(),
      feedRepository: context.read<FeedRepository>(),
      storageRepository: context.read<StorageRepository>(),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<MainModels>(
        create: (BuildContext context) => MainModels(
          feedRepository: context.read<FeedRepository>(),
          userRepository: context.read<UserRepository>(),
          authRepository: context.read<FirebaseAuthRepository>(),
          storageRepository: context.read<StorageRepository>(),
        ),
        child: Scaffold(
          body: Consumer<MainModels>(builder: (context, model, child) {
            return Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/3.png'),
                        fit: BoxFit.cover)),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.transparent,
                      Colors.transparent,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 70, right: 70),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignUpPage()));
                        },
                        color: colors,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "新規登録",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 70, right: 70),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginPage()));
                        },
                        color: colors,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "ログイン",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ]);
          }),
        ),
      ),
    );
  }
}
