import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learnhive/blog_model/blog_model.dart';
import 'package:learnhive/blog_screen/add_blog_screen.dart';
import 'package:learnhive/blog_screen/favourite_blog.dart';
import 'package:learnhive/blog_screen/hive_box.dart';

import 'update_bg_screen.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final Set<BlogModel> favouriteList = {};
  var favBox = HiveBoxClass.getFavouriteBlogBox();

  void togglefavourite(BlogModel blog) {
    if (favouriteList.contains(blog)) {
      setState(() {});
      favouriteList.remove(blog);
      favBox.delete(blog.key);
    } else {
      favouriteList.add(blog);
      favBox.put(blog.key, blog.key);
    }
  }

  void removefavouriteBlog(BlogModel blog) {
    favouriteList.remove(blog);
    favBox.delete(blog.key);
    setState(() {});
  }

  @override
  void initState() {
    var blogBox = HiveBoxClass.getBlogBox();
    var favBox = HiveBoxClass.getFavouriteBlogBox();
    setState(() {
      favouriteList.addAll(
          favBox.values.map((key) => blogBox.get(key)).cast<BlogModel>());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddBlogScreen()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavouriteBlog(
                            deleteFavourite: removefavouriteBlog,
                            favouriteList: favouriteList.toList())));
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.blue,
              ))
        ],
        title: Text(
          "Blog Screen",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: HiveBoxClass.getBlogBox().listenable(),
        builder: (context, box, child) {
          var data = box.values.toList().cast<BlogModel>();
          return ListView.builder(
              itemCount: data.length,
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
                                      fit: BoxFit.fill,
                                      File(data[index].image))),
                            ),
                            ListTile(
                              title: Text(data[index].title),
                              subtitle: Text(data[index].description),
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
                                    togglefavourite(data[index]);
                                  },
                                  icon: favouriteList.contains(data[index])
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : Icon(Icons.favorite_outline)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditBlog(
                                                  bg: data[index],
                                                  title: data[index].title,
                                                  description:
                                                      data[index].description,
                                                  image: data[index].image,
                                                )));
                                  },
                                  icon: Icon(Icons.edit)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: IconButton(
                                  onPressed: () {
                                    data[index].delete();
                                  },
                                  icon: Icon(Icons.delete)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}
