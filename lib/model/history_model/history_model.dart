import 'package:hive/hive.dart';
part 'history_model.g.dart';

@HiveType(typeId: 0)
class HistoryModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  HistoryModel({required this.title, required this.description});
}
