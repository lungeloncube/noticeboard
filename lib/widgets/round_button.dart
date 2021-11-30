// import 'package:flutter/material.dart';
//
// class Button extends StatelessWidget {
//   final Function onPressed;
//  final child;
//   final minimumSize;
//   final primary;
//   final backgroundColor;
//   final textStyle;
//
//
//   const Button({
//     Key key,
//
//     @required this.onPressed,
//     @required this.minimumSize,
//     @required this.primary,
//     @required this.backgroundColor,
//     @required this.textStyle, @required this.child,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       child: Text(child),
//       onPressed: onPressed,
//       style: OutlinedButton.styleFrom(
//           minimumSize: Size(200, 40),
//           primary: primary,
//           backgroundColor: backgroundColor,
//           textStyle: TextStyle(fontSize: 24)),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color color;
  final double elevation;

  RoundButton({
    @required this.title,
    @required this.onPressed,
    this.color,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(0),
      //padding: const EdgeInsets.only(top: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                primary: color ?? Theme.of(context).primaryColor,
                elevation: elevation ?? 5,
                textStyle: TextStyle(color: Colors.white),
                padding: EdgeInsets.all(6)),
            child: Text(
              title,
              style: TextStyle(
                fontSize:18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
