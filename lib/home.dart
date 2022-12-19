
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_qr_code/qr_code_handling.dart';
import 'package:test_qr_code/qr_view_in_window.dart';

import 'draggable_practice.dart';
import 'genqr.dart';
import 'homepage.dart';
import 'login.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = TextEditingController();
  String _dataValue = '';
  GlobalKey key = GlobalKey();

  Widget appBar() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Sliver App Bar'),
          backgroundColor: Colors.green,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset('assets/images/keypowerlogo.png'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250, height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DragPractice(title: 'Title')),
                    );
                  },
                  child: const Text('Dragging Game'),
                ),
              ),
              SizedBox(
                width: 250, height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QRView(title: 'Title')),
                    );
                  },
                  child: const Text('Camera Preview in Window'),
                ),
              ),
              SizedBox(
                width: 250, height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GenQR(title: 'Title')),
                    );
                  },
                  child: const Text('Generate QR Code'),
                ),
              ),
              SizedBox(
                width: 250, height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage(title: 'Title')),
                    );
                  },
                  child: const Text('Home'),
                ),
              ),
              SizedBox(
                width: 250, height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage(title: 'Title')),
                    );
                  },
                  child: const Text('Login'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}