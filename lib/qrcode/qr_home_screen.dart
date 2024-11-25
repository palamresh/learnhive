import 'package:flutter/material.dart';
import 'package:learnhive/qrcode/qr_data.dart';

class QrHomeScreen extends StatefulWidget {
  const QrHomeScreen({super.key});

  @override
  State<QrHomeScreen> createState() => _QrHomeScreenState();
}

class _QrHomeScreenState extends State<QrHomeScreen> {
  final webController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR code"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: webController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QrData(
                                qrcode: webController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              )));
                },
                child: Text(
                  "Generate QR Code",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
