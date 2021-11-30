import 'package:flutter/material.dart';

class ActionIconButton extends StatelessWidget {
  final icon;
  final Function onPressed;
  final color;
  const ActionIconButton({
    Key key, @required this.icon, @required this.onPressed, this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          icon, color: color,),
        onPressed:onPressed
    );
  }
}
