import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BorderedTextField extends StatelessWidget {
  final Function onChanged;
  final  maxLength;
  final minLength;
  final hintText;


  const BorderedTextField(
      {Key key,
      @required this.onChanged,
      @required this.maxLength,
      @required this.minLength, @required this.hintText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.done,
      maxLines: null,
      minLines: minLength,
      maxLength: maxLength,
      onChanged: onChanged,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: new InputDecoration(
          counter: Offstage(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              fontFamily: 'Trebuchet', fontSize: 16, color: Colors.black)),
    );
    ;
  }
}
