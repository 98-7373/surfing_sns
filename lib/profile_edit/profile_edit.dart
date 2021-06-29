import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/domain/entity/user.dart';
import 'package:surfing_sns/domain/repository/auth_repository.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/profile_edit/profile_edit_model.dart';

// ignore: must_be_immutable
class ProfileEdit extends StatelessWidget {
  ProfileEdit({User user, this.photoUrl}) : _user = user;
  final User _user;
  final String displayName = "";
  final String bio = "";
  final picker = ImagePicker();
  final String photoUrl;
  @override
  Widget build(BuildContext context) {
    // 詳細ページ表示の初期化処理
    final String _appBarTitle = _user != null ? '更新' : 'プロフィール作成';
    final String _buttonTitle = _user != null ? '更新' : '追加';
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _bodyController = TextEditingController();
    if (_user != null) {
      _titleController.text = _user.displayName;
      _bodyController.text = _user.bio;
    }
    return ChangeNotifierProvider<ProfileEditModel>(
      create: (_) => _user != null
          ? ProfileEditModel(
          authRepository: context.read<FirebaseAuthRepository>(),
          userRepository: context.read<UserRepository>(),
          user: _user)
          : ProfileEditModel(
          authRepository: context.read<FirebaseAuthRepository>(),
          userRepository: context.read<UserRepository>()),
      child: Consumer<ProfileEditModel>(builder: (
          BuildContext context,
          ProfileEditModel model,
          Widget child,
          ) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
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
                                    child: Center(child: Text('プロフィール写真を追加')),
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
                              Icons.create,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Flexible(
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: '名前',
                                  hintText: '名前',
                                ),
                                onChanged: (String displayName) {
                                  model.changeTitle(displayName);
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
                                  labelText: '自己紹介文',
                                  hintText: '自己紹介文',
                                ),
                                keyboardType: TextInputType.multiline,
                                minLines: 3,
                                maxLines: null,
                                onChanged: (String bio) {
                                  model.changeCaption(bio);
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
                              if (_user != null) {
                                // 更新処理
                                await model.updateUser();
                              } else {
                                // 新規追加処理
                                await model.addUserToFirebase();
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
