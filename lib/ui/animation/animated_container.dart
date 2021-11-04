import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedContainerScreen extends StatefulWidget {
  const AnimatedContainerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AnimatedContainerScreenState();
  }
}

class AnimatedContainerScreenState extends State<AnimatedContainerScreen> {
  // Define the various properties with default values. Update these properties
  // when the user taps a FloatingActionButton.
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedContainer Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: _borderRadius,
              ),
              // Define how long the animation should take.
              duration: const Duration(seconds: 1),
              // Provide an optional curve to make the animation feel smoother.
              curve: Curves.fastOutSlowIn,
            ),
            ElevatedButton(
                onPressed: () {
                  changeAnimation();
                },
                child: const Text("Animation")),
            AnimatedOpacity(
              // If the widget is visible, animate to 0.0 (invisible).
              // If the widget is hidden, animate to 1.0 (fully visible).
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              // The green box must be a child of the AnimatedOpacity widget.
              child: Container(
                width: 200.0,
                height: 200.0,
                color: Colors.green,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  faceAWidget();
                },
                child: const Text("Fade A Widget")),
          ],
        ),
      ),
    );
  }

  void changeAnimation() {
    setState(() {
      final random = Random();
      _width = random.nextInt(300).toDouble();
      _height = random.nextInt(300).toDouble();
      _color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
      // Generate a random border radius.
      _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
    });
  }

  void faceAWidget() {
    setState(() {
      _visible = !_visible;
    });
  }
}
