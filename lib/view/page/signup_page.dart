import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/screen/home_screen.dart';
import 'package:surfing_sns/viewmodel/signup_model.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(
        authRepository: context.read<FirebaseAuthRepository>(),
        userRepository: context.read<UserRepository>(),
        feedRepository: context.read<FeedRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('サインアップ'),
        ),
        body: Consumer<SignUpModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'example@kboy.com',
                    ),
                    controller: mailController,
                    onChanged: (String email) {
                      model.email = email;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'パスワード',
                    ),
                    obscureText: true,
                    controller: passwordController,
                    onChanged: (String password) {
                      model.password = password;
                    },
                  ),
                  RaisedButton(
                    child: Text('登録する'),
                    onPressed: () async {
                      try {
                        await model.signUp();
                        _showDialog(context, '登録完了しました');
                      } catch (e) {
                        _showDialog(context, e.toString());
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future _showDialog(
      BuildContext context,
      String title,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => HomeScreen()
                ));
              },
            ),
          ],
        );
      },
    );
  }
}