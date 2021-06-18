import 'package:flutter/material.dart';
import 'package:surfing_sns/feed.dart';

class FeedCard extends StatelessWidget {
  const FeedCard({
    @required Feed feed,
    this.onChangeCheck,
    this.onTap,
    this.delete,
    this.isDeletable,
  }) : _feed = feed;

  final Feed _feed;
  final Function(bool) onChangeCheck;
  final Function onTap;
  final Function delete;
  final bool isDeletable;

  Feed get feed => _feed;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          //TODO　写真
          Stack(
            children: [
              //TODO 写真ここに入れる
              Image.network(_feed.imageUrl,
                height: 130,
                fit: BoxFit.cover,),
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
              Container(
                child: Visibility(
                  visible: isDeletable,
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: delete,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
