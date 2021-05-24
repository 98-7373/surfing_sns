import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/add_feed_page.dart';
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

}
