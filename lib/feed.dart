import 'package:cloud_firestore/cloud_firestore.dart';

class Feed {
  Feed(DocumentSnapshot doc) {
    documentId = doc.id;
    title = doc['title'];
  }
  String documentId;
  String title;
}
