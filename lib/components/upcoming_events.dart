import 'package:cached_network_image/cached_network_image.dart';
import 'package:dsc_cvrgu/components/event_detail_page.dart';
import 'package:dsc_cvrgu/model/event_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UpcomingEvents extends StatefulWidget {
  final List<EventData> eventDataList;

  const UpcomingEvents({Key key, this.eventDataList}) : super(key: key);
  @override
  _UpcomingEventsState createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 24.0, bottom: 24.0),
        children: List.generate(widget.eventDataList.length, (index) {
          final timings = DateTime.parse(widget.eventDataList[index].from);
          return Container(
            height: screenHeight * 0.14,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      /// [Go to the detailed Page.]
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => EventDetailPage(
                                eventData: widget.eventDataList[index],
                              )));
                    },
                    child: SizedBox(
                      height: screenHeight * 0.14,
                      width: screenWidth * 0.81,
                      child: Material(
                        elevation: 10.0,
                        shadowColor: Colors.grey.shade50,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: (widget.eventDataList[index].eventPoster == "")
                              ? Center(
                                  child: Text(
                                    "No Image avaliable",
                                    style: GoogleFonts.muli(
                                        fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.grey),
                                  ),
                                )
                              : Hero(
                                  tag: widget.eventDataList[index].eventTitle,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.eventDataList[index].eventPoster,
                                    placeholder: (context, url) => SpinKitFadingCircle(
                                      color: Colors.blueGrey.shade700,
                                    ),

                                    errorWidget: (context, url, error) => Center(
                                      child: Text(
                                        "No Image avaliable",
                                        style: GoogleFonts.muli(
                                            fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.grey),
                                      ),
                                    ),
                                    // placeholder: kTransparentImage,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: screenHeight * 0.045,
                    width: (screenWidth * 0.4) * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
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
                )
              ],
            ),
          );
        }));
  }
}
