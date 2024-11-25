import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learnhive/model/favourite_model/favourite_model.dart';

import '../box/box_model.dart';

class FavauriteScreen extends StatefulWidget {
  const FavauriteScreen({super.key});

  @override
  State<FavauriteScreen> createState() => _FavauriteScreenState();
}

class _FavauriteScreenState extends State<FavauriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Screen'),
      ),
      body: ValueListenableBuilder(
        valueListenable: BoxModel.getFavourite().listenable(),
        builder: (contex, box, child) {
          final data = box.values.toList().cast<FavouriteModel>();
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
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
