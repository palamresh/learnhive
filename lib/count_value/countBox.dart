import 'package:hive_flutter/adapters.dart';

class Countbox {
  static Box cBox() => Hive.box("countValue");
}
