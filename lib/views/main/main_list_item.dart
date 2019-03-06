import 'package:flutter/material.dart';

abstract class MainListItem {
  String title;
  int type;
  Color color;

  MainListItem(this.title, this.type, this.color);
}
