import 'dart:convert';

import 'package:get/get.dart';
import 'package:task_management_system/app/core/utils/keys.dart';
import 'package:task_management_system/app/data/models/task.dart';
import 'package:task_management_system/app/data/services/service.dart';

class TaskProvider {
  final StrorageService _storage = Get.find<StrorageService>();

  //local db structure
  // {
  //   'tasks':[
  //     'title':'work',
  //     'color':'0xff12345',
  //     'icon';0xe123
  //   ]
  // }

  List<Task> readTask() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTask(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
