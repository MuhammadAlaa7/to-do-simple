import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_app/db/db.dart';
import '../view/screens/archived_screen.dart';
import '../view/screens/done_screen.dart';
import '../view/screens/new_tasks_screen.dart';

class MyController extends GetxController {
  int currentIndex = 0;
  List<Widget> screens = [
    NewTasks(),
    DoneScreen(),
    ArchivedScreen(),
  ];
  final List<String> titles = ['Tasks', 'Done', 'Archived'];

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }

  Icon fabIcon = const Icon(Icons.edit);
  bool isBottomSheetShown = false;

  void changeBottomSheetIcon({
    required bool isShown,
    required Icon icon,
  }) {
    isBottomSheetShown = isShown;
    fabIcon = icon;

    update();
  }

  List newTasks = [];
  List doneTasks = [];
  List archivedTasks = [];

  // create database
  void createDatabase() async {
    await DbHelper.createDB();
  }

  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

// insert database
  void insertDatabase() async {
    await DbHelper.insertIntoDB(
      title: titleController.text,
      date: dateController.text,
      time: timeController.text,
    );
    update();
    // CLOSE THE BOTTOM SHEET AFTER COMPLETING THE INSERTION
    Get.back();
  }

// update the database
  void updateDatabase({
    required String status,
    required int id,
  }) {
    DbHelper.updateDB(status: status, id: id);

    update();
   //  print('The database updated...');
  }

  void deleteDatabase(int id) {
    DbHelper.deleteDB(id);
   // print(' $id has been deleted successfully');
  }





}
