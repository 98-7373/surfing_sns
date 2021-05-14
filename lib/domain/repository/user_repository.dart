import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:surfing_sns/data_models/user.dart';
import 'db/database_manager.dart';

class UserRepository {
  final DatabaseManager dbManager;
  UserRepository({this.dbManager});

  static User currentUser;
  final String email = '';
  final String password = '';

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  //isSignInする事で、新規ログイン実装を省く

  Future<bool> isSignIn() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;
    }
    return false;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      if (email == null || email.isEmpty) {
        throw ('メールアドレスを入力してください');
      }
      if (password == null || password.isEmpty) {
        throw ('パスワードを入力してください');
      }
      final firebaseUser  = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;

      if (firebaseUser == null) {
        return false;
      }
      final isUserExistedInDb = await dbManager.searchUserInDb(firebaseUser);
      if (!isUserExistedInDb) {
        await dbManager.insertUser(_convertToUser(firebaseUser));
      }
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;
    } catch(error) {
      print("サインインエラー");
      return false;
    }
  }

  //Userクラスを変換させる
  _convertToUser(auth.User firebaseUser) {
     return User(
       userId: firebaseUser.uid,
       displayName: firebaseUser.displayName,
       inAppUserName: firebaseUser.displayName,
       photoUrl: firebaseUser.photoURL,
       email: firebaseUser.email,
       password: "",
       bio: "",
     );
  }
}