import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo_list/state/calendar_state.dart';
import 'package:todo_list/todolist_screen/todolist_screen.dart';

void main() async => initializeDateFormatting().then((_) {
      final GetIt getIt = GetIt.instance;
      getIt.registerLazySingleton<CalendarState>(() => CalendarState());
      return runApp(MaterialApp(home: TodoListScreen()));
    });
