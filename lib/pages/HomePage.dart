import 'package:flutter/material.dart';
import 'package:to_do_list/data/dataBase.dart';
import 'package:to_do_list/util/ToDoTile.dart';
import 'package:to_do_list/util/dialogBox.dart';
import 'package:hive/hive.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  final _controller = TextEditingController();
  final _mybox = Hive.box('mybox');

  Database db = Database();
  @override
  void initState() {
    if (_mybox.get("TODO") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.ToDoList[index][1] = !db.ToDoList[index][1];
    });
    db.updateData();
  }

  void saveNewTask() {
    setState(() {
      db.ToDoList.add([_controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return dialogBox(
              controller: _controller,
              onSave: saveNewTask,
              onCancel: () => Navigator.of(context).pop());
        });
        db.updateData();
  }

  void deleteTask(int index) {
    setState(() {
      db.ToDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("TO DO LIST"),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow,
      ),
      body: ListView.builder(
        itemCount: db.ToDoList.length,
        itemBuilder: (context, index) {
          return Todotile(
            taskName: db.ToDoList[index][0],
            taskCompleted: db.ToDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: (p0) => deleteTask(index),
          );
        },
      ),
    );
  }
}
