import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/feed.dart';
import 'package:surfing_sns/viewmodel/feed_model.dart';

import 'add_feed_model.dart';
import 'domain/repository/auth_repository.dart';
import 'domain/repository/user_repository.dart';

class AddFeedPage extends StatelessWidget {
  AddFeedPage({this.feed});
  final Feed feed;

  @override
  Widget build(BuildContext context) {
    final isUpdate = feed != null;
    final textEditingController = TextEditingController();
    if (isUpdate) {
      textEditingController.text = feed.title;
    }
    return ChangeNotifierProvider<AddFeeModel>(
        create: (_) => AddFeeModel(
          authRepository: context.read<FirebaseAuthRepository>(),
          userRepository: context.read<UserRepository>(),
          feedRepository: context.read<FeedRepository>(),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              isUpdate ? "掲示板を編集" : "掲示板を追加",
            ),
          ),
          body: Consumer<AddFeeModel>(
            builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: textEditingController,
                      onChanged: (text) {
                        model.feedTitle = text;
                      },
                    ),
                    RaisedButton(
                      child: Text(isUpdate ? "更新する" : "追加する"),
                      onPressed: () async {
                        if (isUpdate) {
                          await updateFeed(model, context);
                        } else {
                          await addFeed(model, context);
                        }
                        try {
                          await model.addFeedToFirebase();
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('保存しました'),
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
                          Navigator.of(context).pop();
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(e.toString()),
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
                      },
                    ),
                    RaisedButton(
                      onPressed: () {

                      },
                      child: Text("写真を追加"),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(5),
                      title: Text('説明'),
                      subtitle: Text(
                          '一宮、東浪見エリアで入っております！基本的には土日の午前中によく入ることが多いです。皆様のおかげで気持ちよく入れています。そのため多くの人にこの絵画kん'),
                    ),
                    Container(
                      padding: EdgeInsets.all(50),
                      child: Material(
                        color: Colors.white,
                        child: Container(
                          child: Center(
                            child: Text('エリア'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () {},
                        child: Text('Optimize Now',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  Future addFeed(AddFeeModel model, BuildContext context) async {
    try {
      await model.addFeedToFirebase();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('保存しました'),
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
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
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

  Future updateFeed(AddFeeModel model, BuildContext context) async {
    try {
      await model.updateFeed(feed);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('更新しました'),
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
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
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
}
