import 'package:flutter/material.dart';
import 'package:surfing_sns/domain/entity/user.dart';

class Profile extends StatelessWidget {
  const Profile({
    @required User user,
    this.photoUrl,
    this.onChangeCheck,
    this.onTap,
    this.delete,
    this.isDeletable,
  }) : _user = user;

  final User _user;

  final Function(bool) onChangeCheck;
  final Function onTap;
  final Function delete;
  final bool isDeletable;

  User get user => _user;
  final String photoUrl;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        child: Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Center(
                  child: ClipOval(
                    child: Image.network(
                      user.photoUrl,
                      height: 143,
                      width: 145,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Flexible(
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 200
                        ),
                        child: InkWell(
                          child: Text(
                            _user.displayName,
                            maxLines: 1,
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 330
                  ).copyWith(bottom: 0),
                  child: Center(
                    child: Text(
                      _user.bio,
                      style: TextStyle(fontSize: 22),
                      maxLines: 4,
                    ),
                  ),
                ),
              ),
              // ignore: deprecated_member_use
            ],
          ),
        ),
      ),
    );

  }
}
