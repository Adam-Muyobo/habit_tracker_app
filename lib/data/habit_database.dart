// reference our box

import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("habit_database");

class HabitDatabase{
  List todaysHabitList = [];

  // Create initial default data
  void createDefaultData(){
    todaysHabitList = [
      ["Morning Run", false],
      ["Stretch", false],
      ["Work Out", false],
      ["Drink Water", false],
      ["Do not smoke", false],
      ["No alcohol", false],
      ["Sleep Early", false],
    ];
  }
  // Load current data
  void loadData(){

  }
  // Update database
  void updateDatabase(){

  }
}