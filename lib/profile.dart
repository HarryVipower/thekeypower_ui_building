
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

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});
  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  GlobalKey key = GlobalKey();

  Widget profileImage() {

    return Container(
      height: 175, width: 175,
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(48, 153, 117, 1), width: 10.0),
          borderRadius: BorderRadius.circular(125),
          image: const DecorationImage(
            image: AssetImage('assets/images/handshake.jpg'),
            fit: BoxFit.cover,
          )
      ),
    );
  }

  Widget profileContent() {

    TextStyle mainStyle = const TextStyle(fontSize: 18);
    TextStyle headerStyle = TextStyle(color: appColour(), fontSize: 10);

    return Container(
      margin: const EdgeInsets.all(24.0),
      width: double.infinity,
      //height: 600,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(5.0, 5.0),
            blurRadius: 24.0
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity, height: 100,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                      color: appColour()
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 12, right: 12),
                    child: Align(
                        alignment: Alignment.centerRight, child: Text('User Profile', style: TextStyle(color: Colors.white, fontSize: 30),)
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: profileImage(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 48, top: 124),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name:', style: TextStyle(color: appColour(), fontSize: 12),),
                      const Text('\$fullName', style: TextStyle(fontSize: 24),),
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Email:', style: headerStyle),
                Text('\$Email', style: mainStyle,),
                const SizedBox(height: 24,),
                Text('Approved Buildings:', style: headerStyle,),
                Text('\$approvedBuildings', style: mainStyle,),
                const SizedBox(height: 24,),
                Text('Printer IP Address:', style: headerStyle,),
                Text('\$printerIP', style: mainStyle,),
                const SizedBox(height: 24,),
                Text('Printer Model:', style: headerStyle,),
                Text('\$printerModel', style: mainStyle,),
                const SizedBox(height: 24,),
                Text('Account Created:', style: headerStyle,),
                Text('\$creationTimestamp', style: mainStyle,)
              ],
            ),
          ),
          Align(alignment: Alignment.bottomRight, child: Padding(
            padding: const EdgeInsets.only(right: 24.0, bottom: 12.0),
            child: IconButton(
              icon: const Icon(Icons.edit_document, color: Colors.black38, size: 24,),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit profile!'),));
              },
            ),
          ),)
        ],
      ),
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
          profileContent()
        ],
      ),
    );
  }
}