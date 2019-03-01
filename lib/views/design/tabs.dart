import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: PreferredSize(
            child: Container(
              child: new TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.yellow,
                tabs: [
                  new Tab(icon: new Icon(Icons.directions_car)),
                  new Tab(icon: new Icon(Icons.directions_transit)),
                  new Tab(icon: new Icon(Icons.directions_bike)),
                ],
              ),
              color: Colors.blue[600],
            ),
            preferredSize: Size.fromHeight(kToolbarHeight)),
        body: new TabBarView(
          children: [
            new Icon(Icons.directions_car),
            new Icon(Icons.directions_transit),
            new Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
