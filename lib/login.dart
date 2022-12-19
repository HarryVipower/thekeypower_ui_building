
import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_qr_code/qr_code_handling.dart';
import 'package:test_qr_code/qr_view_in_window.dart';
import 'package:test_qr_code/register.dart';

import 'header_footer.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  GlobalKey key = GlobalKey();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  String registerDropdownValue = 'User';

  Widget loginHeader() {
    return Container(
      height: 200, width: double.infinity,
      child: Column(
          children: [
            Image.asset('assets/images/keypowerlogo.png', fit: BoxFit.fitWidth,),
          ]
      ),
    );
  }

  Widget loginFields() {
    return Column(
      children: [
        TextFormField(
          controller: emailTextController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintStyle: headerStyle,
            labelStyle: headerStyle,
            border: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(48, 153, 117, 1))),
            labelText: 'Email Address',
          ),
        ),
        TextFormField(
          controller: passwordTextController,
          obscureText: true,
          decoration: InputDecoration(
            hintStyle: headerStyle,
            labelStyle: headerStyle,
            border: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(48, 153, 117, 1))),
            labelText: 'Password',
          ),
        ),
      ],
    );
  }

  Widget loginButtons() {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            //Deal with password reset for forgotten passwords
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return forgotPasswordAlert();
              }
            );
          },
          child: const Text('Forgot your password?', style: TextStyle(color: Colors.black38),),
        ),
        ElevatedButton(
          onPressed: () {
            //Login authentication, check fields are filled, check that details are valid before navigating to home page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage(title: 'Title')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(48, 153, 117, 1),
            shape: const StadiumBorder(),
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Text('Login',),
          ),
        ),
        TextButton(
          onPressed: () {
            //Navigate to account registration, first prompt user to choose to register as a manager or a regular user
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return registerSelectDialog();
              }
            );
          },
          child: const Text('Don\'t have an account yet?\nClick here to register!', style: TextStyle(color: Colors.black38), textAlign: TextAlign.center,),
        ),
        IconButton(
          icon: Icon(Icons.info, color: appColour(),),
          onPressed: () {
            //Display information on how to register for an account
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return infoAlert();
              }
            );
          },
        )
      ],
    );
  }

  Widget loginContent() {

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          loginFields(),
          const SizedBox(height: 24,),
          loginButtons()
        ],
      )
    );
  }

  AlertDialog infoAlert() {
    return AlertDialog(
      title: Column(
        children: [
          Text('TheKeyPower Information', textAlign: TextAlign.center, style: TextStyle(color: appColour()),),
          const Divider(),
        ],
      ),
      content: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
          'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', textAlign: TextAlign.center,),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Okay', style: TextStyle(color: appColour()),),
        )
      ],
    );
  }

  AlertDialog forgotPasswordAlert() {
    return AlertDialog(
      title: Column(
        children: [
          Text('Password Reset', textAlign: TextAlign.center, style: TextStyle(color: appColour())),
          const Divider(),
        ],
      ),
      content: const Text('Password reset code will go here', textAlign: TextAlign.center,),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: appColour()),),
            ),
            TextButton(
              onPressed: () {

              },
              child: Text('Confirm', style: TextStyle(color: appColour()),),
            )
          ],
        )
      ],
    );
  }

  AlertDialog registerSelectDialog() {
    return AlertDialog(
      title: Text('Select Account Type', style: TextStyle(color: appColour()), textAlign: TextAlign.center,),
      content: SizedBox(
        height: 100,
        child: Column(
          children: [
            const Text('Select which type of account to register for:', textAlign: TextAlign.center,),
            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(value: 'User',child: Text('User'),),
                DropdownMenuItem(value: 'Manager',child: Text('Manager'),),
              ],
              value: registerDropdownValue,
              onChanged: (String? value) {
                setState(() {
                  registerDropdownValue = value!;
                });
              },
            )
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                //Cancel
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: appColour()),),
            ),
            TextButton(
              onPressed: () {
                //Continue to registration
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage(title: 'Title', accountType: registerDropdownValue)),
                );
              },
              child: Text('Confirm', style: TextStyle(color: appColour()),),
            )
          ],
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
      body: ListView(
        children: [
          loginHeader(),
          loginContent()
        ],
      ),
    );
  }
}