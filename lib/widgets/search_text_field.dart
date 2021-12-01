
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key key,
    @required TextEditingController textController,
  }) : _textController = textController, super(key: key);

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      cursorColor: Colors.white,
      controller: _textController,
      style: TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(4.0),
        hintText: 'Type here...',
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Trebuchet',
        ),
        border: InputBorder.none,
      ),
      onChanged: (text) {},
    );
  }
}