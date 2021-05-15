//cloud_fire_storeを操作するためのクラス/今後cloud_fire_storeが無くなったとしてもDatabaseManagerを変更すれば済む
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:surfing_sns/data_models/user.dart';

class DatabaseManager {

  final FirebaseFirestore _db = FirebaseFirestore.instance;


}
