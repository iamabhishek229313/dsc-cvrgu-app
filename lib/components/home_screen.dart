import 'package:dsc_cvrgu/components/slices/home.dart';
import 'package:dsc_cvrgu/components/slices/notifcation.dart';
import 'package:dsc_cvrgu/components/slices/qr_scanner.dart';
import 'package:dsc_cvrgu/components/slices/write.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class BottomIcons {
  final IconData icon;
  final String title;
  final int index;

  BottomIcons(this.icon, this.title, this.index);
}

class _HomeScreenState extends State<HomeScreen> {
  List<BottomIcons> _bottomPlate;
  int _currentPage;
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentPage = 0; // Home.
    _pages = [Home(), Write(), QRViewExample(), Notifications(), Container(color: Colors.red)];
    _bottomPlate = [
      BottomIcons(FeatherIcons.home, "Home", 0),
      BottomIcons(FeatherIcons.feather, "Write", 0),
      BottomIcons(Icons.qr_code_scanner_rounded, "QR Scanner", 0),
      BottomIcons(FeatherIcons.bell, "Notifications", 0),
      BottomIcons(FeatherIcons.user, "Profile", 0),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: Container(
        width: screenWidth / 5,
        height: screenHeight * 0.075,
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              _bottomPlate.length,
              (index) => InkWell(
                    onTap: () {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      height: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            _bottomPlate[index].icon,
                            size: 32.0,
                            color: _currentPage == index ? Colors.deepOrange : Colors.black,
                          ),
                          Text(
                            _bottomPlate[index].title,
                            style: TextStyle(
                              fontSize: 10.0,
                              color: _currentPage == index ? Colors.deepOrange : Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
        ),
      ),
      appBar: (_currentPage == 2) ? null : AppBar(),
      body: Container(constraints: BoxConstraints.expand(), child: _pages[_currentPage]),
    );
  }
}
