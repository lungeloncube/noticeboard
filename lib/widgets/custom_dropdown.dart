import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final hintText;
  final chosenValue;
  final Function onChanged;
  final List items;

  const CustomDropdown(
      {Key key,
      @required this.hintText,
      @required this.chosenValue,
      @required this.onChanged,
      @required this.items})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        hint: Text(
          hintText,
          style: TextStyle(fontSize: 16, fontFamily: 'Trebuchet'),
        ),
        dropdownColor: Colors.white,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 40.0,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
        value: chosenValue,
        onChanged: onChanged,
        items: items);
  }
}
