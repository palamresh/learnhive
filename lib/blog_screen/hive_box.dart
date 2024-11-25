import 'package:hive/hive.dart';
import 'package:learnhive/blog_model/blog_model.dart';

class HiveBoxClass {
  static Box<BlogModel> getBlogBox() => Hive.box("blog");
  static Box getFavouriteBlogBox() => Hive.box('favouriteBlogBox');
}
