import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dsc_cvrgu/utils/google_sign_in_button.dart';
import 'package:flutter/material.dart';

import 'services/firebase_authentication.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final Authentication _authenticationDelegate = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Image.asset('assets/images/signup.png'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Google_sign_in_button(
                  onPressed: _authenticationDelegate.handleSignIn,
                ),
                Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                )
              ],
            ),
          ),
        ));
  }
}
