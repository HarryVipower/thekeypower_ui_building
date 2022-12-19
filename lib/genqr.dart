
import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_qr_code/qr_code_handling.dart';
import 'package:test_qr_code/qr_view_in_window.dart';

import 'header_footer.dart';

class GenQR extends StatefulWidget {
  const GenQR({super.key, required this.title});
  final String title;

  @override
  State<GenQR> createState() => _GenQRState();
}

class _GenQRState extends State<GenQR> with SingleTickerProviderStateMixin {
  GlobalKey key = GlobalKey();
  String qrString = 'default';
  TextEditingController keyNameController = TextEditingController();
  TextEditingController keyNumberController = TextEditingController();
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _tapDown(TapDownDetails details) {
    log('tap down');
    _controller.forward().whenComplete(() => _controller.reverse());
  }

  void _tapUp(TapUpDetails details) {
    log('tap up');
    //_controller.reverse();
  }



  Widget displayQR() {
    Widget qr = Container(margin: const EdgeInsets.all(24), child: showQRCode(qrString, key, Colors.black));
    Widget qrView = Container(
      margin: const EdgeInsets.all(24),
      height: 250, width: 250,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(48, 153, 117, 1), width: 10.0),
        borderRadius: BorderRadius.circular(125),
      ),
      child: qr,
    );
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: () {
        log('Tapped!');
        String newString = generateRandomString();
        setState(() {
          qrString = newString;
        });
      },
      child: Transform.scale(
        scale: _scale,
        child: qrView,
      ),
    );
  }

  Widget bodyContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text('Tap the QR code to generate a new code.'),
        const SizedBox(height: 12,),
        const Divider(),
        const SizedBox(height: 12,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: keyNameController,
              decoration: InputDecoration(
                hintStyle: headerStyle,
                labelStyle: headerStyle,
                border: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(48, 153, 117, 1))),
                labelText: 'Key Name',
              ),
            ),
            TextFormField(
              controller: keyNumberController,
              decoration: InputDecoration(
                hintStyle: headerStyle,
                labelStyle: headerStyle,
                border: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(48, 153, 117, 1))),
                labelText: 'Key Number',
              ),
            )
          ],
        ),
        const SizedBox(height: 12,),
        Container(
          padding: const EdgeInsets.only(top: 10),
          width: 250,
          child: ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(48, 153, 117, 1),
              shape: const StadiumBorder(),
            ),
            child: const Text(
              'Print and Save',
            ),
          ),
        ),
        const SizedBox(height: 12,),
        const Divider(),
        const Text('Your printer information can be changed later from your profile page.', textAlign: TextAlign.center,),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      backgroundColor: const Color.fromRGBO(234, 244, 255, 1),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: footer(context),
      body: ListView(
        children: [
          header(),
          Center(
            child: displayQR(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: bodyContent(),
          ),
        ],
      ),
    );
  }
}