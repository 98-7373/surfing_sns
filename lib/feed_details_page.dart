import 'package:flutter/material.dart';
import 'package:surfing_sns/feed.dart';

class FeedDetailsPage extends StatelessWidget {
  FeedDetailsPage({this.feed});
  final Feed feed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO　簡易的にやっただけ
      appBar: AppBar(
        actions: [
          Icon(Icons.arrow_back),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(64),
            child: Material(
              color: Colors.white,
              child: Container(
                child: Center(
                  child: Text(feed.title),
                ),
              ),
            ),
          ),
          Image.network(
              'https://cdn.jalan.jp/jalan/img/4/kuchikomi/4184/KXL/0c069_0004184237_1.JPG'),
          //TODO 詳細
          Container(
            padding: EdgeInsets.all(0),
            child: Material(
              color: Colors.white,
              child: Container(
                child: Center(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(5),
                    subtitle: Text(
                        '一宮、東浪見エリアで入っております！基本的には土日の午前中によく入ることが多いです。皆様のおかげで気持ちよく入れています。そのため多くの人にこの絵画kん'),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(50),
            child: Material(
              color: Colors.white,
              child: Container(
                child: Center(
                  child: Text('エリア'),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
