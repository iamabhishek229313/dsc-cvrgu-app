import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return ListView(
        physics: BouncingScrollPhysics(),
        children: List.generate(
            10,
            (index) => Container(
                  height: 160.0,
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  color: Colors.pinkAccent.shade700,
                  width: screenWidth * 0.8,
                )));
  }
}
