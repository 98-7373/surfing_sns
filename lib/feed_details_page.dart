import 'package:flutter/material.dart';
import 'package:surfing_sns/feed.dart';

class FeedDetailsPage extends StatelessWidget {
  FeedDetailsPage({this.feed});
  final Feed feed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("FeedDetailsPage")),
    );
  }
  }
