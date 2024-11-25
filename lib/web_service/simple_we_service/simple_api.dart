import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SimpleApi extends StatefulWidget {
  const SimpleApi({super.key});

  @override
  State<SimpleApi> createState() => _SimpleApiState();
}

class _SimpleApiState extends State<SimpleApi> {
  final String url = "https://jsonplaceholder.typicode.com/posts";
  List<dynamic> posts = [];
  int page = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    if (isLoading || !hasMoreData) return;

    setState(() {
      isLoading = true;
    });

    var response = await http.get(Uri.parse("$url?_page=$page&_limit=15"));

    if (response.statusCode == 200) {
      final List<dynamic> newPosts = jsonDecode(response.body);

      setState(() {
        if (newPosts.isNotEmpty) {
          posts.addAll(newPosts);
          page++;
        } else {
          hasMoreData = false; // No more data to fetch
        }
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please check your internet connection")));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JsonDecoder"),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              hasMoreData &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            fetchPosts(); // Fetch more posts when scrolling to the bottom
          }
          return true;
        },
        child: ListView.builder(
          itemCount: posts.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < posts.length) {
              var data = posts[index];
              return ListTile(
                title: Text(data["title"]),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
