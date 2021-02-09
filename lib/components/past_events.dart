import 'package:dsc_cvrgu/model/event_data.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PastEvents extends StatefulWidget {
  final List<EventData> eventDataList;

  PastEvents({this.eventDataList});

  @override
  _PastEventsState createState() => _PastEventsState();
}

class _PastEventsState extends State<PastEvents> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 24.0, bottom: 24.0),
        children: List.generate(widget.eventDataList.length, (index) {
          List<String> _spilited = widget.eventDataList[index].from.split('-');
          final timings = DateTime.parse(widget.eventDataList[index].from);
          return Container(
            // height: screenHeight * 0.14,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ExpansionTile(
              leading: Icon(
                Icons.event_available_outlined,
                color: Colors.green,
              ),
              title: Text(
                widget.eventDataList[index].eventTitle,
                style: GoogleFonts.muli(fontSize: 14.0, fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                widget.eventDataList[index].eventHost,
                style: GoogleFonts.muli(fontSize: 12.0, fontWeight: FontWeight.w400),
              ),
              maintainState: true,
              childrenPadding: EdgeInsets.only(bottom: 8.0),
              children: [
                Text(
                  (widget.eventDataList[index].eventDescription == "")
                      ? "No desciption avaliable"
                      : widget.eventDataList[index].eventDescription,
                  style: GoogleFonts.muli(fontSize: 12.0, fontWeight: FontWeight.w200),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: screenHeight * 0.045,
                        width: (screenWidth * 0.4) * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade200,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Text(
                            DateFormat.MMMMEEEEd().format(timings),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.muli(color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.045,
                        width: (screenWidth * 0.4) * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade200,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Text(
                            (widget.eventDataList[index].eventParticipants == null
                                    ? "0"
                                    : widget.eventDataList[index].eventParticipants.length.toString()) +
                                '\n' +
                                "Participants",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.muli(color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }));
  }
}
