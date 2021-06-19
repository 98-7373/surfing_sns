import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/screen/home_screen.dart';
import 'package:surfing_sns/viewmodel/login_model.dart';
import 'package:surfing_sns/viewmodel/signup_model.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color colors = Color(0xff909bbf);
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    return ChangeNotifierProvider<LoginModel>(
        create: (_) =>
        LoginModel(
          authRepository: context.read<FirebaseAuthRepository>(),
          userRepository: context.read<UserRepository>(),
        )
          ..init(),

        child: Scaffold(
          body: Consumer<LoginModel>(
            builder: (context, model, child) {

              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/1.png'),
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
                              try {
                                await model.login();
                                _showDialog(context, '登録完了しました');
                              } catch (e) {
                                _showDialog(context, e.toString());
                              }
                            },
                            color: colors,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              "Login",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "",
                              style:
                              TextStyle(color: colors, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              );

            },
          ),
        )



    );
  }

  Future _showDialog(BuildContext context,
      String title,) {
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