import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/add_feed_page.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/feed.dart';
import 'package:surfing_sns/feed_card.dart';
import 'package:surfing_sns/viewmodel/feed_model.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedModel>(
      create: (BuildContext context) =>
      FeedModel(feedRepository: context.read<FeedRepository>())
        ..init(),
      child: Consumer<FeedModel>(
        builder: (BuildContext context, FeedModel model, Widget child) {
          final List<Feed> feedList = model.feedList;
          return Scaffold(
            appBar: AppBar(
              title: Text('掲示板'),
            ),
            body: Stack(
              children: <Widget>[
                if (feedList != null)
                  ListView(
                    padding: EdgeInsets.all(8),
                    children: _buildTodoCardList(
                      context: context,
                      feedList: feedList,
                      model: model,
                    ),
                  )
                else
                  const SizedBox(),
                if (model.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else
                  const SizedBox()
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await _pushWithReload(
                  context: context,
                  model: model,
                );
              },
              tooltip: '掲示板を追加する',
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Future<void> _pushWithReload({
    @required BuildContext context,
    @required FeedModel model,
    Feed feed,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute<AddFeedPage>(
        builder: (BuildContext context) =>
        feed != null ? AddFeedPage(feed: feed) : AddFeedPage(),
        fullscreenDialog: false,
      ),
    );
    model.init();
  }
  List<FeedCard> _buildTodoCardList({
    BuildContext context,
    List<Feed> feedList,
    FeedModel model,
  }) {
    return feedList
        .map((Feed feed) => FeedCard(
      feed: feed,
      onTap: () async {
        await _pushWithReload(
          context: context,
          feed: feed,
          model: model,
        );
      },
      delete: () async {
        await model.deleteFeeds(feed.userId);
      },
    ))
        .toList();
  }
}



