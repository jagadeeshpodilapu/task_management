import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_management_system/app/core/utils/extensions.dart';
import 'package:task_management_system/app/core/values/colors.dart';
import 'package:task_management_system/app/data/models/task.dart';
import 'package:task_management_system/app/modules/home/home_controller.dart';
import 'package:task_management_system/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homeCntrl = Get.find<HomeController>();
  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: "Task Type",
            content: Form(
                key: homeCntrl.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                      child: TextFormField(
                        controller: homeCntrl.editController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Title'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your task title';
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons
                            .map((e) => Obx(() {
                                  final index = icons.indexOf(e);
                                  return ChoiceChip(
                                    label: e,
                                    selected:
                                        homeCntrl.chipIndex.value == index,
                                    selectedColor: Colors.grey[200],
                                    pressElevation: 0,
                                    backgroundColor: Colors.white,
                                    onSelected: (bool selected) {
                                      homeCntrl.chipIndex.value =
                                          selected ? index : 0;
                                    },
                                  );
                                }))
                            .toList(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (homeCntrl.formKey.currentState!.validate()) {
                          int icon =
                              icons[homeCntrl.chipIndex.value].icon!.codePoint;
                          String color =
                              icons[homeCntrl.chipIndex.value].color!.toHex();
                          var task = Task(
                            title: homeCntrl.editController.text,
                            icon: icon,
                            color: color,
                          );
                          Get.back();
                          homeCntrl.addTask(task)
                              ? EasyLoading.showSuccess("create success")
                              : EasyLoading.showError("Duplicate Task");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: const Size(150, 40)),
                      child: const Text("Confirm"),
                    )
                  ],
                )),
          );
          homeCntrl.editController.clear();
          homeCntrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(Icons.add, size: 10.0.wp, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
