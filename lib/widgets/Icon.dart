import 'package:flutter/material.dart';

class ActionIcon extends StatelessWidget {
  final icon;
  final size;
  final color;

  const ActionIcon({
    Key key, @required this.icon, this.size, this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: size==null?35.0:size, color:color==null? Colors.blue:color);
  }
}