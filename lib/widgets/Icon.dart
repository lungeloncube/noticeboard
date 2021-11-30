import 'package:flutter/material.dart';

class ActionIcon extends StatelessWidget {
  final icon;

  const ActionIcon({
    Key key, @required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 35.0, color: Colors.blue);
  }
}