import 'package:task_management_system/app/data/models/task.dart';
import 'package:task_management_system/app/data/providers/task/provider.dart';

class TaskRepository {
  TaskProvider taskProvider;

  TaskRepository({required this.taskProvider});
  List<Task> readTasks() => taskProvider.readTask();
  void writeTasks(List<Task> tasks) => taskProvider.writeTask(tasks);
}
