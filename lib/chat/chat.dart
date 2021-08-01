import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/chat/chat_model.dart';
import 'package:surfing_sns/chat_class.dart';
import 'package:surfing_sns/domain/entity/feed.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/chat_repository.dart';
import 'package:surfing_sns/domain/repository/feed_repository.dart';
import 'package:surfing_sns/domain/repository/storage_repository.dart';
import 'package:surfing_sns/screen/enlarge_image_screen.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    @required Feed feed,
    @required Chat chat,
    this.onChangeCheck,
    this.onTap,
    this.delete,
    this.isDeletable,
    this.imageUrl, this.userId,
  }) : _feed = feed,
        _chat = chat;
  //Feed
  final Feed _feed;
  final Function(bool) onChangeCheck;
  final Function onTap;
  final Function delete;
  final bool isDeletable;

  Feed get feed => _feed;
  final String imageUrl;
  final String userId;
  //Chat
  final Chat _chat;
  Chat get chat => _chat;



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatModel>(
        create: (_) => ChatModel(
              feedRepository: context.read<FeedRepository>(),
              chatRepository: context.read<ChatRepository>(),
              storageRepository: context.read<StorageRepository>(),
              authRepository: context.read<FirebaseAuthRepository>(),
            )..initChat(),
        child: Scaffold(
          body: Consumer<ChatModel>(builder: (context, model, child) {
            return Scaffold(
              appBar: AppBar(
                  backgroundColor: Theme.of(context).canvasColor,
                  elevation: 6,
                  title: Text(
                    '',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black87,
                  ),
                  //TODO 選択式に実装or popupmenuにするか検討中
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        _report(context);
                      },
                    ),
                  ]),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 32.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 28.0),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromARGB(255, 233, 233, 233),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: const Text(
                                        '誹謗中傷禁止発覚した場合は、速やかに通報し\n'
                                        'てください。管理者が確認した後にアカウント\n'
                                        'を凍結致します。',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //自分側
                            Padding(
                              padding: const EdgeInsets.only(bottom: 28.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(40),
                                      topLeft: Radius.circular(40),
                                      bottomLeft: Radius.circular(40),
                                    ),
                                    gradient: LinearGradient(
                                        begin: FractionalOffset.topLeft,
                                        end: FractionalOffset.bottomRight,
                                        colors: [
                                          const Color.fromARGB(
                                              255, 108, 132, 235),
                                          const Color.fromARGB(
                                              250, 132, 119, 250),
                                        ],
                                        stops: const [
                                          0.0,
                                          1.0,
                                        ]),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: InkWell(
                                      child: Text(
                                        'sa',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      //削除処理
                                      onLongPress: null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 28.0),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    child: ClipOval(
                                      child: Image.network(''),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromARGB(255, 233, 233, 233),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text('sa'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 68,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.camera_alt),
                            iconSize: 28,
                            color: Colors.black,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.photo_library),
                            iconSize: 28,
                            color: Colors.black,
                            onPressed: () {},
                          ),
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextField(
                                onChanged: (String comment) {
                                  model.commentTitle(comment);
                                },
                                autofocus: true,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                          ),
                          //追加処理
                          IconButton(
                            icon: Icon(Icons.check_circle_sharp),
                            iconSize: 28,
                            color: Colors.black,
                            onPressed: () async {
                              model.startLoading();
                              try {
                                if (_chat != null) {
                                  // 更新処理
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
                          ),
                        //  TODO fecth
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}

//通報
Future _report(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("通報しますか？"),
        content: Text("この発言が誹謗中傷、またはコンプライアンスに反してると判断した"),
        actions: <Widget>[
          // ボタン領域
          FlatButton(
            child: Text("キャンセル"),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
            child: Text("通報する"),
            //TODO 通報or　HTMLに飛ばすページに遷移
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (BuildContext context) => EnlargeImageScreen(),
              ),
            ),
          ),
        ],
      );
    },
  );
}
