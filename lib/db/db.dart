import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_app/constants/constants.dart';
import 'package:simple_todo_app/provider/controller.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? database;
  static MyController controller = Get.find();

  static Future<void> createDB() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (Database db, int version) async {
      // creating the table in the database
      print('database created');
      await db.execute(
          ' create table tasks (id integer primary key , title text, date text, time text, status text)');
      print('table created');
    }, onOpen: (Database db) {
      getDataFromDB(
          db); // here the method receives the db   >> because the db is done before the database above so if i rely on the database variable it will return null because it is not done yet
      print('Database opened');
    });

    //await deleteDatabase('todo.db');
  }

  static Future<void> insertIntoDB({
    required String title,
    required String date,
    required String time,
  }) async {
    await database!.transaction(
      (txn) async {
        txn
            .rawInsert(
          'INSERT INTO tasks (title, date, time, status) VALUES("$title", "$date", "$time" , "new" )',
        )
            .then(
          (value) async {
            print('id $value has been inserted successfully');
          },
        );
      },
    );

    getDataFromDB(database!);
  }

  // get the data from the database

  static void getDataFromDB(Database db) async {
    controller.newTasks = [];
    controller.doneTasks = [];
    controller.archivedTasks = [];

    db.rawQuery('SELECT * FROM tasks').then((value) {
      print('the data got successfully');
      print('This is the data got $value');
      value.forEach((element) {
        if (element['status'] == 'new')
          controller.newTasks.add(element);
        else if (element['status'] == 'done')
          controller.doneTasks.add(element);
        else
          controller.archivedTasks.add(element);
      });

      print(controller.newTasks);
      controller.update();
    });
  }

  // update the database

  static void updateDB({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then(
      (value) => getDataFromDB(database!),
    );
  }

// delete a record from the database
 static void deleteDB(int id) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then(
      (value) {
        getDataFromDB(database!);

      },
    );
  }
}
