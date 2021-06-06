import 'package:flutter/material.dart';
import 'package:surfing_sns/assign.dart';

class SelectAssignDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('どなたのタスクですか？'),
      children: <Widget>[
        SimpleDialogOption(
          child: ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text(AssignType.father.jpnValue),
          ),
          onPressed: () {
            Navigator.pop(
              context,
              AssignType.father,
            );
          },
        ),
        SimpleDialogOption(
          child: ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text(AssignType.mother.jpnValue),
          ),
          onPressed: () {
            Navigator.pop(
              context,
              AssignType.mother,
            );
          },
        ),
        SimpleDialogOption(
          child: ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text(AssignType.none.jpnValue),
          ),
          onPressed: () {
            Navigator.pop(
              context,
              AssignType.none,
            );
          },
        ),
      ],
    );
  }
}