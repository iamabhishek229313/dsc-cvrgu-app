import 'dart:developer';

import 'package:dsc_cvrgu/auth_screen.dart';
import 'package:dsc_cvrgu/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateWrapperScreen extends StatefulWidget {
  @override
  _StateWrapperScreenState createState() => _StateWrapperScreenState();
}

class _StateWrapperScreenState extends State<StateWrapperScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<String> getUserId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String storesUserId = _prefs.getString(AppConstants.userID) ?? "";
    return storesUserId;
  }

  Future<bool> _isFirstTime() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(AppConstants.firstTime) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _isFirstTime(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Scaffold(
              backgroundColor: Colors.blueGrey.shade50,
              body: Center(
                child: SpinKitRotatingPlain(color: Colors.indigo.shade800),
              ),
            );

          if (snapshot.data == true)
            return OnBoardScreens();
          else
            return StreamBuilder(
                stream: FirebaseAuth.instance.onAuthStateChanged,
                builder: (context, snapshot) {
                  log("Current user data :" + snapshot.data.toString());

                  if (!snapshot.hasData)
                    return AuthScreen();
                  else
                    return CheckForRegistration(userID: snapshot.data.toString());
                });
        });
  }
}

class OnBoardScreens extends StatefulWidget {
  @override
  _OnBoardScreensState createState() => _OnBoardScreensState();
}

class _OnBoardScreensState extends State<OnBoardScreens> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CheckForRegistration extends StatefulWidget {
  final String userID;

  const CheckForRegistration({Key key, this.userID}) : super(key: key);
  @override
  _CheckForRegistrationState createState() => _CheckForRegistrationState();
}

class _CheckForRegistrationState extends State<CheckForRegistration> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> getRegistrationStatus() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(AppConstants.isRegistered) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getRegistrationStatus(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Scaffold(
              backgroundColor: Colors.blueGrey.shade50,
              body: Center(
                child: SpinKitRotatingPlain(color: Colors.indigo.shade800),
              ),
            );

          if (snapshot.data == true)
            return Container(
              color: Colors.green,
            );
          else
            return Container(
              color: Colors.red,
            );
        },
      ),
    );
  }
}
