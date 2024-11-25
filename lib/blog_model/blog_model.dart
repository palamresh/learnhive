import 'package:hive/hive.dart';
part 'blog_model.g.dart';

@HiveType(typeId: 2)
class BlogModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String image;

  BlogModel(
      {required this.title, required this.description, required this.image});
}
