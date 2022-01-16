import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_management_system/app/core/utils/extensions.dart';
import 'package:task_management_system/app/core/values/colors.dart';
import 'package:task_management_system/app/modules/home/home_controller.dart';

class AddDialog extends StatelessWidget {
  final homeCntrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                          homeCntrl.editController.clear();
                          homeCntrl.changeTask(null);
                        },
                        icon: const Icon(Icons.close)),
                    TextButton(
                        onPressed: () {
                          if (homeCntrl.formKey.currentState!.validate()) {
                            if (homeCntrl.task.value == null) {
                              EasyLoading.showError("please select task type");
                            } else {
                              var success = homeCntrl.updateTask(
                                homeCntrl.task.value,
                                homeCntrl.editController.text,
                              );
                              if (success) {
                                EasyLoading.showSuccess("Todo item add success");
                                Get.back();
                                homeCntrl.changeTask(null);
                              } else {
                                EasyLoading.showError("Todo item already exist");
                              }
                              homeCntrl.editController.clear();
                            }
                          }
                        },
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        child: Text("Done", style: TextStyle(fontSize: 14.0.sp))),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: Text(
                  "New Task",
                  style:
                      TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextFormField(
                  controller: homeCntrl.editController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your todo item";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 5.0.wp, right: 5.0.wp, left: 5.0.wp, bottom: 2.0.wp),
                child: Text(
                  "Add to",
                  style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                ),
              ),
              ...homeCntrl.tasks
                  .map((element) => Obx(
                        () => InkWell(
                          onTap: () => homeCntrl.changeTask(element),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0.wp, vertical: 3.0.wp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      IconData(element.icon,
                                          fontFamily: 'MaterialIcons'),
                                      color: HexColor.fromHex(element.color),
                                    ),
                                    SizedBox(
                                      width: 3.0.wp,
                                    ),
                                    Text(
                                      element.title,
                                      style: TextStyle(
                                          fontSize: 12.0.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                if (homeCntrl.task.value == element)
                                  const Icon(
                                    Icons.check,
                                    color: blue,
                                  )
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
