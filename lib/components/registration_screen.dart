import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_cvrgu/core/database_api.dart';
import 'package:dsc_cvrgu/model/user_details.dart';
import 'package:dsc_cvrgu/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  DatabaseAPI _db;
  SharedPreferences _prefs;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _name;
  TextEditingController _collegeName;
  TextEditingController _stream;
  TextEditingController _emailAddress;
  TextEditingController _year;
  TextEditingController _batchYear;

  @override
  void initState() {
    super.initState();
    _db = DatabaseAPI("mobile_users");
    _name = TextEditingController();
    _collegeName = TextEditingController();
    _stream = TextEditingController();
    _emailAddress = TextEditingController();
    _year = TextEditingController();
    _batchYear = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _collegeName.dispose();
    _stream.dispose();
    _emailAddress.dispose();
    _year.dispose();
    _batchYear.dispose();
    super.dispose();
  }

  _registerUser() async {
    final ProgressDialog pr = ProgressDialog(context, type: ProgressDialogType.Download);

    await pr.show();

    _prefs = await SharedPreferences.getInstance();
    String userID = _prefs.getString(AppConstants.userID);

    DocumentSnapshot ds = await Firestore.instance.collection("mobile_users").document(userID).get();

    // Make it's place there.
    FirebaseUser _user;
    await FirebaseAuth.instance.currentUser().then((user) {
      _user = user;
    });

    UserDetail userData = UserDetail(
        batchYear: int.parse(_batchYear.text),
        collegeName: _collegeName.text,
        email: _collegeName.text,
        name: _name.text,
        stream: _stream.text,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        year: int.parse(_year.text));

    await Firestore.instance.collection("mobile_users").document(userID).setData(userData.toJson());

    log("User Registered");

    _prefs.setBool(AppConstants.isRegistered, true);

    pr.hide().then((isHidden) async {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 90, amplitude: 120).then((value) => Phoenix.rebirth(context));
      }
    });

    // Navigator.pushReplacementNamed(context, '/wrapper');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () async {
          if (_formkey.currentState.validate()) {
            _registerUser();
          } else {
            setState(() {
              _autoValidate = true;
            });
            if (await Vibration.hasVibrator()) {
              Vibration.vibrate(duration: 90, amplitude: 120);
            }
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.075,
          color: Colors.redAccent.shade400,
          child: Center(
            child: Text(
              "SUBMIT",
              style: TextStyle(fontSize: 24.0, color: Colors.white, letterSpacing: 1.2),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create your account',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontWeight: FontWeight.w800, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  TextFormField(
                    controller: _name,
                    autovalidate: _autoValidate,
                    validator: (value) => value.isEmpty ? "Enter your name" : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      labelText: 'Name',
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.018,
                  ),
                  TextFormField(
                    controller: _emailAddress,
                    autovalidate: _autoValidate,
                    validator: (value) => value.isEmpty ? "Enter email address" : null,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.018,
                  ),
                  TextFormField(
                    controller: _collegeName,
                    autovalidate: _autoValidate,
                    validator: (value) => value.isEmpty ? "Mention your college name" : null,
                    decoration: InputDecoration(
                      labelText: 'College name',
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.018,
                  ),
                  TextFormField(
                    controller: _batchYear,
                    autovalidate: _autoValidate,
                    keyboardType: TextInputType.number,
                    validator: (value) => value.isEmpty ? "Enter valid batch year" : null,
                    decoration: InputDecoration(
                      labelText: 'Batch Year',
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.018,
                  ),
                  TextFormField(
                    controller: _stream,
                    autovalidate: _autoValidate,
                    validator: (value) => value.isEmpty ? "Mention your stream" : null,
                    decoration: InputDecoration(
                      labelText: 'Stream',
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.018,
                  ),
                  TextFormField(
                    controller: _year,
                    autovalidate: _autoValidate,
                    keyboardType: TextInputType.number,
                    validator: (value) => value.isEmpty ? "Enter valid current year" : null,
                    decoration: InputDecoration(
                      labelText: 'Current Year',
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
