abstract class FirebaseAuthRepository {

  Future<void> signUp(String email, String password);
  String getUid();
}