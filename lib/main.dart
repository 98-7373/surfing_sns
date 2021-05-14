import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/di/providers.dart';
import 'package:surfing_sns/screen/home_screen.dart';
import 'package:surfing_sns/screen/login_screen.dart';
import 'package:surfing_sns/style.dart';
import 'package:surfing_sns/viewmodel/login_view_model.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    return MaterialApp(
      title: "Namido",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        buttonColor: Colors.white30,
        primaryIconTheme: IconThemeData(
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        fontFamily: RegularFont,
      ),
      home: FutureBuilder(
          future: loginViewModel.isSignIn(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          }),
    );
  }
}
