import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_qr_code/genqr.dart';
import 'package:test_qr_code/key_registry.dart';
import 'package:test_qr_code/keyloanhistory.dart';
import 'package:test_qr_code/outstanding_keys.dart';
import 'package:test_qr_code/profile.dart';
import 'package:test_qr_code/qr_view_in_window.dart';
import 'package:test_qr_code/return_key.dart';
import 'dart:math' as m;

import 'homepage.dart';
import 'login.dart';

//Get this building name from the firestore at login
String buildingName = '6 Gracechurch Street';

Widget header() {

  return Container(
    height: 200, width: double.infinity,
    child: Column(
        children: [
          Image.asset('assets/images/keypowerlogo.png', fit: BoxFit.fitWidth,),
          Container(
              height: 60, width: double.infinity,
              color: const Color.fromRGBO(48, 153, 117, 1),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Building Name:',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      buildingName,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              )
          )
        ]
    ),
  );
}

Widget registerHeader(String accountType) {

  return Container(
    height: 200, width: double.infinity,
    child: Column(
        children: [
          Image.asset('assets/images/keypowerlogo.png', fit: BoxFit.fitWidth,),
          Container(
              height: 60, width: double.infinity,
              color: const Color.fromRGBO(48, 153, 117, 1),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$accountType',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const Text(
                      'Account Registration',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              )
          )
        ]
    ),
  );
}

Widget footer(BuildContext context) {
  return Container(
    height: 50, width: double.infinity,
    padding: const EdgeInsets.all(8),
    color: const Color.fromRGBO(48, 153, 117, 1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: const Icon(Icons.logout, size: 30,), color: Colors.white, onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage(title: 'Title')),
          );
        },),
        IconButton(icon: const Icon(Icons.home, size: 30,), color: Colors.white, onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage(title: 'Title')),
          );
        },),
        IconButton(icon: const Icon(Icons.person, size: 30), color: Colors.white, onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage(title: 'Title')),
          );
        },),
      ],
    ),
  );
}

Color appColour() {
  return const Color.fromRGBO(48, 153, 117, 1);
}

Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: appColour(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('TheKeyPower', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
              Container(margin: const EdgeInsets.all(8.0), width: double.infinity, decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 1)),),
              const Text('Menu', style: TextStyle(color: Colors.white, fontSize: 20),),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home, color: Colors.black,),
          title: const Text('Home'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage(title: 'Title')),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.key, color: Colors.black,),
          title: const Text('Issue Key'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QRView(title: 'Title')),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.key, color: Colors.black,),
          title: const Text('Return Key'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReturnKeyPage(title: 'Title')),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.add_circle_outline, color: Colors.black,),
          title: const Text('Create New Key'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GenQR(title: 'Title')),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.list_alt, color: Colors.black,),
          title: const Text('Outstanding Keys'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OutstandingKeys(title: 'Title')),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.list_alt, color: Colors.black,),
          title: const Text('Key Registry'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KeyRegistryPage(title: 'Title')),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.list_alt, color: Colors.black,),
          title: const Text('Key Loan History'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KeyLoanHistory(title: 'Title')),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.account_circle_rounded, color: Colors.black,),
          title: const Text('Profile'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage(title: 'Title')),
            );
          }
        )
      ],
    ),
  );
}

String generateRandomString() {
  int len = 10;
  var r = m.Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

//TextStyles
TextStyle headerStyle = const TextStyle(
  color: Color.fromRGBO(48, 153, 117, 1),
  fontSize: 12,
);
TextStyle contentStyle = const TextStyle(
  color: Colors.black38,
  fontSize: 14,
);