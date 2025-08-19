import 'package:hive/hive.dart';

class TodoDatabase {
  List ToDoList = [];

  final mybox = Hive.box('mybox');

  void createData() {
    ToDoList = [
      ['TODO', false],
    ];
  }

  void loadData() {
    ToDoList = mybox.get("TODOLIST");
  }

  void updateDatabase() {
    mybox.put('TODOLIST', ToDoList);
  }
}
