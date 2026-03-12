
import 'package:flutter/material.dart';


import 'package:intl/intl.dart';

class CustomSpinnerDatePickerWidget extends StatefulWidget {
  const CustomSpinnerDatePickerWidget({
    super.key,
    this.width,
    this.height,
    this.initialDate,
    this.onDateSelected,
    this.buttonText = 'Choose Date on the Calender ',
    this.buttonColor,
    this.textStyle,
    this.dateFormat,
    this.yearStart = 1950,
    this.yearEnd = 2050,
  });

  final double? width;
  final double? height;
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;
  final String buttonText;
  final Color? buttonColor;
  final TextStyle? textStyle;
  final String? dateFormat;
  final int yearStart;
  final int yearEnd;

  @override
  CustomSpinnerDatePickerWidgetState createState() =>
      CustomSpinnerDatePickerWidgetState();
}

class CustomSpinnerDatePickerWidgetState
    extends State<CustomSpinnerDatePickerWidget> {
  late DateTime _selectedDate;
  late DateFormat _dateFormatter;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _dateFormatter = DateFormat(widget.dateFormat ?? 'M/d/yyyy');
  }

  void _showSpinnerCalendar() {
    int selectedYear = _selectedDate.year;
    int selectedMonth = _selectedDate.month;
    int selectedDay = _selectedDate.day;

    int daysInMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            daysInMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;

            if (selectedDay > daysInMonth) {
              selectedDay = daysInMonth;
            }

            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: Text(
                        DateFormat('M/d/yyyy').format(
                          DateTime(selectedYear, selectedMonth, selectedDay),
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: _buildSpinner(
                              itemCount: 12,
                              initialItem: selectedMonth - 1,
                              itemBuilder: (context, index) {
                                final monthName = DateFormat('MMMM').format(
                                  DateTime(2023, index + 1),
                                );
                                final isSelected = index == selectedMonth - 1;
                                return _buildSpinnerItem(
                                    context, monthName, isSelected);
                              },
                              onSelectedItemChanged: (index) {
                                setDialogState(() {
                                  selectedMonth = index + 1;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: _buildSpinner(
                              itemCount: daysInMonth,
                              initialItem: selectedDay - 1,
                              itemBuilder: (context, index) {
                                final isSelected = index == selectedDay - 1;
                                return _buildSpinnerItem(
                                    context, '${index + 1}', isSelected);
                              },
                              onSelectedItemChanged: (index) {
                                setDialogState(() {
                                  selectedDay = index + 1;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: _buildSpinner(
                              itemCount: widget.yearEnd - widget.yearStart + 1,
                              initialItem: selectedYear - widget.yearStart,
                              itemBuilder: (context, index) {
                                final year = widget.yearStart + index;
                                final isSelected = year == selectedYear;
                                return _buildSpinnerItem(
                                    context, '$year', isSelected);
                              },
                              onSelectedItemChanged: (index) {
                                setDialogState(() {
                                  selectedYear = widget.yearStart + index;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 255, 7, 85),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              final newDate = DateTime(
                                selectedYear,
                                selectedMonth,
                                selectedDay,
                              );
                              setState(() {
                                _selectedDate = newDate;
                              });
                              if (widget.onDateSelected != null) {
                                widget.onDateSelected!(newDate);
                              }
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 255, 7, 85),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSpinner({
    required int itemCount,
    required int initialItem,
    required Widget Function(BuildContext, int) itemBuilder,
    required void Function(int) onSelectedItemChanged,
  }) {
    return ListWheelScrollView.useDelegate(
      itemExtent: 40,
      diameterRatio: 1.2,
      physics: const FixedExtentScrollPhysics(),
      controller: FixedExtentScrollController(initialItem: initialItem),
      onSelectedItemChanged: onSelectedItemChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: itemCount,
        builder: itemBuilder,
      ),
    );
  }

  Widget _buildSpinnerItem(BuildContext context, String text, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color.fromARGB(116, 238, 238, 238)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Selected Date: ${_dateFormatter.format(_selectedDate)}',
              style: widget.textStyle ??
                  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
            ),
          ),
          InkWell(
            onTap: _showSpinnerCalendar,
            child: Container(
              width: 215,
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              decoration: BoxDecoration(
                color: widget.buttonColor ?? const Color.fromARGB(255, 34, 167, 223),
                borderRadius: BorderRadius.circular(20.0),
              ),
              alignment: Alignment.center,
              child: Text(
                widget.buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}