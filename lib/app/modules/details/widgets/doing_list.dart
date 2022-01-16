import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_system/app/modules/home/home_controller.dart';
import 'package:task_management_system/app/core/utils/extensions.dart';

class DoingList extends StatelessWidget {
  final hmeCntrl = Get.find<HomeController>();
  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => hmeCntrl.doingTodos.isEmpty && hmeCntrl.doneTodos.isEmpty
        ? Column(
            children: [
              SizedBox(
                height: 5.0.wp,
              ),
              Image.asset(
                'assets/images/add_task.jpg',
                fit: BoxFit.cover,
                width: 65.0.wp,
                height: 65.0.wp,
              ),
              SizedBox(
                height: 5.0.wp,
              ),
              Text(
                "Add Task",
                style:
                    TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold),
              ),
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...hmeCntrl.doingTodos
                  .map(
                    (element) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3.0.wp, horizontal: 9.0.wp),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: Checkbox(
                              onChanged: (value) {
                                hmeCntrl.doneTodo(element['title']);
                              },
                              fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.grey),
                              value: element['done'],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                            child: Text(
                              element['title'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),
              // ignore: prefer_const_constructors
              if (hmeCntrl.doingTodos.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                  child: const Divider(
                    thickness: 2,
                  ),
                )
            ],
          ));
  }
}
