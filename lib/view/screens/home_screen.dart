import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_app/provider/controller.dart';
import 'package:simple_todo_app/view/widgets/input_field.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  final MyController controller = Get.find();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.list,
        ),
        label: 'Tasks'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.done,
        ),
        label: 'Done'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.archive_outlined,
        ),
        label: 'Archived'),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyController>(
      builder: (_) => Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            controller.titles[controller.currentIndex],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: controller.screens[controller.currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (controller.isBottomSheetShown) {
              if (formKey.currentState!.validate()) {
                // insert here the data base first before closing the bottom sheet

                controller.insertDatabase();

                controller.isBottomSheetShown = false;
                controller.changeBottomSheetIcon(
                  isShown: false,
                  icon: const Icon(Icons.edit),
                );
              }
            } else {
              /// the bottom sheet is closed so open it
              bottomSheet(context);

              controller.isBottomSheetShown = true;
              // change the state
              controller.changeBottomSheetIcon(
                  isShown: true,
                  icon: const Icon(
                    Icons.add,
                  ));
            }
          },
          child: controller.fabIcon,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          currentIndex: controller.currentIndex,
          onTap: (index) => controller.changeIndex(index),
        ),
      ),
    );
  }

  void bottomSheet(BuildContext context) {
    scaffoldKey.currentState!
        .showBottomSheet((context) {
          return Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.black12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputField(
                    hint: 'Task Title',
                    isReadOnly: false,
                    icon: const Icon(Icons.title),
                    controller: controller.titleController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Title must not be empty';
                      }
                      return null;
                    },
                  ),
                  InputField(
                    hint: 'Task Date',
                    isReadOnly: true,
                    icon: const Icon(Icons.calendar_today_outlined),
                    controller: controller.dateController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Date must not be empty';
                      }
                      return null;
                    },
                    onTap: () {
                      addDatePicker(context);
                    },
                  ),
                  InputField(
                    hint: 'Task Time',
                    isReadOnly: true,
                    icon: const Icon(Icons.access_time_outlined),
                    controller: controller.timeController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Time must not be empty';
                      }
                      return null;
                    },
                    onTap: () {
                      addTimePicker(context);
                    },
                  )
                ],
              ),
            ),
          );
        })
        .closed
        .then((_) {
          // when closing the bottom sheet
          controller.changeBottomSheetIcon(
              isShown: false, icon: const Icon(Icons.edit));
          controller.isBottomSheetShown = false;
        });
  }

  void addDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2025))
        .then(
      (value) =>
          // print('the date is ${DateFormat.yMMMd().format(value!)}'));
          controller.dateController.text = DateFormat.yMMMd().format(value!),
    );
  }

  void addTimePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (value) => controller.timeController.text = value!.format(context),
    );
  }
}
