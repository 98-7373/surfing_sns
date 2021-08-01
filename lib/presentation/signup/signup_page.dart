import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/domain/repository/chat_repository.dart';
import 'package:surfing_sns/presentation/signup/signup_model.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/domain/repository/storage_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/screen/home_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    Color colors = Color(0xff909bbf);
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(
        authRepository: context.read<FirebaseAuthRepository>(),
        userRepository: context.read<UserRepository>(),
        feedRepository: context.read<FeedRepository>(),
        storageRepository: context.read<StorageRepository>(),
        chatRepository: context.read<ChatRepository>()
      )..init(uid: uid),
      child: Scaffold(
        body: Consumer<SignUpModel>(
          builder: (context, model, child) {
            return Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/2.png'),
                          fit: BoxFit.cover)),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Color(0xff161d27).withOpacity(0.9),
                        Color(0xff161d27),
                      ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 16),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 40, right: 40),
                        child: TextField(
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey.shade700),
                            filled: true,
                            fillColor: Color(0xff161d27).withOpacity(0.9),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: colors)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: colors)),
                          ),
                          controller: mailController,
                          onChanged: (String email) {
                            model.email = email;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 40, right: 40),
                        child: TextField(
                          obscureText: true,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey.shade700),
                            filled: true,
                            fillColor: Color(0xff161d27).withOpacity(0.9),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: colors)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: colors)),
                          ),
                          controller: passwordController,
                          onChanged: (String password) {
                            model.password = password;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            color: colors,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 40, right: 40),
                        child: FlatButton(
                          onPressed: () async {
                            model.startLoading();
                            try {
                              await model.signUp();
                              _showDialog(context, '登録完了しました');
                            } catch (e) {
                              await _showDialog(context, e.toString());
                              model.endLoading();
                            }
                          },
                          color: colors,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "サインイン",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                if (model.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else
                  const SizedBox()
              ],
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