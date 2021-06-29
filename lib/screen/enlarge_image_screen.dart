import 'package:flutter/material.dart';
import 'package:surfing_sns/domain/entity/feed.dart';
class EnlargeImageScreen extends StatelessWidget {
  final Feed feed;
  EnlargeImageScreen({this.feed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Hero(
          tag: 'title' + feed.title,
          child: Material(
            color: Colors.transparent,
            child: Text(
              feed.title,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'image' + feed.imageUrl,
                  child: Image.network(
                    feed.imageUrl,
                    fit: BoxFit.fitWidth,
                    height: 300,
                  ),
                ),
                Row(
                  children: [
                    Hero(
                      tag: 'caption' + feed.caption,
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          feed.caption,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
