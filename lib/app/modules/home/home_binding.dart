import 'package:get/get.dart';
import 'package:task_management_system/app/data/providers/task/provider.dart';
import 'package:task_management_system/app/data/services/repository.dart';
import 'package:task_management_system/app/modules/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(taskProvider: TaskProvider()),
      ),
    );
  }
}
