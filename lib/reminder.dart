import 'package:digital_notice_board/widgets/outlined_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  var maxLength = 160;
  var textLength = 0;


  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }
  String valueChoose;
  List listItem = ["Repeats monthly", "Repeats weekly", "Repeats daily", "Repeats hourly"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Reminder',
                style: TextStyle(fontFamily: 'Trebuchet', fontSize: 20))),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Reminder',
                        style: TextStyle(
                            fontFamily: 'Trebuchet',
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    Text('${textLength.toString()}/${maxLength.toString()}',
                        style: TextStyle(
                            fontFamily: 'Trebuchet',
                            fontWeight: FontWeight.bold,
                            fontSize: 16))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textField(),
              ),
              Container(
                height: 40,
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Date and Time",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Trebuchet',
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            color: Colors.blue, size: 30),
                        Text(DateFormat.yMMMMd('en_US').format(currentDate))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.watch_outlined,
                            color: Colors.blue, size: 30),
                        Text(DateFormat.jm().format(currentDate))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.all_inclusive_sharp,
                            color: Colors.blue, size: 30),
                        buildDropdownButton()
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Button(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Trebuchet'),
                    backgroundColor: Colors.grey[400],
                    primary: Colors.white,
                    child: 'Cancel',
                  ),
                  SizedBox(height: 10),
                  Button(
                    onPressed: () => _selectDate(context),
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Trebuchet'),
                    backgroundColor: Colors.blue,
                    primary: Colors.white,
                    child: 'Save',
                  ),
                ],
              )
            ],
          ),
        ));
  }



  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      hint: Text('Select'),
      dropdownColor: Colors.white,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 40.0,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      value: valueChoose,
      onChanged: (newValue) {
        setState(() {
          valueChoose = newValue;
        });
      },
      items: listItem
          .map<DropdownMenuItem<String>>((valueItem) {
        return DropdownMenuItem(
          value: valueItem,
          child: Text(valueItem),
        );
      }).toList(),
    );}
  TextField textField() {
    return TextField(
                maxLines: null,
                minLines: 7,
                maxLength: maxLength,
                onChanged: (value) {
                  setState(() {
                    textLength = value.length;
                  });
                },
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: new InputDecoration(
                  counter: Offstage(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: 'Type here...',
                ),
              );
  }
}
