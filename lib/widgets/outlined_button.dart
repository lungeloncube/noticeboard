import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPressed;
 final child;
  final minimumSize;
  final primary;
  final backgroundColor;
  final textStyle;


  const Button({
    Key key,

    @required this.onPressed,
    @required this.minimumSize,
    @required this.primary,
    @required this.backgroundColor,
    @required this.textStyle, @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(child),
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          minimumSize: Size(200, 40),
          primary: primary,
          backgroundColor: backgroundColor,
          textStyle: TextStyle(fontSize: 24)),
    );
  }
}
