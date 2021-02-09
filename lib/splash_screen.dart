import 'package:dsc_cvrgu/state_wrapper_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 800), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => StateWrapperScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      constraints: BoxConstraints.expand(),
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      child: Center(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1, child: Image.asset('assets/images/logoDark.png')),
      ),
    );
  }
}
