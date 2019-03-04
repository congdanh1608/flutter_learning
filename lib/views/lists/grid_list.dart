import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GridList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(100, (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.body1,
            ),
          );
        }),
      ),
    );
  }
}
