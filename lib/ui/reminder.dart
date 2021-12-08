import 'package:digital_notice_board/widgets/bordered_text_field.dart';
import 'package:digital_notice_board/widgets/custom_dropdown.dart';
import 'package:digital_notice_board/widgets/round_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  static const String LOG_NAME = 'screen.reminder';
  var maxLength = 160;
  var textLength = 0;

  DateTime currentDate = DateTime.now();

  String valueChoose;
  List listItem = [
    "Repeats monthly",
    "Repeats weekly",
    "Repeats daily",
    "Repeats hourly"
  ];

  @override
  Widget build(BuildContext context) {
    dev.log('In the reminder page', name: LOG_NAME);
    return Scaffold(
        appBar: AppBar(
            title: Text('Reminder',
                style: TextStyle(fontFamily: 'Trebuchet', fontSize: 22))),
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
                            fontSize: 18)),
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
                  child: BorderedTextField(
                    onChanged: (value) {
                      setState(() {
                        textLength = value.length;
                      });
                    },
                    maxLength: 160,
                    hintText: 'Type here...',
                    minLength: 7,
                  )),
              SizedBox(height: 8),
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
                            fontSize: 18),
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
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Icon(Icons.calendar_today_outlined,
                              color: Colors.blue, size: 30),
                        ),
                        GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Text(
                              DateFormat.yMMMMd('en_US').format(currentDate),
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Trebuchet'),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectTime();
                          },
                          child: Icon(Icons.watch_outlined,
                              color: Colors.blue, size: 30),
                        ),
                        GestureDetector(
                            onTap: () {
                              _selectTime();
                            },
                            child: Text(_time.format(context),
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Trebuchet')))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: _buildDropdownButton,
                          child: Icon(Icons.all_inclusive_sharp,
                              color: Colors.blue, size: 30),
                        ),
                        _buildDropdownButton()
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
                  RoundButton(
                    title: 'Cancel',
                    color: Colors.grey[00],
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 10),
                  RoundButton(
                    title: 'Save',
                    color: Colors.blue,
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget _buildDropdownButton() {
    return CustomDropdown(
      hintText: 'Select',
      chosenValue: valueChoose,
      onChanged: (newValue) {
        setState(() {
          valueChoose = newValue;
        });
      },
      items: listItem.map<DropdownMenuItem<String>>((valueItem) {
        return DropdownMenuItem(
          value: valueItem,
          child: Text(valueItem,
              style: TextStyle(fontSize: 16, fontFamily: 'Trebuchet')),
        );
      }).toList(),
    );
  }

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

  TimeOfDay _time = TimeOfDay(
      hour: (DateTime(DateTime.now().hour).hour),
      minute: (DateTime(DateTime.now().minute).minute));

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }
}
