import 'package:hive/hive.dart';
part 'favourite_model.g.dart';

@HiveType(typeId: 1)
class FavouriteModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  FavouriteModel({required this.title, required this.description});
}
