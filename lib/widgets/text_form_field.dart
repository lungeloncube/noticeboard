
import 'package:flutter/material.dart';

class BorderlessInputField extends StatelessWidget {
  final hint;
  final maxLines;
  const BorderlessInputField({
    Key key, this.hint, this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textInputAction: TextInputAction.done,
      style:TextStyle(fontFamily: 'Trebuchet', fontSize:16),
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
          hintText: hint,hintStyle: TextStyle(fontSize: 16, fontFamily: 'Trebuchet')),
    );
  }
}
