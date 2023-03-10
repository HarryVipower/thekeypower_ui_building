
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_qr_code/home.dart';
import 'package:test_qr_code/qr_code_handling.dart';

import 'header_footer.dart';

class ReturnKeyPage extends StatefulWidget {
  const ReturnKeyPage({super.key, required this.title});
  final String title;

  @override
  State<ReturnKeyPage> createState() => _ReturnKeyPageState();
}

class _ReturnKeyPageState extends State<ReturnKeyPage> with TickerProviderStateMixin {
  String _dataValue = '';
  String keyScanHead = '';
  GlobalKey key = GlobalKey();
  bool scanned = false;
  String? currentAddress;
  Position? currentPosition;
  late Widget currentWidget;

  @override
  void initState() {
    super.initState();
    currentWidget = scanKey1Content();
  }

  Widget qrCodeScanner() {

    return SizedBox(
      height: 300, width: 200,
      child: MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) {
            log('Failed to scan qr code.');
          }
          else {
            final String code = barcode.rawValue!;
            log('Found QR code: $code');
            setState(() {
              _dataValue = code;
            });
          }
        },
      ),
    );
  }

  Widget nextIconButton() {

    Widget keyScanned = IconButton(
      icon: const Icon(Icons.arrow_right),
      iconSize: 50,
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Key returned!')));
      },
    );

    Widget keyNotScanned = Container();

    if (_dataValue == '') {
      return keyNotScanned;
    }
    else {
      return keyScanned;
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled, please enable these services.')
      ));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are denied'),
        ));
        return false;
      }
    }
    if(permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are denied permanently and cannot be requested.')
      ));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((Position pos) {
      setState(() {
        currentPosition = pos;
      });
    }).catchError((e) {
      log(e);
    });
  }

  Widget scanKey1Content() {
    return AnimatedOpacity(
      opacity: scanned ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 500),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 24, right: 24),
            height: 300, width: 324,
            child: MobileScanner(
              allowDuplicates: false,
              onDetect: (barcode, args) async {
                if (barcode.rawValue == null) {
                  log('Failed to scan qr code.');
                }
                else {
                  final String code = barcode.rawValue!;
                  log('Found QR code: $code');
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  //Show a loading dialog while it scans the location
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(child: CircularProgressIndicator(),),
                  );

                  //Get the current position of the key scan action
                  //Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                  await _getCurrentPosition();
                  log(currentPosition!.latitude.toString());
                  log(currentPosition!.longitude.toString());

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Scanned code: $code')));

                  setState(() {
                    _dataValue = code;
                    keyScanHead = 'Key Scanned:';
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 12,),
          const Divider(),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Text(
              'To return a key, position the key\'s QR\ncode within the square above on your\n device\'s camera.',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12,),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        keyScanHead,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color.fromRGBO(48, 153, 117, 1),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        _dataValue,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: nextIconButton(),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget viewDecider() {

    return Stack(
      children: [
        scanKey1Content(),
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
            const SizedBox(height: 12,),
            viewDecider(),
          ]
      ),
    );
  }
}