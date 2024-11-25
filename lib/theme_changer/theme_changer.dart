import 'package:flutter/material.dart';
import 'package:learnhive/theme_provider/theme_provider.dart';
import 'package:provider/provider.dart';

import 'second_screen.dart';
import 'third_screen.dart';

class ThemeChanger extends StatefulWidget {
  const ThemeChanger({super.key});

  @override
  State<ThemeChanger> createState() => _ThemeChangerState();
}

class _ThemeChangerState extends State<ThemeChanger> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  "Dark Theme",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Switch(
                    value: provider.theme,
                    onChanged: (value) {
                      provider.toogleTheme(value);
                    }),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Theme Changer With Provider "),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondScreen()));
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ThirdScreen()));
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10)),
            )
          ],
        ));
  }
}
