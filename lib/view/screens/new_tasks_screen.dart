import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_app/provider/controller.dart';

import '../widgets/task_builder.dart';

class NewTasks extends StatelessWidget {
  NewTasks({Key? key}) : super(key: key);

//TODO: <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// Get.fin() here is error >> must be inside the build method

  @override
  Widget build(BuildContext context) {
    final MyController controller =
        Get.find(); // must be inside the build method

    /*
    * MUST USE THE GETBUILDER HERE IN EACH SCREEN YOU ARE USING THE TASKBUILDER IN >> TO UPDATE THE STATES
    * */

    return GetBuilder<MyController>(
        builder: (c) => TaskBuilder(task: controller.newTasks));
  }
}
