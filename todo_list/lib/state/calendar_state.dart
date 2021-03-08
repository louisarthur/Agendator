import 'package:mobx/mobx.dart';
import 'package:todo_list/models/task.dart';

part 'calendar_state.g.dart';

class CalendarState = _CalendarState with _$CalendarState;

final Map<int, String> monthsExtense = {
  1: 'Janeiro',
  2: 'Fevereiro',
  3: 'Março',
  4: 'Abril',
  5: 'Maio',
  6: 'Junho',
  7: 'Julho',
  8: 'Agosto',
  9: 'Setembro',
  10: 'Outubro',
  11: 'Novembro',
  12: 'Dezembro'
};

abstract class _CalendarState with Store {
  // ==========================Month============================
  @observable
  String month = monthsExtense[DateTime.now().month];

  set changeMonth(int newValue) {
    month = monthsExtense[newValue].toString();
  }

  get monthValue => month;

  get monthValueDataNumber => monthsExtense.keys
      .firstWhere((element) => monthsExtense[element] == month);
  // ==========================Day============================
  @observable
  String day = DateTime.now().day.toString();

  set changeDay(String newValue) {
    day = newValue;
  }

  get dayValue => day;
  // ==========================Year============================
  @observable
  String year = DateTime.now().year.toString();

  set changeYear(String newValue) {
    year = newValue;
  }

  get yearValue => year;

  @observable
  ObservableList<Task> result = ObservableList<Task>();

  set setTasks(List<Task> tasks) {
    result = tasks.asObservable();
  }

  @action
  void sortTasks() {
    result.sort((a, b) {
      if (a.isOk && !b.isOk)
        return 1;
      else if (!a.isOk && b.isOk)
        return -1;
      else
        return 0;
    });
  }

  @action
  void changeTaskBoolean(int index, bool newValue) {
    result[index] =
        Task(result[index].title, result[index].dateCreated, newValue);
    tasksAvailable.value = 0;
  }

  @action
  void addNewTask(Task task) {
    result.add(task);
  }

  get results => result;

  @observable
  Observable<Task> lastRemoved = Observable<Task>(null);

  set setLastRemoved(Task task) {
    lastRemoved.value = task;
  }

  @observable
  Observable<int> tasksAvailable = Observable<int>(0);

  @action
  void tasksAvaiability(int value) {
    tasksAvailable.value = value;
  }
}
