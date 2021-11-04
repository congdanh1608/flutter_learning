import 'package:flutter/material.dart';

class MyCustomRoute {
  MyCustomRoute._();

  static final MyCustomRoute instance = MyCustomRoute._();

  Offset getBeginOffset(AxisDirection direction) {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.left:
        return const Offset(1, 0);
      case AxisDirection.right:
        return const Offset(-1, 0);
    }
  }
}

class MyPageRoute<T> extends MaterialPageRoute<T> {
  MyPageRoute({required WidgetBuilder builder, required RouteSettings settings}) : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    var begin = MyCustomRoute.instance.getBeginOffset(AxisDirection.left);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween), child: child);
  }
}
