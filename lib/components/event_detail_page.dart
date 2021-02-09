import 'package:cached_network_image/cached_network_image.dart';
import 'package:dsc_cvrgu/model/event_data.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailPage extends StatefulWidget {
  final EventData eventData;

  const EventDetailPage({Key key, this.eventData}) : super(key: key);
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

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final timings = DateTime.parse(widget.eventData.from);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (context, inner) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.brown,
                expandedHeight: screenHeight * 0.36,
                stretch: true,
                stretchTriggerOffset: 150.0,
                // leading: IconButton(
                //     onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back, color: Colors.black)),
                onStretchTrigger: () {
                  return;
                },
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [
                    // StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                  background: Container(
                    height: screenHeight * 0.36,
                    color: Colors.white,
                    width: double.maxFinite,
                    child: Stack(
                      children: [
                        Hero(
                          tag: widget.eventData.eventTitle,
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                height: screenHeight * 0.33,
                                width: double.maxFinite,
                                imageUrl: widget.eventData.eventPoster,
                                placeholder: (context, url) => SpinKitFadingCircle(
                                  color: Colors.blueGrey.shade700,
                                  size: 18.0,
                                ),
                                errorWidget: (context, url, error) => Center(
                                  child: Text(
                                    "No Image avaliable",
                                    style: GoogleFonts.muli(
                                        fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.grey),
                                  ),
                                ),
                                fit: BoxFit.cover,
                              ),
                              Flexible(
                                  child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: RichText(
                                    text: TextSpan(
                                        text: "DSC - CVRGU",
                                        style: GoogleFonts.muli(fontWeight: FontWeight.w500),
                                        children: [
                                          TextSpan(
                                              text: "(Google Inc. ©)",
                                              style: GoogleFonts.muli(fontWeight: FontWeight.w200, fontSize: 12.0))
                                        ]),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                        Positioned(
                            right: 24.0,
                            bottom: 0.0,
                            child: Container(
                              height: screenHeight * 0.06,
                              width: screenHeight * 0.06,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0), color: Colors.greenAccent.shade400),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.pink.shade500,
                                size: 32.0,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            children: [
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.eventData.eventLink,
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        InkWell(
                            onTap: () => _launchURL(widget.eventData.eventLink),
                            child: Icon(
                              FeatherIcons.link,
                              size: 16.0,
                              color: Colors.indigo.shade300,
                            ))
                      ],
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
                            DateFormat.MMMMEEEEd().format(timings),
                            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
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
                            DateFormat.jms().format(timings),
                            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
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
      ),
    );

    // return Scaffold(
    //   body: SafeArea(
    //     child: ListView(
    //       children: [
    // Container(
    //   height: screenHeight * 0.36,
    //   width: double.maxFinite,
    //   child: Stack(
    //     children: [
    //       Hero(
    //         tag: widget.eventData.eventTitle,
    //         child: CachedNetworkImage(
    //           height: screenHeight * 0.33,
    //           width: double.maxFinite,
    //           imageUrl: widget.eventData.eventPoster,
    //           placeholder: (context, url) => SpinKitFadingCircle(
    //             color: Colors.blueGrey.shade700,
    //             size: 18.0,
    //           ),
    //           errorWidget: (context, url, error) => Center(
    //             child: Text(
    //               "No Image avaliable",
    //               style: GoogleFonts.muli(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.grey),
    //             ),
    //           ),
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       Positioned(
    //           right: 24.0,
    //           bottom: 0.0,
    //           child: Container(
    //             height: screenHeight * 0.06,
    //             width: screenHeight * 0.06,
    //             decoration:
    //                 BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.greenAccent.shade400),
    //             child: Icon(
    //               Icons.favorite,
    //               color: Colors.pink.shade500,
    //               size: 32.0,
    //             ),
    //           )),
    //       Positioned(
    //           left: 16.0,
    //           top: 16.0,
    //           child: Container(
    //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.black),
    //             child: IconButton(
    //                 onPressed: () => Navigator.of(context).pop(),
    //                 icon: Icon(Icons.arrow_back, color: Colors.white)),
    //           )),
    //     ],
    //   ),
    // ),
    //         Container(
    //           height: screenHeight * 0.05,
    //           margin: EdgeInsets.symmetric(vertical: 12.0),
    //           padding: EdgeInsets.symmetric(
    //             horizontal: 24.0,
    //           ),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Text(
    //                 "PLATFORM",
    //                 style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
    //               ),
    //               Row(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Text(
    //                     widget.eventData.eventLink,
    //                     style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
    //                   ),
    //                   SizedBox(
    //                     width: 4.0,
    //                   ),
    //                   InkWell(
    //                       onTap: () => _launchURL(widget.eventData.eventLink),
    //                       child: Icon(
    //                         FeatherIcons.link,
    //                         size: 16.0,
    //                         color: Colors.indigo.shade300,
    //                       ))
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //         Divider(
    //           thickness: 3.0,
    //           color: Colors.blueGrey.shade50,
    //         ),
    //         Container(
    //           height: screenHeight * 0.07,
    //           margin: EdgeInsets.symmetric(vertical: 4.0),
    //           padding: EdgeInsets.symmetric(
    //             horizontal: 24.0,
    //           ),
    //           child: Row(
    //             children: [
    //               Expanded(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Text(
    //                       "DATE",
    //                       style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
    //                     ),
    //                     Text(
    //                       DateFormat.MMMMEEEEd().format(timings),
    //                       style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               VerticalDivider(
    //                 thickness: 1.5,
    //               ),
    //               Expanded(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Text(
    //                       "TIMING",
    //                       style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
    //                     ),
    //                     Text(
    //                       DateFormat.jms().format(timings),
    //                       style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Divider(
    //           thickness: 3.0,
    //           color: Colors.blueGrey.shade50,
    //         ),
    //         Container(
    //           // height: screenHeight * 0.05,
    //           margin: EdgeInsets.symmetric(vertical: 12.0),
    //           padding: EdgeInsets.symmetric(
    //             horizontal: 24.0,
    //           ),
    //           child: Text(
    //             "AGENDA",
    //             style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
    //           ),
    //         ),
    //         Expanded(
    //             child: Stepper(
    //           steps: steps,
    //           physics: NeverScrollableScrollPhysics(),
    //           currentStep: currentStep,
    //           onStepContinue: next,
    //           onStepTapped: (step) => goTo(step),
    //           onStepCancel: cancel,
    //         ))
    //       ],
    //     ),
    //   ),
    // );
  }
}
