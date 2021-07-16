import 'package:flutter/material.dart';
import 'package:surfing_sns/screen/enlarge_image_screen.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 6,
          title: Text(
            'チャット',
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
              child: Column(
                children: <Widget>[
                  compliance(),
                  rightBalloon(),
                  leftBalloon(),
                  rightBalloon(),
                ],
              ),
            )),
            textInputEdit(),
          ],
        ),
      ),
    );
  }

  Container textInputEdit() {
    return Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.mic),
            iconSize: 28,
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  //自分側
  Padding rightBalloon() {
    return Padding(
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
                  const Color.fromARGB(255, 108, 132, 235),
                  const Color.fromARGB(250, 132, 119, 250),
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
                'フッっってr',
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
    );
  }

  //ユーザー側
  Padding leftBalloon() {
    return Padding(
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
              child: Text('すごい気持ちいいい'),
            ),
          ),
        ],
      ),
    );
  }

  Padding compliance() {
    return Padding(
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
    );
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
}
