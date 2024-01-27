import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/components/habit_tile.dart';
import 'package:habbit_tracker_app/components/my_floating_action_button.dart';
import 'package:habbit_tracker_app/components/my_alert_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Data structure for today's list
  List todaysHabitList = [
    // [habitName, habitCompleted]
    ["Morning Run", false],
    ["Stretch", false],
    ["Work Out", false],
    ["Drink Water", false],
    ["Do not smoke", false],
    ["No alcohol", false],
    ["Sleep Early", false],
  ];

  // Check Box was Tapped
  void checkBoxTapped (bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value;
    });
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
  }
  // Saving the new habits
  void saveNewHabit(){
    // Add new habit to list
    setState(() {
      todaysHabitList.add([_newHabitNameController.text, false]);
    });
    // clear text field
    _newHabitNameController.clear();
    // Leave dialog
    Navigator.of(context).pop();
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
        hintText: todaysHabitList[index][0],
      );});
  }
  // Save existing habit with new name
  void saveExistingHabit (int index){
    setState(() {
      todaysHabitList[index][0] = _newHabitNameController.text;
    });
    // clear text field
    _newHabitNameController.clear();
    // Leave dialog
    Navigator.of(context).pop();
  }
  // Deleting a habit fr good!
  void deleteHabit(int index){
    setState(() {
      todaysHabitList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit,),
      body: ListView.builder(
        itemCount: todaysHabitList.length,
        itemBuilder: (BuildContext context, int index) {
          return HabitTile(
            habitName: todaysHabitList[index][0],
            habitCompleted: todaysHabitList[index][1],
            onChanged: (value) => checkBoxTapped(value, index),
            settingsTapped: (context) => openHabitSettings(index),
            deleteTapped: (context) => deleteHabit(index),
          );},
      ),
    );
  }
}
