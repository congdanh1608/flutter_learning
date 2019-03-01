import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrientationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OrientationBuilder(builder: (context, orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          children: List.generate(100, (index) {
            return Center(
              child: Container(
                child: Text(
                  'Item $index',
                  style: Theme.of(context).textTheme.body1,
                ),
                margin: orientation == Orientation.portrait
                    ? index % 2 == 0
                        ? EdgeInsets.fromLTRB(20, 10, 10, 10)
                        : EdgeInsets.fromLTRB(10, 10, 20, 10)
                    : index % 3 == 0
                        ? EdgeInsets.fromLTRB(20, 10, 10, 10)
                        : index % 3 == 1
                            ? EdgeInsets.fromLTRB(10, 10, 10, 10)
                            : EdgeInsets.fromLTRB(10, 10, 20, 10),
                alignment: Alignment.center,
                color: Colors.redAccent,
              ),
            );
          }),
        );
      }),
      floatingActionButton: Theme(
          data: Theme.of(context).copyWith(accentColor: Colors.yellow),
          child: FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.add),
          )),
    );
  }
}
