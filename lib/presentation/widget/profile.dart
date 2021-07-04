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
      child: Expanded(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
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
            Padding(
              padding: const EdgeInsets.only(
                top: 210,
                left: 30,
                right: 30,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    height: 50,
                    width: 300,
                    color: Colors.blueGrey,
                    child: Center(
                        child: Text(
                      user.displayName,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  )),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 300,
                  left: 20,
                  right: 20,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      height: 160,
                      width: 300,
                      color: Colors.pinkAccent,
                      child: Text(user.bio,
                      style: TextStyle(fontSize: 26,
                      fontWeight: FontWeight.w500,),),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
