import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final path;
  final radius;
  const Avatar({
    Key key, @required this.path, @required this.radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(path),
    );
  }
}