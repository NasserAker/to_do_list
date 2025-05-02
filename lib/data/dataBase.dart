import 'package:hive/hive.dart';

class Database {
  List ToDoList = [];

  final _mybox = Hive.box('mybox');

  void createInitialData() {
    ToDoList = [
      ["Welcome To This App ! ", false],
      ["Add And Delete Tasks :)", false],
    ];
  }

  void loadData() {
    ToDoList = _mybox.get("TODO");
  }

  void updateData() {
    _mybox.put("TODO", ToDoList);
  }
}
