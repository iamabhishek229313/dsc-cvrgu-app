import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dsc_cvrgu/utils/google_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Image.asset(
                        'assets/images/logoVertical.png',
                        fit: BoxFit.fill,
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Image.asset('assets/images/signup.png'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Google_sign_in_button(
                    onPressed: _authenticationDelegate.handleSignIn,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ));
  }
}
