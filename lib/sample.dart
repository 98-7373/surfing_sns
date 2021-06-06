import 'package:surfing_sns/assign.dart';
import 'package:surfing_sns/feed.dart';

final DateTime now = DateTime.now();
final Feed sample = Feed(
  title: 'サンプルタスク',
  caption: 'ここにやる事の詳細を記載できます',
  assign: AssignType.none,
  deadline: now,
  createdAt: now,
  updatedAt: now,
);
