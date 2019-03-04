import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MySwipe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MySwipeState();
  }
}

class MySwipeState extends State<MySwipe> {
  final items = List<String>.generate(30, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return Dismissible(
              key: Key(item),
              onDismissed: (direction) {
                setState(() {
                  items.removeAt(index);
                });

                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("$item dismissed!")));
              },
              background: Container(
                padding: EdgeInsets.all(12.0),
                color: Colors.red,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: <Widget>[
                        Text(
                          "Deleted",
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.delete),
                      ],
                    )
                  ],
                ),
              ),
              child: ListTile(title: Text("$item")),
            );
          }),
    );
  }
}
