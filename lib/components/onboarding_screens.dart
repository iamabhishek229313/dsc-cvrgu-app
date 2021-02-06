import 'package:dsc_cvrgu/utils/constants.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vibration/vibration.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController;
  bool _showFAB;
  List<String> _imagesURLs;
  List<String> _overHeadings;
  List<String> _texts;
  List<Color> _colors;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _showFAB = false;
    _imagesURLs = [
      "assets/images/onbr1.png",
      "assets/images/onbr2.png",
      "assets/images/onbr3.png",
      "assets/images/onbr4.png",
    ];
    _overHeadings = ["Getting Started", "Worries?", "1 on 1 Mentorship", "Let's Go"];

    _texts = [
      'Ready to unleash the power of a community? Join us',
      'DSC-CVRGU provides a platform to learn all the exciting technologies which you have been wishing for.',
      'Our core team is determined to help our students whenever they need can contact us.',
      'So what are you waiting for? Let the awesomeness begin.'
    ];
    _colors = [Colors.pinkAccent.shade400, Colors.indigoAccent.shade100, Colors.orangeAccent.shade400, Colors.brown];
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _showFAB
          ? FloatingActionButton.extended(
              elevation: 30.0,
              onPressed: () async {
                // Below code will a make boolean value in the device memory saying user have
                // gone through the onboard screens.
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool(AppConstants.firstTime, true).then((value) {
                  print("Saved Preference as a value of = " + value.toString());
                });
                if (await Vibration.hasVibrator()) {
                  Vibration.vibrate(duration: 80, amplitude: 120).then((value) => Phoenix.rebirth(context));
                }

                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => StateWrapperScreen()));
              },
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              label: Text(
                "Let's Go",
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
      body: LiquidSwipe(
        enableLoop: false,
        enableSlideIcon: true,
        slideIconWidget: Container(
          margin: EdgeInsets.only(right: 12.0),
          child: Icon(
            FeatherIcons.arrowLeft,
            color: Colors.black,
            size: 34.0,
          ),
        ),
        onPageChangeCallback: (activePageIndex) {
          if (activePageIndex == 3)
            setState(() {
              _showFAB = true;
            });
          else
            setState(() {
              _showFAB = false;
            });
        },
        pages: List.generate(
            _imagesURLs.length,
            (index) => Container(
                  color: _colors[index],
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.1,
                        ),
                        SizedBox(
                          height: screenHeight * 0.4,
                          child: Image.asset(
                            _imagesURLs[index],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Text(
                          _overHeadings[index],
                          style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w800, color: Colors.black),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Text(
                          _texts[index],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                )),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _showFAB
          ? FloatingActionButton.extended(
              elevation: 10.0,
              onPressed: () async {
                // Below code will a make boolean value in the device memory saying user have
                // gone through the onboard screens.
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool(AppConstants.firstTime, true).then((value) {
                  print("Saved Preference as a value of = " + value.toString());
                });
                Phoenix.rebirth(context);
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => StateWrapperScreen()));
              },
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              label: Text(
                "Let's Go",
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1, child: Image.asset('assets/images/logo.png')),
            Container(
              color: Colors.red,
              height: screenHeight * 0.7,
              child: PageView(
                controller: _pageController,
                children: List.generate(
                    _imagesURLs.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.4,
                                child: Image.asset(
                                  _imagesURLs[index],
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _overHeadings[index],
                                      style:
                                          TextStyle(fontSize: 34.0, fontWeight: FontWeight.w800, color: Colors.black),
                                    ),
                                    Text(
                                      _texts[index],
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                onPageChanged: (int _pageIndex) {
                  if (_pageIndex == 3) {
                    setState(() {
                      _showFAB = true;
                    });
                  } else
                    setState(() {
                      _showFAB = false;
                    });
                },
              ),
            ),
            SizedBox(height: 32.0),
            Container(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 4,
                effect: WormEffect(activeDotColor: Colors.blueAccent, dotColor: Colors.blue.shade50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
