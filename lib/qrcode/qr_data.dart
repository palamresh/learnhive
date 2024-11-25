import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrData extends StatefulWidget {
  final String qrcode;
  final String email;
  final String password;
  const QrData(
      {super.key,
      required this.qrcode,
      required this.password,
      required this.email});

  @override
  State<QrData> createState() => _QrDataState();
}

class _QrDataState extends State<QrData> {
  String yourData() {
    return "webUrl ${widget.qrcode} \n email = ${widget.email} \n passowrd = ${widget.password}";
  }

  @override
  Widget build(BuildContext context) {
    String data = yourData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Qr Code"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QrImageView(
              data: data,
              version: QrVersions.auto,
              gapless: false,
              size: 220,
              embeddedImage: NetworkImage(AutofillHints.email),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Download And Save"))
          ],
        ),
      ),
    );
  }
}
