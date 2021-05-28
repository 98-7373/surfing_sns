import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/feed.dart';
import 'package:surfing_sns/viewmodel/feed_model.dart';

import 'add_feed_model.dart';

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
        create: (_) => AddFeeModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(isUpdate ? "掲示板を編集" : "掲示板を追加",),
          ),
          body: Consumer<AddFeeModel>(
            builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  TextField(
                   controller: textEditingController,
                    onChanged: (text) {
                      model.feedTitle = text;
                    },
                  ),
                  RaisedButton(
                      child: Text(isUpdate ? "更新する" : "追加する"),
                  onPressed: () async {
                        if(isUpdate) {
                         await updateFeed(model, context);
                        }else {
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
                  ),
                ],
                ),
              );
            },
          ),
        )
    );
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
   Future updateFeed(AddFeeModel model, BuildContext context)async {
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