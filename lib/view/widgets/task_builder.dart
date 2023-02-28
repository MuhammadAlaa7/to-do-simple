import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_app/view/widgets/task_item.dart';

import '../../provider/controller.dart';

class TaskBuilder extends StatelessWidget {
  TaskBuilder({required this.task, Key? key}) : super(key: key);

  final List task;

  @override
  Widget build(BuildContext context) {
    return task.isEmpty
        ?
           Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: const [
                  Icon(
                    Icons.menu,
                    color: Colors.grey,
                    size: 120,
                  ),
                   Text(
                    'No Tasks yet ... Add some Tasks',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                ],
              ),

        )
        :
            /*
            Don't forget to use the GetBuilder with update() and
            don't forget to use the class that holds the update()
            < MyController>  or it will throw an error

    */
          ListView.separated(
              itemBuilder: (context, index) => TaskItem(
                model: task[index],
              ),
              separatorBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(left: 20),
                height: 1,
                color: Colors.grey[300],
              ),
              itemCount: task.length,

          );
  }
}
