
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final hint;
  final maxLines;
  const InputField({
    Key key, this.hint, this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style:TextStyle(fontFamily: 'Trebuchet', fontSize:14),
      maxLines: maxLines,
      cursorColor: Colors.black,
      decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.only(
              left: 15, bottom: 11, top: 11, right: 15),
          hintText: hint),
    );
  }
}
