import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:todo_notclean/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  late Box _taskBox;
  List<String> tasks = [];

  TodoProvider() {
    _init();
  }

  Future<void> _init() async {
    await Hive.initFlutter();
    await Hive.openBox('Task');
    _taskBox = Hive.box('Task');
    tasks = _taskBox.values.toList().cast<String>();
    notifyListeners();
  }

  void addTask(String task) {
    tasks.add(task);
    _taskBox.put(tasks.length - 1, task);
    notifyListeners();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    _taskBox.deleteAt(index);
    notifyListeners();
  }

  void toggleTask(int index) {
    var task = _taskBox.get(index) as String;
    if (task.startsWith('[x]')) {
      _taskBox.put(index, task.substring(4));
    } else {
      _taskBox.put(index, '[x] $task');
    }
    tasks = _taskBox.values.toList().cast<String>();
    notifyListeners();
  }

  Future<void> fetchAndAddData() async {
    int number = Random().nextInt(100);
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/$number'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final todo = TodoModel.fromJson(data);
      addTask(todo.title!);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
