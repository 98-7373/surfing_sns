abstract class FirebaseAuthRepository {

  Future<void> signUp(String email, String password);
  Future<void> login(String email, String password);
  String getUid();

}