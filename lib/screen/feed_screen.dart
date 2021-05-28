import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/add_feed_page.dart';
import 'package:surfing_sns/feed.dart';
import 'package:surfing_sns/user.dart';
import 'package:surfing_sns/viewmodel/feed_model.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedModel>(
        create: (_) => FeedModel()..fetchFeeds(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("掲示板",),
          ),
          body: Consumer<FeedModel>(
            builder: (context, model, child) {
              final feeds = model.feeds;
              final listtiles = feeds.map((feed) => ListTile(
                  title: Text(feed.title,),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {

                  //TODO画面遷移
                    await Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AddFeedPage(feed: feed,),
                      fullscreenDialog: true,
                    ),
                    );
                    model.fetchFeeds();
                  },
              ),
                onLongPress: () async{
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                    return AlertDialog(
                      title:  Text('${feed.title}削除しますか？'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          //  TODO削除API叩く
                           await deleteFeed(context, model, feed);
                          },
                        ),
                      ],
                    );
                  },
                  );
                },
              )
              ).toList();
              return ListView(
                children: listtiles,
              );
            },
          ),
          floatingActionButton: Consumer<FeedModel>(
              builder: (context, model, child){
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async  {
                  await Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AddFeedPage(),
                        fullscreenDialog: true,
                  ),
                  );
                  model.fetchFeeds();
                },
              );
            }
          ),
        )
    );
  }
  Future deleteFeed(BuildContext context, FeedModel model, Feed feed) async {
    try {
      await model.deleteFeed(feed);
      await model.fetchFeeds();
    } catch (e) {
      await _showDialog(context, e.toString());
      print(e.toString());
    }
  }

  Future _showDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
