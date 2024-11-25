import 'package:flutter/material.dart';
import 'package:learnhive/home_screen/box/box_model.dart';
import 'package:learnhive/home_screen/favourite/favaurite_screen.dart';
import 'package:learnhive/home_screen/history/history_screen.dart';
import 'package:learnhive/model/favourite_model/favourite_model.dart';
import 'package:learnhive/model/history_model/history_model.dart';
import 'package:learnhive/theme_provider/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(
                "Dark Theme",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Switch(
                  value: provider.theme,
                  onChanged: (value) {
                    provider.toogleTheme(value);
                  }),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavauriteScreen()));
              },
              title: Text("Your Favourite"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()));
              },
              title: Text("Your History"),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              maxLines: 4,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      var data = HistoryModel(
                          title: titleController.text,
                          description: descriptionController.text);
                      final box = BoxModel.getHistory();
                      box.add(data);
                      data.save();
                      titleController.clear();
                      descriptionController.clear();
                    },
                    child: Text("Save Data")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      var data = FavouriteModel(
                          title: titleController.text,
                          description: descriptionController.text);
                      final box = BoxModel.getFavourite();
                      box.add(data);
                      data.save();
                    },
                    child: Text("Favourite")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      setState(() {
                        titleController.clear();
                        descriptionController.clear();
                      });
                    },
                    child: Text("Clear ")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
