import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  // initialize Hive
  await Hive.initFlutter();
  // Open Box
  await Hive.openBox("habit_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
