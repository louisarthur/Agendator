// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CalendarState on _CalendarState, Store {
  final _$monthAtom = Atom(name: '_CalendarState.month');

  @override
  String get month {
    _$monthAtom.reportRead();
    return super.month;
  }

  @override
  set month(String value) {
    _$monthAtom.reportWrite(value, super.month, () {
      super.month = value;
    });
  }

  final _$dayAtom = Atom(name: '_CalendarState.day');

  @override
  String get day {
    _$dayAtom.reportRead();
    return super.day;
  }

  @override
  set day(String value) {
    _$dayAtom.reportWrite(value, super.day, () {
      super.day = value;
    });
  }

  final _$yearAtom = Atom(name: '_CalendarState.year');

  @override
  String get year {
    _$yearAtom.reportRead();
    return super.year;
  }

  @override
  set year(String value) {
    _$yearAtom.reportWrite(value, super.year, () {
      super.year = value;
    });
  }

  final _$resultAtom = Atom(name: '_CalendarState.result');

  @override
  ObservableList<Task> get result {
    _$resultAtom.reportRead();
    return super.result;
  }

  @override
  set result(ObservableList<Task> value) {
    _$resultAtom.reportWrite(value, super.result, () {
      super.result = value;
    });
  }

  final _$lastRemovedAtom = Atom(name: '_CalendarState.lastRemoved');

  @override
  Observable<Task> get lastRemoved {
    _$lastRemovedAtom.reportRead();
    return super.lastRemoved;
  }

  @override
  set lastRemoved(Observable<Task> value) {
    _$lastRemovedAtom.reportWrite(value, super.lastRemoved, () {
      super.lastRemoved = value;
    });
  }

  final _$tasksAvailableAtom = Atom(name: '_CalendarState.tasksAvailable');

  @override
  Observable<int> get tasksAvailable {
    _$tasksAvailableAtom.reportRead();
    return super.tasksAvailable;
  }

  @override
  set tasksAvailable(Observable<int> value) {
    _$tasksAvailableAtom.reportWrite(value, super.tasksAvailable, () {
      super.tasksAvailable = value;
    });
  }

  final _$_CalendarStateActionController =
      ActionController(name: '_CalendarState');

  @override
  void sortTasks() {
    final _$actionInfo = _$_CalendarStateActionController.startAction(
        name: '_CalendarState.sortTasks');
    try {
      return super.sortTasks();
    } finally {
      _$_CalendarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTaskBoolean(int index, bool newValue) {
    final _$actionInfo = _$_CalendarStateActionController.startAction(
        name: '_CalendarState.changeTaskBoolean');
    try {
      return super.changeTaskBoolean(index, newValue);
    } finally {
      _$_CalendarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewTask(Task task) {
    final _$actionInfo = _$_CalendarStateActionController.startAction(
        name: '_CalendarState.addNewTask');
    try {
      return super.addNewTask(task);
    } finally {
      _$_CalendarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void tasksAvaiability(int value) {
    final _$actionInfo = _$_CalendarStateActionController.startAction(
        name: '_CalendarState.tasksAvaiability');
    try {
      return super.tasksAvaiability(value);
    } finally {
      _$_CalendarStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
month: ${month},
day: ${day},
year: ${year},
result: ${result},
lastRemoved: ${lastRemoved},
tasksAvailable: ${tasksAvailable}
    ''';
  }
}
