import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../provider/controller.dart';
import '../widgets/task_builder.dart';

class ArchivedScreen extends StatelessWidget {
 const ArchivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyController controller = Get.find();   // must be inside the build method
/*
    * MUST USE THE GETBUILDER HERE IN EACH SCREEN YOU ARE USING THE TASKBUILDER IN >> TO UPDATE THE STATES
    * */


    return  GetBuilder<MyController>(
      builder: (c) =>
        TaskBuilder(task: controller.archivedTasks ));
  }
}