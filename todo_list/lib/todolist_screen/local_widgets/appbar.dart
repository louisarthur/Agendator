import 'package:flutter/material.dart';
import 'package:todo_list/state/calendar_state.dart';
import 'package:todo_list/todolist_screen/local_widgets/calendar.dart';

class AppBarTodo extends StatefulWidget with PreferredSizeWidget {
  const AppBarTodo({this.calendarState});

  final CalendarState calendarState;

  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  _AppBarTodoState createState() => _AppBarTodoState();
}

class _AppBarTodoState extends State<AppBarTodo> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Agendator'),
      centerTitle: true,
      backgroundColor: Color(0xFF15EE92),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.calendar_today_rounded),
            onPressed: () {
              _showBottomSheet(context);
            }),
        IconButton(
            icon: Icon(Icons.refresh_outlined),
            onPressed: () {
              widget.calendarState.sortTasks();
            }),
      ],
    );
  }

  void _showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (BuildContext bc) {
          return Container(
              child: Column(
            children: <Widget>[modalTopDecorator, Calendar()],
          ));
        });
  }

  Widget get modalTopDecorator => Center(
      child: Container(
          margin: EdgeInsets.only(top: 10),
          color: Colors.grey,
          width: 70,
          height: 5));
}
