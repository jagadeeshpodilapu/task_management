import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_management_system/app/core/utils/extensions.dart';
import 'package:task_management_system/app/modules/details/widgets/doing_list.dart';
import 'package:task_management_system/app/modules/details/widgets/done_list.dart';
import 'package:task_management_system/app/modules/home/home_controller.dart';

class DetailPage extends StatelessWidget {
  final homeCntrl = Get.find<HomeController>();
  DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeCntrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
          body: Form(
        key: homeCntrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeCntrl.updateTodo();
                      homeCntrl.changeTask(null);
                      homeCntrl.editController.clear();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Row(
                children: [
                  Icon(
                    IconData(task.icon, fontFamily: "MaterialIcons"),
                    color: color,
                  ),
                  SizedBox(
                    width: 3.0.wp,
                  ),
                  Text(
                    task.title,
                    style:
                        TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Obx(() {
              var totalTodos =
                  homeCntrl.doneTodos.length + homeCntrl.doingTodos.length;
              return Padding(
                padding:
                    EdgeInsets.only(left: 16.0.wp, top: 3.0.wp, right: 16.0.wp),
                child: Row(
                  children: [
                    Text(
                      "$totalTodos Tasks ",
                      style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Expanded(
                      child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: homeCntrl.doingTodos.length,
                        size: 5,
                        padding: 0,
                        selectedGradientColor: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                            colors: [color.withOpacity(0.5), color]),
                        unselectedGradientColor: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                            colors: [Colors.grey[300]!, Colors.grey[300]!]),
                      ),
                    )
                  ],
                ),
              );
            }),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCntrl.editController,
                autofocus: true,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (homeCntrl.formKey.currentState!.validate()) {
                            var success =
                                homeCntrl.addTodo(homeCntrl.editController.text);
                            if (success) {
                              EasyLoading.showSuccess("Todo item add success");
                            } else {
                              EasyLoading.showError("Todo item already exist");
                            }
                            homeCntrl.editController.clear();
                          }
                        },
                        icon: const Icon(Icons.done))),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your todo item";
                  }
                  return null;
                },
              ),
            ),
            DoingList(),
            DoneList(),
          ],
        ),
      )),
    );
  }
}
