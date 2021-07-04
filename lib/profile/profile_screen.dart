import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:surfing_sns/chat/chat.dart';
import 'package:surfing_sns/domain/entity/user.dart';
import 'package:surfing_sns/domain/repository/user_repository.dart';
import 'package:surfing_sns/presentation/widget/profile.dart';
import 'package:surfing_sns/profile/profile_model.dart';
import 'package:surfing_sns/profile_edit/profile_edit.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileModel>(
      create: (BuildContext context) =>
      ProfileModel(
        userRepository: context.read<UserRepository>(),)
        ..init(),
      child: Consumer<ProfileModel>(
        builder: (BuildContext context, ProfileModel model, Widget child) {
          final List<User> userList = model.userList;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('プロフィール'),
              backgroundColor: Colors.blueGrey,
            ),
            body: Stack(
              children: <Widget>[
                if (userList != null)
                  Container(
                    child: ListView(
                      padding: EdgeInsets.all(8),
                      children: _buildTodoCardList(
                        context: context,
                        userList: userList,
                        model: model,
                      ),
                    ),
                  )
                else
                  const SizedBox(),
                if (model.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else
                  const SizedBox()
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black38,
              onPressed: () async {
                await _pushWithReload(
                  context: context,
                  model: model,
                );
              },
              tooltip: '掲示板を追加する',
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Future<void> _pushWithReload({
    @required BuildContext context,
    @required ProfileModel model,
    User user,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute<ProfileEdit>(
        builder: (BuildContext context) =>
        user != null ? ProfileEdit(user: user) : ProfileEdit(),
        fullscreenDialog: false,
      ),
    );
    model.init();
  }
  List<Profile> _buildTodoCardList({
    BuildContext context,
    List<User> userList,
    ProfileModel model,
  }) {
    return userList
        .map((User user) => Profile(
      user: user,
      photoUrl: user.photoUrl,
      onTap: () async {
        await _pushWithReload(
          context: context,
          user: user,
          model: model,
        );
      },
      delete: () async {
        await model.deleteFeeds(user.userId);
      },
    ))
        .toList();
  }
}