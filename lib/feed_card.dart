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
  Feed get todo => _feed;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: _feed.isDone,
            onChanged: onChangeCheck,
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(
                right: 8.0,
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
            child: Visibility(
              visible: isDeletable,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: delete,
              ),
            ),
          )
        ],
      ),
    );
  }
}