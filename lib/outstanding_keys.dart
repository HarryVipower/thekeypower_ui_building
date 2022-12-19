
import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_qr_code/qr_code_handling.dart';
import 'package:test_qr_code/qr_view_in_window.dart';
import 'package:test_qr_code/records_model.dart';

import 'header_footer.dart';
import 'homepage.dart';
import 'login.dart';

class OutstandingKeys extends StatefulWidget {
  const OutstandingKeys({super.key, required this.title,});
  final String title;

  @override
  State<OutstandingKeys> createState() => _OutstandingKeysState();
}

class _OutstandingKeysState extends State<OutstandingKeys> with SingleTickerProviderStateMixin {
  GlobalKey key = GlobalKey();
  TextEditingController searchController = TextEditingController();

  //Temp record created just to test the layout of the cards
  Record testRecord = Record(
    keyCode: 'SO2os02DAprmpaatr1po',
    visitorName: 'Harry Owen',
    visitorEmail: 'harry@vipower.co.uk',
    visitorCompany: 'Vipower Limited',
    visitorPhoneNo: '02582919284',
    issueTime: DateTime.now(),
  );

  Widget displayCard() {
    return Container(
      width: double.infinity,
      height: 200,
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
                  width: double.infinity, height: 50,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                      color: appColour()
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 12, right: 12),
                    child: Align(
                        alignment: Alignment.centerRight, child: Text('Text', style: TextStyle(color: Colors.white, fontSize: 30),)
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Text('This is where the content goes'),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('Search Keys:', style: TextStyle(color: Colors.black38,),),
        const SizedBox(width: 24.0,),
        SizedBox(
          width: 250,
          child: TextField(
            controller: searchController,
          ),
        )
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
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                searchBar(),
                const Divider(),
                const SizedBox(height: 12.0,),
                displayCard(),
              ],
            )
          )
        ],
      ),
    );
  }
}