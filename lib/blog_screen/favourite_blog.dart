import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learnhive/blog_model/blog_model.dart';

class FavouriteBlog extends StatefulWidget {
  final List favouriteList;
  final Function(BlogModel) deleteFavourite;
  const FavouriteBlog(
      {super.key, required this.favouriteList, required this.deleteFavourite});

  @override
  State<FavouriteBlog> createState() => _FavouriteBlogState();
}

class _FavouriteBlogState extends State<FavouriteBlog> {
  List fblog = [];
  removeFavouriteItem(fblogItem) {
    fblog.remove(fblogItem);
    setState(() {});
    widget.deleteFavourite(fblogItem);
  }

  @override
  void initState() {
    // TODO: implement initState

    fblog = widget.favouriteList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Blog"),
      ),
      body: ListView.builder(
          itemCount: widget.favouriteList.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image.file(
                                  fit: BoxFit.fill, File(fblog[index].image))),
                        ),
                        ListTile(
                          title: Text(fblog[index].title),
                          subtitle: Text(fblog[index].description),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: IconButton(
                              onPressed: () {
                                setState(() {});
                                removeFavouriteItem(fblog[index]);
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
