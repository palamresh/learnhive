import 'package:flutter/material.dart';

class SearchItemShow extends StatefulWidget {
  const SearchItemShow({super.key});

  @override
  State<SearchItemShow> createState() => _SearchItemShowState();
}

class _SearchItemShowState extends State<SearchItemShow> {
  final searchController = TextEditingController();
  final List<String> data = [
    "Suraj",
    "Satyam",
    "Shivema",
    "Sundarm",
    "Mohan",
    "Roshan",
    "Panjak",
    "Roshan",
    "Suman",
    "Vimalesh",
    "Vittu",
    "Arving",
    "Jeet",
    "Dipak",
    "Amit",
    "Shive",
    "Aakash",
    "Vikash",
    "Roshani",
    "Priya",
    "Sunil",
    "Sundar",
    "Makhadh",
  ];

  List<String> suggestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search List Show "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    // If search field is empty, show no data
                    suggestions.clear();
                  } else {
                    // Filter suggestions based on input
                    suggestions = data
                        .where((item) =>
                            item.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  }
                });
              },
              decoration: InputDecoration(
                hintText: "Search Item",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: searchController.text.isEmpty
                  ? const Center(
                      child: Text("Type to search items"),
                    )
                  : ListView.builder(
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(suggestions[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
