// reference our box

import 'package:habbit_tracker_app/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("habit_database");

class HabitDatabase{
  List todaysHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};

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

    _myBox.put("START_DATE", todaysDateFormated());
  }
  // Load current data
  void loadData(){
    // If its a new day, get habit list from db
    if (_myBox.get(todaysDateFormated()) == null){
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      // Set all complete habits to false
      for(int i = 0; i< todaysHabitList.length; i++){
        todaysHabitList[i][1] = false;
      }
    }
    // If its not a new day, load todays list
    else {
      todaysHabitList =_myBox.get(todaysDateFormated());
    }
  }
  // Update database
  void updateDatabase(){
    // Update todays entry
    _myBox.put(todaysDateFormated(), todaysHabitList);
    // Update Universal Habit list in case it changed (new habit, edit habit, delete habit)
    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);
    // Calculate habit complete percentages for each day
    calculateHabitPercentages();
    //load heat map
    loadHeatMap();
  }
  void calculateHabitPercentages(){
    int countCompleted = 0;
    for (int i = 0; i<todaysHabitList.length;i++){
      if(todaysHabitList[i][1]){
        countCompleted++;
      }
    }
    String percent = todaysHabitList.isEmpty
        ? '0.0'
        :(countCompleted / todaysHabitList.length).toStringAsFixed(1);
    // Key: "PERCENTAGE_SUMMARY_yyyymmdd"
    // value: string of 1dp number between 0-1 inclusive
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormated()}", percent);
  }

  void loadHeatMap(){
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    // Count number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for(int i = 0; i<daysInBetween;i++){
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // Split the Date time up like below so it doesn't worry about time
      // year
      int year = startDate.add(Duration(days: i)).year;
      // month
      int month = startDate.add(Duration(days: i)).month;
      // Day
      int day = startDate.add(Duration(days: i)).day;

      final percentageForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentageForEachDay.entries);
      print(heatMapDataSet);
    }
  }

}