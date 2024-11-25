import 'package:hive/hive.dart';
import 'package:learnhive/model/favourite_model/favourite_model.dart';
import 'package:learnhive/model/history_model/history_model.dart';

class BoxModel {
  static Box<HistoryModel> getHistory() => Hive.box<HistoryModel>("history");

  static Box<FavouriteModel> getFavourite() =>
      Hive.box<FavouriteModel>("favourite");
}
