import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  Box _settingBox;
  bool _themeChanger;
  ThemeProvider()
      : _settingBox = Hive.box("themeBox"),
        _themeChanger =
            Hive.box("themeBox").get('currentValue', defaultValue: false);
  bool get theme => _themeChanger;

  ThemeMode get themeMode => _themeChanger ? ThemeMode.dark : ThemeMode.light;
  void toogleTheme(bool value) {
    _themeChanger = value;
    _settingBox.put("currentValue", value);
    notifyListeners();
  }
}
