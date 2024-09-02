import 'package:ahueni/models/user_tasks.dart';
import 'package:ahueni/services/task/task_service.dart';
import 'package:flutter/material.dart';

class UserTaskProvider with ChangeNotifier {
  final UserTaskService _userTaskService = UserTaskService();
  List<UserTask> _tasks = [];

  List<UserTask> get tasks => _tasks;

  // Fetch tasks for the current user
  Future<void> fetchTasks() async {
    try {
      final fetchedTasks = await _userTaskService.getUserTasks();
      _tasks = fetchedTasks;
      notifyListeners();
    } catch (e) {
      print("Failed to fetch tasks: $e");
    }
  }

  // Add a new task
  Future<void> addTask(UserTask task) async {
    try {
      await _userTaskService.addUserTask(task);
      _tasks.add(task);
      notifyListeners();
    } catch (e) {
      print("Failed to add task: $e");
    }
  }

  // Update a task
  Future<void> updateTask(UserTask task) async {
    try {
      await _userTaskService.updateUserTask(task);
      int index = _tasks.indexWhere((t) => t.taskId == task.taskId);
      if (index != -1) {
        _tasks[index] = task;
        notifyListeners();
      }
    } catch (e) {
      print("Failed to update task: $e");
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      await _userTaskService.deleteUserTask(taskId);
      _tasks.removeWhere((task) => task.taskId == taskId);
      notifyListeners();
    } catch (e) {
      print("Failed to delete task: $e");
    }
  }
}
