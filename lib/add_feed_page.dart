import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/assign.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/feed.dart';
import 'package:surfing_sns/select_assingn_page.dart';
import 'package:surfing_sns/viewmodel/feed_model.dart';

import 'add_feed_model.dart';
import 'domain/repository/auth_repository.dart';

class AddFeedPage extends StatelessWidget {
  const AddFeedPage({Feed feed}) : _feed = feed;
  final Feed _feed;

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
          feedRepository: context.read<FeedRepository>(), feed: _feed)
          : AddFeeModel(
          authRepository: context.read<FirebaseAuthRepository>(),
          feedRepository: context.read<FeedRepository>()),
      child: Consumer<AddFeeModel>(
          builder: (BuildContext context, AddFeeModel model, Widget child) {
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
                                    onChanged: (String feedTitle) {
                                      model.changeTitle(feedTitle);
                                    },
                                    controller: _titleController,
                                  ),
                                ),
                              ],
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
                                    minLines: 2,
                                    maxLines: null,
                                    onChanged: (String captionTitle) {
                                      model.changeCaption(captionTitle);
                                    },
                                    controller: _bodyController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 30,
                              left: 20,
                              right: 20,
                            ),
                            child: InkWell(
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                    const Text('なし'),
                                ],
                              ),
                              onTap: () async {
                                await _selectDate(context, model);
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 30,
                              left: 20,
                              right: 20,
                            ),
                            child: InkWell(
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.account_circle,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                    const Text('なし'),
                                ],
                              ),
                              onTap: () async {
                                final AssignType assign =
                                await _showAssignDialog(context: context);
                                model.changeAssign(assign);
                              },
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

  Future<void> _selectDate(BuildContext context, AddFeeModel model) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2031),
    );
    model.changeDeadline(selected);
  }
Future<AssignType> _showAssignDialog({@required BuildContext context}) async {
  final AssignType result = await showDialog<AssignType>(
    context: context,
    builder: (BuildContext context) {
      return SelectAssignDialog();
    },
  );
  return result;
}
}


