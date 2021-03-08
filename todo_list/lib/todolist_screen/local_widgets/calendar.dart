import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list/state/calendar_state.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final CalendarState calendarState = GetIt.I.get();
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      initialSelectedDay: DateFormat('dd-MM-yyyy', 'en_US').parseLoose(
          '${calendarState.dayValue}-${calendarState.monthValueDataNumber}-${calendarState.yearValue}'),
      headerVisible: true,
      rowHeight: 45,
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      onDaySelected: daySelected,
      calendarStyle: CalendarStyle(
          todayColor: Colors.red, selectedColor: Color(0xFF15EE92)),
      availableGestures: AvailableGestures.horizontalSwipe,
      calendarController: _calendarController,
      locale: 'pt_BR',
    );
  }

  void daySelected(DateTime date, List<dynamic> list, List<dynamic> otherList) {
    calendarState.changeDay = date.day.toString();
    calendarState.changeYear = date.year.toString();
    calendarState.changeMonth = date.month;
    calendarState.result.clear();
    Navigator.of(context).pop();
  }
}
