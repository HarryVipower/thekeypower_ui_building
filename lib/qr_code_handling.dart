import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

//USING flutter_barcode_scanner PACKAGE
//USING qr_flutter PACKAGE

Widget showQRCode(String code, GlobalKey key, Color color) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Center(
      child: RepaintBoundary(
        key: key,
        child: QrImage(
          data: code,
          foregroundColor: color,
          version: QrVersions.auto,
        ),
      ),
    ),
  );
}

Future<String> barcodeScan(bool mounted, BuildContext context) async {
  String barcodeScanResult;

  try {
    barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', 'Cancel', true, ScanMode.QR,
    );
  } on PlatformException {
    barcodeScanResult = 'Failed to get platform version';
  } on Exception {
    barcodeScanResult = 'Error encountered, QR code could not be scanned.';
  }
  if (!mounted) return '';

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(barcodeScanResult)));

  return barcodeScanResult;
}

Future<void> barcodeScan2(bool mounted, BuildContext context) async {
  String barcodeScanResult;

  try {
    barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', 'Cancel', true, ScanMode.QR,
    );
  } on PlatformException {
    barcodeScanResult = 'Failed to get platform version';
  } on Exception {
    barcodeScanResult = 'Error encountered, QR code could not be scanned.';
  }
  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(barcodeScanResult)));
}