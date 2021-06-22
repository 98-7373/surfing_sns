import 'package:flutter/material.dart';
import 'package:surfing_sns/components/hero_image.dart';
import 'package:surfing_sns/feed.dart';

class EnlargeImageScreen extends StatelessWidget {
  final Feed feed;

  EnlargeImageScreen({this.feed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    child: Hero(
                      tag: 'caption' + feed.caption,
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          feed.caption,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
