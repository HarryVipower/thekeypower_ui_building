
import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_qr_code/keyloanhistory.dart';
import 'package:test_qr_code/outstanding_keys.dart';
import 'package:test_qr_code/qr_code_handling.dart';
import 'package:test_qr_code/qr_view_in_window.dart';

import 'header_footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  GlobalKey key = GlobalKey();

  Widget menuWidgetRightImage(String title, AssetImage image) {

    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      width: double.infinity,
      height: 150,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 75, width: double.infinity,
              color: const Color.fromRGBO(48, 153, 117, 1),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 48),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(bottom: 6, right: 12),
              height: 125, width: 125,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromRGBO(48, 153, 117, 1), width: 10.0),
                borderRadius: BorderRadius.circular(125),
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuWidgetLeftImage(String title, AssetImage image) {

    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      width: double.infinity,
      height: 150,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 75, width: double.infinity,
              color: const Color.fromRGBO(48, 153, 117, 1),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 48),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(bottom: 6, left: 12),
              height: 125, width: 125,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(48, 153, 117, 1), width: 10.0),
                  borderRadius: BorderRadius.circular(125),
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  Key genKey() {
    return Key(generateRandomString());
  }

  Widget dismissWrapper(Widget menuItem, String direction, String destination) {
    DismissDirection dir = DismissDirection.startToEnd;

    if (direction == 'left') {
      dir = DismissDirection.endToStart;
    }

    return Dismissible(
        key: genKey(),
        direction: DismissDirection.horizontal,
        background: ColoredBox(color: const Color.fromRGBO(234, 244, 255, 1), child: Align(
            alignment: Alignment.center, child: Container(
          width: double.infinity, height: 75, color: appColour(),
        )),),
        onDismissed: (DismissDirection direction) {

        },
        confirmDismiss: (DismissDirection direction) async {
          if (destination == 'issuekey') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QRView(title: 'Title')),
            );
          }
          else if (destination == 'outstandingkeys') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OutstandingKeys(title: 'Title')),
            );
          }
          else if (destination == 'returnkey') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Going to return key'),));
          }
          else if (destination == 'keyloanhistory') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KeyLoanHistory(title: 'Title')),
            );
          }
          return false;
        },
        child: menuItem
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
          dismissWrapper(menuWidgetRightImage('Issue Key', const AssetImage('assets/images/handshake.jpg')), 'right', 'issuekey'),
          dismissWrapper(menuWidgetLeftImage('Outstanding Keys', const AssetImage('assets/images/outstanding.jpg')), 'left', 'outstandingkeys'),
          dismissWrapper(menuWidgetRightImage('Return Key', const AssetImage('assets/images/return.jpg')), 'right', 'returnkey'),
          dismissWrapper(menuWidgetLeftImage('Key Loan History', const AssetImage('assets/images/keyloan.jpg')), 'left', 'keyloanhistory'),
        ],
      ),
    );
  }
}