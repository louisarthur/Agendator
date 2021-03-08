import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/state/calendar_state.dart';
import 'package:todo_list/todolist_screen/local_widgets/appbar.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final CalendarState calendarState = GetIt.I.get();
  final List<ReactionDisposer> _reactions = <ReactionDisposer>[];
  final TextEditingController taskText = TextEditingController();

  @override
  void initState() {
    _reactions.add(reaction(
        (Reaction reaction) =>
            calendarState.day + calendarState.month + calendarState.year,
        (dynamic msg) => getData()
            .then((List<Task> value) => calendarState.setTasks = value)));

    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) async {
      getData().then((List<Task> value) => calendarState.setTasks = value);
    });

    super.initState();
  }

  @override
  void dispose() {
    for (final ReactionDisposer disposer in _reactions) {
      disposer();
    }
    taskText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTodo(calendarState: calendarState),
      body: _body,
    );
  }

  Widget get _body {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          displayDateTime,
          _createNewTask,
          _taskCount,
          listTodo
        ],
      ),
    );
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(calendarState.result);
    prefs.setString(
        '${calendarState.dayValue}-${calendarState.monthValueDataNumber}-${calendarState.yearValue}',
        encodedData);
    int auxValue = 0;
    for (Task item in calendarState.result) {
      if (item.isOk == false) {
        auxValue++;
      }
    }
    calendarState.tasksAvaiability(auxValue);
  }

  Widget get _taskCount {
    return Observer(
        builder: (_) => calendarState.result.length > 0
            ? Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                    'Tarefas disponíveis ${calendarState.tasksAvailable.value}/${calendarState.result.length}'),
              )
            : Container());
  }

  Future<List<Task>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(
        '${calendarState.dayValue}-${calendarState.monthValueDataNumber}-${calendarState.yearValue}');
    List<dynamic> listDecoded = json.decode(data);
    List<Task> listTask = [];
    for (dynamic item in listDecoded) {
      listTask.add(Task.fromJson(item as Map<String, dynamic>));
    }
    int auxValue = 0;
    for (Task item in listTask) {
      if (item.isOk == false) {
        auxValue++;
      }
    }
    calendarState.tasksAvaiability(auxValue);

    return listTask;
  }

  Widget get displayDateTime {
    return Observer(
      builder: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text(calendarState.dayValue,
                  style: TextStyle(color: Colors.black87, fontSize: 150))),
          Column(
            children: <Widget>[
              Center(
                child: Text(calendarState.monthValue,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            calendarState.monthValue.length > 6 ? 50 : 70)),
              ),
              Center(
                  child: Text(calendarState.yearValue,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 45,
                      ))),
            ],
          )
        ],
      ),
    );
  }

  Widget get _createNewTask {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: SizedBox(
              height: 50,
              child: TextField(
                controller: taskText,
                decoration: InputDecoration(
                  focusColor: Color(0xFF15EE92),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF15EE92))),
                  labelText: "Nova Tarefa",
                  labelStyle: TextStyle(color: Colors.black38),
                ),
              ),
            )),
            SizedBox(width: 10),
            ButtonTheme(
              height: 50,
              splashColor: Color(0xFF3E8A6A),
              buttonColor: Color(0xFF0CF010),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: RaisedButton(
                child: Text(
                  'Adicionar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // ignore: unrelated_type_equality_checks
                  taskText.text.isNotEmpty
                      ? createTask()
                      // ignore: unnecessary_statements
                      : null;
                },
              ),
            )
          ]),
    );
  }

  Widget get listTodo {
    return Observer(
        builder: (_) => calendarState.result.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.only(top: 20.0),
                itemCount: calendarState.result.length,
                itemBuilder: builderItem)
            : Container(
                height: 200,
                child: Center(
                    child: Text('Nenhuma tarefa cadastrada para esse dia',
                        style:
                            TextStyle(color: Colors.black38, fontSize: 17)))));
  }

  // ignore: missing_return
  void refresh() async {
    await Future.delayed(Duration(seconds: 2));
    calendarState.sortTasks();
    _saveData();
  }

  void createTask() async {
    String title = taskText.text;
    String dataCreated =
        '${calendarState.dayValue}-${calendarState.monthValueDataNumber}-${calendarState.yearValue}';
    bool isOk = false;
    calendarState.addNewTask(Task(title, dataCreated, isOk));
    await _saveData();
    taskText.text = '';
  }

  void _dismissTask(int index) async {
    calendarState.setLastRemoved = calendarState.result[index];
    calendarState.result.removeAt(index);

    await _saveData();
  }

  void _undoDismisstask(int index) async {
    // print(calendarState.lastRemoved.value);
    // print(calendarState.lastRemoved.value.title);
    calendarState.result.insert(index, calendarState.lastRemoved.value);
    await _saveData();
  }

  void _changeTask(int index, bool value) async {
    calendarState.changeTaskBoolean(index, value);
    await _saveData();
  }

  Widget builderItem(BuildContext context, int index) {
    return Observer(
      builder: (_) => Dismissible(
          onDismissed: (direction) {
            _dismissTask(index);
            final snackbar = SnackBar(
              content: Text(
                  "Tarefa ${calendarState.lastRemoved.value.title} removida"),
              action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  _undoDismisstask(index);
                },
              ),
              duration: Duration(seconds: 4),
            );
            Scaffold.of(context).showSnackBar(snackbar);
          },
          key: UniqueKey(),
          background: Container(
              color: Colors.red,
              child: Align(child: Icon(Icons.delete, color: Colors.white))),
          direction: DismissDirection.startToEnd,
          child: CheckboxListTile(
            value: calendarState.result[index].isOk,
            title: Text(
              calendarState.result[index].title,
            ),
            secondary: CircleAvatar(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF15EE92),
              child: Icon(
                  calendarState.result[index].isOk ? Icons.check : Icons.error),
            ),
            onChanged: (bool value) {
              _changeTask(index, value);
            },
          )),
    );
  }
}
