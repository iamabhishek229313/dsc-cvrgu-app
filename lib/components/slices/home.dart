import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dsc_cvrgu/components/event_detail_page.dart';
import 'package:dsc_cvrgu/components/past_events.dart';
import 'package:dsc_cvrgu/components/upcoming_events.dart';
import 'package:dsc_cvrgu/model/event_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<EventData> data;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  Future<List<EventData>> getData() async {
    var url = 'https://us-central1-dsc-cgu.cloudfunctions.net/events/api/event-details';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');

    print('Response body: ${response.body.length}');

    var decoded = json.decode(response.body);

    data = (decoded as List).map((element) => EventData.fromJson(element)).toList();

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<List<EventData>> snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
            ),
          );

        List<EventData> _upcoming = [];
        List<EventData> _past = [];

        for (int i = 0; i < snapshot.data.length; ++i) {
          if (snapshot.data[i].eventStatus == "upcoming")
            _upcoming.add(snapshot.data[i]);
          else
            _past.add(snapshot.data[i]);
        }

        return Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Colors.grey.shade900,
              indicatorColor: Colors.black,
              tabs: ["Upcommig events", "Past events"]
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: ["upcoming", "past"]
                      .map((e) => (e == "upcoming")
                          ? UpcomingEvents(
                              eventDataList: _upcoming,
                            )
                          : PastEvents(
                              eventDataList: _past,
                            ))
                      .toList()),
            ),
          ],
        );
      },
    );
  }
}
