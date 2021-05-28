import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
class FirebaseAuthRepositoryImp extends FirebaseAuthRepository {

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  @override
  String getUid() {
    if (_auth.currentUser == null) {
      return null;
    }
    return _auth.currentUser.uid;
  }

  @override
  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}