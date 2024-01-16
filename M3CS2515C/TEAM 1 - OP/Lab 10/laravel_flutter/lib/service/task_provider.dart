import 'package:flutter/material.dart';
import 'api_service.dart';
import '../model/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final ApiService apiService = ApiService('http://192.168.0.108:8000/api'); // Adjust the URL

  List<Task> tasks = [];

  Future<void> fetchTasks() async {
    tasks = await apiService.fetchTasks();
    notifyListeners();
  }

  Future<void> addTask(Task newTask) async {
    await apiService.addTask(newTask);
    await fetchTasks(); // Refresh the task list after adding a new task
  }

  Future<void> updateTaskCompletion(int id, bool completed) async {
    await apiService.updateTaskCompletion(id, completed);
    await fetchTasks(); // Refresh the task list after updating task completion
  }

  Future<void> deleteTask(int id) async {
  // Remove the task from the list
  tasks.removeWhere((task) => task.id == id);

  // Notify listeners after removing the task
  notifyListeners();

  // Perform the API call or other necessary cleanup
  await apiService.deleteTask(id);
 }

}
