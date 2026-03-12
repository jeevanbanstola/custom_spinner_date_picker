import 'package:flutter/material.dart';
import 'package:custom_spinner_date_picker/custom_spinner_date_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomSpinnerDatePickerWidget(
            buttonColor: Colors.blue,
          
            buttonText: 'pick a date',
            onDateSelected: (date) {
              
              print("Selected Date: $date");
            },
          ),
        ),
      ),
    );
  }
}