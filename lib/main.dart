import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_app/provider/controller.dart';
import 'view/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MyController());

  MyController controller = Get.find();

  controller.createDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
