import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/viewmodel/feed_model.dart';

import 'add_feed_model.dart';

class AddFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddFeeModel>(
        create: (_) => AddFeeModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("掲示板を追加",),
          ),
          body: Consumer<AddFeeModel>(
            builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  TextField(
                    onChanged: (text) {
                      model.feedTitle = text;
                    },
                  ),
                  RaisedButton(
                      child: Text("追加する"),
                  onPressed: () async {
                      // TODO:firesotoreに追加
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
                    } catch(e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:  Text(e.toString()),
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
                  )
                ],
                ),
              );
            },
          ),
        )
    );
  }

}