import 'package:flutter/material.dart';
import 'package:learnhive/count_value/countBox.dart';

class CountValue extends StatefulWidget {
  const CountValue({super.key});

  @override
  State<CountValue> createState() => _CountValueState();
}

class _CountValueState extends State<CountValue> {
  int count = 0;

  @override
  void initState() {
    count = Countbox.cBox().get("count");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if (count > 0) {
                  count--;
                  var data = Countbox.cBox();
                  data.put("count", count);
                }
              });
            },
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                count++;
                var data = Countbox.cBox();
                data.put("count", count);
              });
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("Count Value Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$count",
              style: TextStyle(fontSize: 35),
            )
          ],
        ),
      ),
    );
  }
}
