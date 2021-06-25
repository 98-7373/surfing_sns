import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/presentation/components/hero_image.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/domain/entity/feed.dart';
import 'package:surfing_sns/screen/enlarge_image_screen.dart';


import 'add_feed_model.dart';
import '../../domain/repository/auth_repository.dart';

// ignore: must_be_immutable
class AddFeedPage extends StatelessWidget {
  AddFeedPage({Feed feed, this.imageUrl}) : _feed = feed;
  final Feed _feed;
  final String title = "";
  final String caption = "";
  final picker = ImagePicker();
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    // 詳細ページ表示の初期化処理
    final String _appBarTitle = _feed != null ? '更新' : '新規作成';
    final String _buttonTitle = _feed != null ? '更新' : '追加';
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _bodyController = TextEditingController();
    if (_feed != null) {
      _titleController.text = _feed.title;
      _bodyController.text = _feed.caption;
    }
    return ChangeNotifierProvider<AddFeeModel>(
      create: (_) => _feed != null
          ? AddFeeModel(
              authRepository: context.read<FirebaseAuthRepository>(),
              feedRepository: context.read<FeedRepository>(),
              feed: _feed)
          : AddFeeModel(
              authRepository: context.read<FirebaseAuthRepository>(),
              feedRepository: context.read<FeedRepository>()),
      child: Consumer<AddFeeModel>(builder: (
        BuildContext context,
        AddFeeModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_appBarTitle),
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              Icons.create,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Flexible(
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: 'タイトル',
                                  hintText: 'タイトル',
                                ),
                                onChanged: (String title) {
                                  model.changeTitle(title);
                                },
                                controller: _titleController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30,
                        vertical: 30),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: 160,
                                height: 160,
                                child: InkWell(
                                  onTap: () async {
                                 final pickedFile = await picker.getImage(source: ImageSource.gallery);
                                 model.setImage(File(pickedFile.path));
                                  },
                                  child: model.imageFile != null
                                      ? Image.file(model.imageFile)
                                      : Container(
                                    child: Center(child: Text('写真を追加')),
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              Icons.description,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Flexible(
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: '詳細',
                                  hintText: '詳細',
                                ),
                                keyboardType: TextInputType.multiline,
                                minLines: 3,
                                maxLines: null,
                                onChanged: (String caption) {
                                  model.changeCaption(caption);
                                },
                                controller: _bodyController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        child: RaisedButton(
                          onPressed: () async {
                            model.startLoading();
                            try {
                              if (_feed != null) {
                                // 更新処理
                                await model.updateFeed();
                              } else {
                                // 新規追加処理
                                await model.addFeedToFirebase();
                              }
                              Navigator.pop(context);
                            } catch (e) {
                              Text('error');
                            }
                            model.endLoading();
                          },
                          child: Text(_buttonTitle),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: model.isLoading,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
