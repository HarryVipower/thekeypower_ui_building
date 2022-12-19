
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
import 'homepage.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title, required this.accountType});
  final String title;
  final String accountType;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  GlobalKey key = GlobalKey();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController refKeyController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  Widget formFields() {
    return Column(
      children: [
        TextFormField(
          controller: fullNameController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintStyle: headerStyle,
            labelStyle: headerStyle,
            border: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(48, 153, 117, 1))),
            labelText: 'Full Name',
          ),
        ),
        TextFormField(
          controller: emailAddressController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintStyle: headerStyle,
            labelStyle: headerStyle,
            border: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(48, 153, 117, 1))),
            labelText: 'Email Address',
          ),
        ),
        TextFormField(
          controller: refKeyController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintStyle: headerStyle,
            labelStyle: headerStyle,
            border: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(48, 153, 117, 1))),
            labelText: 'Reference Key',
          ),
        ),
        TextFormField(
          controller: password1Controller,
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintStyle: headerStyle,
            labelStyle: headerStyle,
            border: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(48, 153, 117, 1))),
            labelText: 'Password',
          ),
        ),
        TextFormField(
          controller: password2Controller,
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintStyle: headerStyle,
            labelStyle: headerStyle,
            border: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(48, 153, 117, 1))),
            labelText: 'Confirm Password',
          ),
        ),
      ],
    );
  }

  Widget registerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            //Cancel and navigate back to the login page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage(title: 'Title')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(48, 153, 117, 1),
            shape: const StadiumBorder(),
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Text('Cancel',),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            //Validate and register the new account using the input fields
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(48, 153, 117, 1),
            shape: const StadiumBorder(),
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Text('Register',),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String accountType = widget.accountType;

    return Scaffold(
      drawer: drawer(context),
      backgroundColor: const Color.fromRGBO(234, 244, 255, 1),
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: [
          registerHeader(accountType),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                formFields(),
                const SizedBox(height: 24.0,),
                registerButton()
              ],
            ),
          )
        ],
      ),
    );
  }
}