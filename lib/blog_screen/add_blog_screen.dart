import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnhive/blog_model/blog_model.dart';
import 'package:learnhive/blog_screen/hive_box.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String imagepath = "";

  void pickImage() async {
    var pickeImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickeImage != null) {
      imagepath = pickeImage.path;
      setState(() {});
    } else {
      print("image not picked");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Blog Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: imagepath.isEmpty
                        ? Center(
                            child: Icon(
                              Icons.photo_album,
                              size: 60,
                            ),
                          )
                        : Image.file(fit: BoxFit.cover, File(imagepath)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 4,
                  controller: descriptionController,
                  decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          var data = BlogModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              image: imagepath);

                          var box = HiveBoxClass.getBlogBox();
                          setState(() {});
                          box.add(data);
                          data.save();
                          print("upload blog");
                        },
                        child: Text(
                          "Upload Blog",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
