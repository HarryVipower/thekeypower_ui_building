
import 'dart:async';
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

class DragPractice extends StatefulWidget {
  const DragPractice({super.key, required this.title});
  final String title;

  @override
  State<DragPractice> createState() => _DragPracticeState();
}

class _DragPracticeState extends State<DragPractice> {
  //GlobalKey key = GlobalKey();
  int value = 100;

  Widget blazingFire() {
    Widget blazingFire = Container();

    //Depending on value, change the contents of waterBucket
    if (value >= 80) {
      blazingFire = Center(child: Column(children: const [
        Icon(Icons.local_fire_department_rounded, color: Colors.white,),
        Text('Burning violently!'),
      ],),);
    }
    else if (value >= 60) {
      blazingFire = Center(child: Column(children: const [
        Icon(Icons.local_fire_department_rounded, color: Colors.white,),
        Text('Burning!'),
      ],),);
    }
    else if (value >= 40) {
      blazingFire = Center(child: Column(children: const [
        Icon(Icons.local_fire_department_rounded, color: Colors.white,),
        Text('The Fires are settling...'),
      ],),);
    }
    else if (value >= 20) {
      blazingFire = Center(child: Column(children: const [
        Icon(Icons.local_fire_department_rounded, color: Colors.white,),
        Text('Keep going!'),
      ],),);
    }
    else if (value > 0) {
      blazingFire = Center(child: Column(children: const [
        Icon(Icons.local_fire_department_rounded, color: Colors.white,),
        Text('The fire is almost out!'),
      ],),);
    }
    else {
      blazingFire = Center(child: Column(children: const [
        Icon(Icons.check, color: Colors.white,),
        Text('Fire extinguished!'),
      ],),);
    }


    return blazingFire;
  }

  Widget target() {

    return DragTarget<int>(builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
      return Container(
        height: 100, width: 100,
        color: Colors.orange,
        child: blazingFire(),
      );
    },
    onAccept: (int data) {
      setState(() {
        value -= data;
      });
    },);
  }

  Widget dragger() {
    return Draggable(
      data: 5,
      feedback: Container(
        color: Colors.cyan,
        height: 50, width: 50,
        child: const Icon(Icons.water_drop_rounded, color: Colors.white,),
      ),
      childWhenDragging: Container(
        height: 100, width: 100,
        color: Colors.brown,
        child: const Text('Empty bucket'),
      ),
      child: Container(
        height: 100, width: 100,
        color: Colors.blueAccent,
        child: const Center(
          child: Text('Filled bucket')
        ),
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
          Flexible(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  target(),
                  const SizedBox(height: 200,),
                  dragger(),
                  const SizedBox(height: 24,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}