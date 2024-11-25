import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnhive/blog_model/blog_model.dart';

class EditBlog extends StatefulWidget {
  final BlogModel bg;
  final String title;
  final String description;
  final String image;
  const EditBlog(
      {super.key,
      required this.bg,
      required this.description,
      required this.image,
      required this.title});

  @override
  State<EditBlog> createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  final titleController = TextEditingController();
  final desController = TextEditingController();
  String imagePath = "";
  void editImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path;
      });
    }
  }

  @override
  void initState() {
    titleController.text = widget.title;
    desController.text = widget.description;
    imagePath = widget.image;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Your Blog"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  editImage();
                },
                child: Container(
                  height: 230,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: imagePath == null
                      ? ClipRRect(
                          child: Image.file(File(imagePath)),
                        )
                      : ClipRRect(
                          child: Image.file(fit: BoxFit.cover, File(imagePath)),
                        ),
                ),
              ),
              SizedBox(
                height: h * .03,
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: h * .03,
              ),
              TextFormField(
                controller: desController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                  height: h * .06,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        widget.bg.title = titleController.text;
                        widget.bg.description = desController.text;
                        widget.bg.image = imagePath;

                        widget.bg.save().then((value) {
                          print("image upload successful");
                        });
                        setState(() {});
                      },
                      child: Text("Edit Blog")))
            ],
          ),
        ),
      ),
    );
  }
}
