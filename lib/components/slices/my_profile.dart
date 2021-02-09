import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_cvrgu/model/user_details.dart';
import 'package:dsc_cvrgu/services/firebase_authentication.dart';
import 'package:dsc_cvrgu/utils/wave_clipper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:vibration/vibration.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  UserDetail _userDetail;

  @override
  void initState() {
    super.initState();
  }

  Future<FirebaseUser> _getUserData() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();

    DocumentSnapshot _ds = await Firestore.instance.collection("mobile_users").document(_user.uid).get();

    _userDetail = UserDetail.fromJson(_ds.data);

    return _user;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: _getUserData(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.blueGrey.shade700,
            ),
          );
        else
          return SingleChildScrollView(
            child: Container(
              height: screenHeight * 1,
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.2,
                    child: Stack(
                      children: [
                        ClipPath(
                            clipper: WaveClipper(),
                            child: Container(
                              padding: EdgeInsets.only(bottom: 50),
                              color: Colors.indigo.shade50,
                              alignment: Alignment.center,
                            )),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
                            child: Material(
                              elevation: 10.0,
                              borderRadius: BorderRadius.circular(screenWidth),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(screenWidth),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: snapshot.data.photoUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    _userDetail.name,
                    style: GoogleFonts.muli(fontSize: 24.0),
                  ),
                  Container(
                    margin: EdgeInsets.all(8.0).copyWith(left: 16.0, right: 16.0),
                    width: double.maxFinite,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(width: 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("E-mail: " + snapshot.data.email, style: GoogleFonts.muli(fontWeight: FontWeight.w600)),
                        // Text(
                        //     "Phone number: " +
                        //         ((snapshot.data.phoneNumber == "") ? "Not Provided" : snapshot.data.phoneNumber),
                        //     style: GoogleFonts.muli(fontWeight: FontWeight.w600)),
                        Text("Stream: " + _userDetail.stream, style: GoogleFonts.muli(fontWeight: FontWeight.w600)),
                        Text("Batch Year: " + _userDetail.batchYear.toString(),
                            style: GoogleFonts.muli(fontWeight: FontWeight.w600)),
                        Text("Current Year: " + _userDetail.year.toString(),
                            style: GoogleFonts.muli(fontWeight: FontWeight.w600)),
                        Text(
                            "App registartion date: " +
                                DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(_userDetail.timestamp)),
                            style: GoogleFonts.muli(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: RaisedButton(
                          color: Colors.indigoAccent,
                          onPressed: () async {
                            if (await Vibration.hasVibrator()) {
                              Vibration.vibrate(duration: 90).then((value) {
                                Authentication().handleSignOut();
                                Phoenix.rebirth(context);
                              });
                            }
                          },
                          child: Text(
                            "Log out",
                            style: GoogleFonts.muli(fontSize: 18.0, color: Colors.white),
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
      },
    );
  }
}
