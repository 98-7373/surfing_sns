import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/screen/home_screen.dart';
import 'package:surfing_sns/screen/login_screen.dart';
import 'package:surfing_sns/viewmodel/login_view_model.dart';
import 'package:surfing_sns/viewmodel/signup_view_model.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Center(
        child: Consumer<LoginViewModel>(
          builder: (context, model, child) {
            return model.isLoading
            ? CircularProgressIndicator()
            : Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: "メールアドレス",
                      hintText: "surfing@gmail.com"
                  ),
                  controller: mailController,
                  onChanged: (String email) {
                    model.email = email;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "パスワード"
                  ),
                  controller: passwordController,
                  onChanged: (String password) {
                    model.password = password;
                  },
                ),
                RaisedButton(
                  child: Text('登録する'),
                  onPressed: () => login(context),
                ),
              ],
            );

          },
        )
    )
    );
  }

  login(BuildContext context) async {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    await loginViewModel.signIn(email, password);
    if (!loginViewModel.isSuccessful) {
      Fluttertoast.showToast(msg: "サインインできません");
      return;
    }
    _openHomeScreen(context);
  }
  void _openHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }
}