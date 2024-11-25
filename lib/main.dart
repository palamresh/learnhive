import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:learnhive/blog_model/blog_model.dart';
import 'package:learnhive/model/favourite_model/favourite_model.dart';
import 'package:learnhive/model/history_model/history_model.dart';
import 'package:learnhive/qrcode/generate_qr_code.dart';
import 'package:learnhive/search_item/search_screen.dart';

import 'package:learnhive/theme_changer/theme_changer.dart';
import 'package:learnhive/theme_provider/theme_provider.dart';
import 'package:learnhive/web_service/simple_we_service/simple_api.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'blog_screen/blog_screen.dart';
import 'count_value/count_value.dart';
import 'game/game.dart';
import 'home_screen/home_screen.dart';
import 'qrcode/qr_home_screen.dart';
import 'select_list/selected_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(FavouriteModelAdapter());
  Hive.registerAdapter(HistoryModelAdapter());
  Hive.registerAdapter(BlogModelAdapter());
  await Hive.openBox("themeBox");
  await Hive.openBox<HistoryModel>("history");
  await Hive.openBox<FavouriteModel>("favourite");
  await Hive.openBox<BlogModel>("blog");
  await Hive.openBox('favouriteBlogBox');
  await Hive.openBox("countValue");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        themeMode: provider.themeMode,
        theme: ThemeData(
            appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple)),
        darkTheme:
            ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.blue)),
        debugShowCheckedModeBanner: false,
        title: 'Hive Database',
        home: QRViewExample());
  }
}
