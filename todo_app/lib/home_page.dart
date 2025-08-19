import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/utils/dialog_box.dart';
import 'package:todo_app/utils/todo_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();

  final myBox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    if (myBox.get("TODOLIST") == null) {
      db.createData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.ToDoList[index][1] = !db.ToDoList[index][1];
    });
    db.updateDatabase();
  }

  void deleteTask(int index) {
    setState(() {
      db.ToDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.ToDoList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
  }

  void createNewtask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: saveNewTask,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: Text("TODO"),
        backgroundColor: Colors.deepPurple[400],
        elevation: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewtask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TodoItem(
            isChecked: db.ToDoList[index][1],
            onChanged: (value) => checkboxChanged(value, index),
            toDoText: db.ToDoList[index][0],
            onPressed: (context) => deleteTask(index),
          );
        },
        itemCount: db.ToDoList.length,
      ),
    );
  }
}
