import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventDetailPage extends StatefulWidget {
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  List<Step> steps = [
    Step(
      title: const Text('Fill the Details'),
      isActive: true,
      state: StepState.complete,
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Event Referal Code'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Pass key'),
          ),
        ],
      ),
    ),
    Step(
      isActive: false,
      state: StepState.editing,
      title: const Text('Address'),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Home Address'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Postcode'),
          ),
        ],
      ),
    ),
    Step(
      state: StepState.error,
      title: const Text('Avatar'),
      subtitle: const Text("Error!"),
      content: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.red,
          )
        ],
      ),
    ),
  ];

  int currentStep = 0;
  bool complete = false;

  next() {
    currentStep + 1 != steps.length ? goTo(currentStep + 1) : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: Colors.deepOrange,
              height: screenHeight * 0.36,
              width: screenWidth,
              child: Stack(
                children: [
                  Container(
                    color: Colors.redAccent,
                    // 'assets/images/logo.png',
                    height: screenHeight * 0.33,
                  ),
                  Positioned(
                      right: 24.0,
                      bottom: 0.0,
                      child: Container(
                        height: screenHeight * 0.06,
                        width: screenHeight * 0.06,
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.greenAccent.shade700),
                        child: Icon(
                          FontAwesomeIcons.heart,
                          color: Colors.red,
                        ),
                      )),
                  Positioned(
                      left: 16.0,
                      top: 16.0,
                      child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.arrow_back, color: Colors.black))),
                ],
              ),
            ),
            Container(
              height: screenHeight * 0.05,
              margin: EdgeInsets.symmetric(vertical: 12.0),
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "PLATFORM",
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Virtual",
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 3.0,
              color: Colors.blueGrey.shade50,
            ),
            Container(
              height: screenHeight * 0.07,
              margin: EdgeInsets.symmetric(vertical: 4.0),
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "DATE",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Virtual",
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1.5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "TIMING",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Virtual",
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 3.0,
              color: Colors.blueGrey.shade50,
            ),
            Container(
              // height: screenHeight * 0.05,
              margin: EdgeInsets.symmetric(vertical: 12.0),
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: Text(
                "AGENDA",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
                child: Stepper(
              steps: steps,
              physics: NeverScrollableScrollPhysics(),
              currentStep: currentStep,
              onStepContinue: next,
              onStepTapped: (step) => goTo(step),
              onStepCancel: cancel,
            ))
          ],
        ),
      ),
    );
  }
}
