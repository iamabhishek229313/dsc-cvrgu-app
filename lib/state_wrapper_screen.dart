import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_cvrgu/auth_screen.dart';
import 'package:dsc_cvrgu/components/home_screen.dart';
import 'package:dsc_cvrgu/components/onboarding_screens.dart';
import 'package:dsc_cvrgu/components/registration_screen.dart';
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

    if (_prefs.getBool(AppConstants.firstTime) == null) return false;

    if (_prefs.getBool(AppConstants.firstTime) == true) return true;

    return false;
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
                  child: SpinKitFadingCircle(color: Colors.blueGrey.shade800),
                ));

          if (snapshot.data == false)
            return OnboardingScreen();
          else
            return StreamBuilder<FirebaseUser>(
                stream: FirebaseAuth.instance.onAuthStateChanged,
                builder: (context, snapshot) {
                  log("Current user data :" + snapshot.data.toString());

                  if (!snapshot.hasData)
                    return AuthScreen();
                  else
                    return CheckForRegistration();
                });
        });
  }
}

class CheckForRegistration extends StatefulWidget {
  @override
  _CheckForRegistrationState createState() => _CheckForRegistrationState();
}

class _CheckForRegistrationState extends State<CheckForRegistration> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> getRegistrationStatus() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    log("User entered registrs is : " + _user.uid.toString());
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    /// [Verify whether that documnet (in "mobile_users" Collection) is present or not.]
    DocumentSnapshot ds = await Firestore.instance.collection("mobile_users").document(_user.uid).get();
    log("DB is there :" + ds.exists.toString());

    if (ds.exists)
      log("Is Registed");
    else
      log("Is Not Registred");

    _prefs.setBool(AppConstants.isRegistered, ds.exists);

    return _prefs.getBool(AppConstants.isRegistered);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRegistrationStatus(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Scaffold(
            backgroundColor: Colors.blueGrey.shade50,
            body: Center(
              child: SpinKitFadingCircle(color: Colors.blueGrey.shade800),
            ),
          );

        /// [Home Screen].
        if (snapshot.data == true)
          return HomeScreen();
        else
          return RegistrationScreen();
      },
    );
  }
}
