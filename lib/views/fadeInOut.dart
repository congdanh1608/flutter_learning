import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FadeInOut extends StatefulWidget {
  final String title;

  FadeInOut({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyFadeInOut();
  }
}

class MyFadeInOut extends State<FadeInOut> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 1000),
          child: new Center(
            child: Container(
              width: 200.0,
              height: 200.0,
              color: Colors.green,
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _visible = !_visible;
          });
        },
        tooltip: "Toggle Opacity",
        child: Icon(Icons.flip),
      ),
    );
  }
}
