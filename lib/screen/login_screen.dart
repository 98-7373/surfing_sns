import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/screen/home_screen.dart';
import 'package:surfing_sns/view/login/login_page.dart';
import 'package:surfing_sns/view/page/signup_page.dart';
import 'package:surfing_sns/viewmodel/login_view_model.dart';
import '../button_with_icon.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LoginViewModel>(
          builder: (context, model, child) {
            return model.isLoading
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Namido',
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      ButtonWithIcon(
                        iconData: FontAwesomeIcons.swimmer,
                        label: Text('新規登録'),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return SignUpPage();
                            }
                          ),);
                        },
                      ),
                    ],
                  );
          },
        ),
      ),
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
