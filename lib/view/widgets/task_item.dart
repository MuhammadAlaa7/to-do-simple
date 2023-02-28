import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_app/provider/controller.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({required this.model, Key? key}) : super(key: key);

  final Map model;

  @override
  Widget build(BuildContext context) {
    MyController controller = Get.find();
    return Dismissible(
     // secondaryBackground: Container(color: Colors.red,),
      background: Container(color: Colors.red, child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),),
      onDismissed: (direction) {
        // remove from the database
        controller.deleteDatabase(model['id']);
        Get.snackbar(
          'Deleted',
          '${model['title']} has been deleted ',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          icon: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.BOTTOM,
          dismissDirection: DismissDirection.up,
          mainButton: TextButton(
              onPressed: () {},
              child: const Text(
                'undo',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        );
      },
      // this is key for making it unique
      key: Key(model['id'].toString()),

      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(model['time']),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model['title'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(model['date']),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              ),
              onPressed: () {
                controller.updateDatabase(status: 'done', id: model['id']);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.archive_outlined,
                color: Colors.black26,
              ),
              onPressed: () {
                controller.updateDatabase(status: 'archived', id: model['id']);
              },
            ),
          ],
        ),
      ),
    );
  }
}
