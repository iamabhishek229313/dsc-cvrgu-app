import 'dart:math';

import 'package:dsc_cvrgu/components/event_detail_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.grey.shade900,
          indicatorColor: Colors.black,
          tabs: ["Upcommig", "Attending", "Attended"]
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
        ),
        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: ["Upcommig", "Attending", "Attended"].map((e) => EachPage()).toList()),
        ),
      ],
    );
  }
}

class EachPage extends StatelessWidget {
  const EachPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 24.0, bottom: 24.0),
        children: List.generate(
            10,
            (index) => Container(
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => EventDetailPage()));
                          },
                          child: Material(
                            elevation: 5.0,
                            shadowColor: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              height: screenHeight * 0.14,
                              width: screenWidth * 0.81,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0),
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
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      )
                    ],
                  ),
                )));
  }
}
