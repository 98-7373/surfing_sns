import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:surfing_sns/domain/entity/feed.dart';
import 'package:surfing_sns/enum.dart';
import 'package:surfing_sns/screen/enlarge_image_screen.dart';
import 'package:surfing_sns/web.dart';

class FeedCard extends StatelessWidget {
  const FeedCard({
    @required Feed feed,
    this.onChangeCheck,
    this.onTap,
    this.delete,
    this.isDeletable,
    this.imageUrl, this.userId,
  }) : _feed = feed;

  final Feed _feed;
  final Function(bool) onChangeCheck;
  final Function onTap;
  final Function delete;
  final bool isDeletable;

  Feed get feed => _feed;
  final String imageUrl;
  final String userId;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            // trailing: Icon(Icons.more_vert),
            // onTap: (){
            //   Navigator.of(context).push(
            //     MaterialPageRoute(
            //       fullscreenDialog: true,
            //       builder: (BuildContext context) => Web(
            //       ),
            //     ),
            //   );
            // },
            title: Text(_feed.title,style: TextStyle(fontSize: 18),),
            subtitle: Text(_feed.caption),
            leading: PopupMenuButton(
              icon: Icon(Icons.share),
              onSelected: (value) => _onPopUpMenu(context, value),
              itemBuilder: (context) {
                if (feed.userId == userId) {
                  return [
                    PopupMenuItem(
                      value: PostMenu.DELETE,
                      child: Text('通報'),
                    ),
                    PopupMenuItem(
                      value: PostMenu.SHARE,
                      child: Text('シェア'),
                    ),
                  ];
                } else {
                  return [
                    PopupMenuItem(
                      value: PostMenu.SHARE,
                      child: Text('シェア'),
                    )
                  ];
                }
              },),
          ),
          Image.network(feed.imageUrl),
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('詳細'),
                  onPressed: ()  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext context) => EnlargeImageScreen(
                          feed: feed,
                        ),
                      ),
                    );
                  },
                ),
                FlatButton(
                  child: const Text('チャット'),
                  onPressed: onTap,
                ),
                FlatButton(
                  child: const Text('削除'),
                  onPressed: delete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onPopUpMenu(BuildContext context, PostMenu selectedMenu) {
    switch (selectedMenu) {
      case PostMenu.DELETE:
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => Web(
            ),
          ),
        );
        break;
      case PostMenu.SHARE:
        Share.share(feed.imageUrl, subject: feed.caption);
        break;
    }
  }
}
