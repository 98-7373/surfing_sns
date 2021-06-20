import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:surfing_sns/feed.dart';

class FeedCard extends StatelessWidget {
  const FeedCard({
    @required Feed feed,
    this.onChangeCheck,
    this.onTap,
    this.delete,
    this.isDeletable, this.imageUrl,
  }) : _feed = feed;

  final Feed _feed;
  final Function(bool) onChangeCheck;
  final Function onTap;
  final Function delete;
  final bool isDeletable;

  Feed get feed => _feed;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1),
      ),
      child: Row(
        children: <Widget>[
          //TODO　写真
          Stack(
            children: [
              //TODO 写真ここに入れる
              Image.network(imageUrl,
                height: 135,
                width: 130,
                fit: BoxFit.cover,
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 140.0,
                  ),
                  child: InkWell(
                    child: Text(
                      _feed.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: onTap,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 140,
                    top: 20,
                  ).copyWith(bottom: 0),
                  child: Text(
                    _feed.caption,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              // ignore: deprecated_member_use
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.only(
                        left: 280,
                        top: 100,
                      ),
                      //TODO マップは選択した地域の名称になる(理想はDB作って選択式にする)
                      child: const Text('マップ'),
                      //TODO Googleマップ遷移
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
