import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learnhive/home_screen/box/box_model.dart';
import 'package:learnhive/model/history_model/history_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  void showCustomeDialogBox(HistoryModel his, String title, String des) {
    titleController.text = title;
    descriptionController.text = des;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Update History"),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    his.title = titleController.text;
                    his.description = descriptionController.text;
                    his.save();
                    setState(() {});
                  },
                  child: Text("Update History")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your History"),
      ),
      body: ValueListenableBuilder(
        valueListenable: BoxModel.getHistory().listenable(),
        builder: (contex, box, child) {
          final data = box.values.toList().cast<HistoryModel>();
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            data[index].delete();
                          },
                          icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            showCustomeDialogBox(data[index], data[index].title,
                                data[index].description);
                            setState(() {});
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                  title: Text(data[index].title.toString()),
                  subtitle: Text(data[index].description.toString()),
                );
              });
        },
      ),
    );
  }
}
