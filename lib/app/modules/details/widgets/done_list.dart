import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_system/app/core/utils/extensions.dart';
import 'package:task_management_system/app/core/values/colors.dart';
import 'package:task_management_system/app/modules/home/home_controller.dart';

class DoneList extends StatelessWidget {
  final homeCntrl = Get.find<HomeController>();
  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCntrl.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2.0.wp, horizontal: 5.0.wp),
                  child: Text(
                    "Completed(${homeCntrl.doneTodos.length})",
                    style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                  ),
                ),
                ...homeCntrl.doneTodos
                    .map((element) => Dismissible(
                          key: ObjectKey(element),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) {
                            homeCntrl.deleteDoneTodo(element);
                          },
                          background: Container(
                            color: Colors.red.withOpacity(0.8),
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:  EdgeInsets.only(right: 5.0.wp),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 3.0.wp, horizontal: 9.0.wp),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: Icon(Icons.done, color: blue),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0.wp),
                                  child: Text(
                                    element['title'],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList()
              ],
            )
          : Container(),
    );
  }
}
