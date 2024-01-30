import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/components/habit_tile.dart';
import 'package:habbit_tracker_app/components/monthly_summary.dart';
import 'package:habbit_tracker_app/components/my_floating_action_button.dart';
import 'package:habbit_tracker_app/components/my_alert_box.dart';
import 'package:habbit_tracker_app/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase dB = HabitDatabase();
  final _myBox = Hive.box("habit_database");

  @override
  void initState() {
    // if the is no current habit list(no data)
    if(_myBox.get("CURRENT_HABIT_LIST") == null){
      dB.createDefaultData();
    }
    // Data already exists
    else{
      dB.loadData();
    }
    // Update local database
    dB.updateDatabase();
    super.initState();
  }

  // Check Box was Tapped
  void checkBoxTapped (bool? value, int index) {
    setState(() {
      dB.todaysHabitList[index][1] = value;
    });
    dB.updateDatabase();
  }
  // Create a new habit
  final _newHabitNameController = TextEditingController();
  void createNewHabit (){
    // Show alert dialog for user to create new habit
    showDialog(context: context, builder: (context) {
      return MyAlertBox(
        controller: _newHabitNameController,
        onSave: saveNewHabit,
        onCancel: cancelDialogBox,
        hintText: "Enter Habit Name...",
      );
    },);
    dB.updateDatabase();
  }
  // Saving the new habits
  void saveNewHabit(){
    // Add new habit to list
    setState(() {
      dB.todaysHabitList.add([_newHabitNameController.text, false]);
    });
    // clear text field
    _newHabitNameController.clear();
    // Leave dialog
    Navigator.of(context).pop();
    dB.updateDatabase();
  }

  // Cancelling habits
  void cancelDialogBox(){
    // clear text field
    _newHabitNameController.clear();
    // Leave dialog
    Navigator.of(context).pop();
  }
  // Editing our habits
  void openHabitSettings(int index){
    showDialog(context: context, builder: (context){
      return MyAlertBox(
        controller: _newHabitNameController,
        onSave: () => saveExistingHabit(index),
        onCancel: cancelDialogBox,
        hintText: dB.todaysHabitList[index][0],
      );});
  }
  // Save existing habit with new name
  void saveExistingHabit (int index){
    setState(() {
      dB.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    // clear text field
    _newHabitNameController.clear();
    // Leave dialog
    Navigator.of(context).pop();
    dB.updateDatabase();
  }
  // Deleting a habit fr good!
  void deleteHabit(int index){
    setState(() {
      dB.todaysHabitList.removeAt(index);
    });
    dB.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit,),
      body: ListView(
        children: [
          // Heat Map
          MonthlySummary(datasets: dB.heatMapDataSet, startDate: _myBox.get("START_DATE")),
          // Habits
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dB.todaysHabitList.length,
            itemBuilder: (BuildContext context, int index) {
              return HabitTile(
                habitName: dB.todaysHabitList[index][0],
                habitCompleted: dB.todaysHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                settingsTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );},
          ),
        ],
      ),
    );
  }
}
