import 'package:flutter/material.dart';

class Write extends StatefulWidget {
  @override
  _WriteState createState() => _WriteState();
}

class _WriteState extends State<Write> {
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
                  color: Colors.indigoAccent.shade700,
                  width: screenWidth * 0.8,
                )));
  }
}
