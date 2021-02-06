import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
                  color: Colors.deepOrange.shade700,
                  width: screenWidth * 0.8,
                )));
  }
}
