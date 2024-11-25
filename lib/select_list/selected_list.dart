import 'package:flutter/material.dart';

class SelectedList extends StatefulWidget {
  const SelectedList({super.key});

  @override
  State<SelectedList> createState() => _SelectedListState();
}

class _SelectedListState extends State<SelectedList> {
  List<String> data = [
    "first screen",
    "second screen",
    "third screen",
    "fourth screen",
    "fifth screen",
    "sixth screen",
    "seventh screen",
    "eighth screen",
    "ninth screen",
    "tenth screen",
  ];

  List<bool> selected = []; // To track selected items

  @override
  void initState() {
    super.initState();
    selected = List.generate(data.length, (index) => false,
        growable: true); // Initialize as growable
  }

  @override
  Widget build(BuildContext context) {
    bool isAnySelected =
        selected.contains(true); // Check if any item is selected

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isAnySelected
              ? "${selected.where((isSelected) => isSelected).length} Selected"
              : "Select List",
          style: const TextStyle(color: Color.fromARGB(255, 219, 145, 145)),
        ),
        actions: isAnySelected
            ? [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      // Iterate in reverse to avoid index shifting issues when removing items
                      for (int i = selected.length - 1; i >= 0; i--) {
                        if (selected[i]) {
                          data.removeAt(i);
                          selected.removeAt(
                              i); // Remove the corresponding selection status
                        }
                      }
                    });
                  },
                )
              ]
            : null,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onLongPress: () {
                setState(() {
                  selected[index] = !selected[index]; // Toggle selection
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: selected[index]
                      ? Colors.blue.withOpacity(0.5)
                      : null, // Highlight if selected
                ),
                child: ListTile(
                  trailing: Text(selected[index].toString()),
                  title: Text(
                    data[index],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
