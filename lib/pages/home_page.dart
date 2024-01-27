import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/components/habit_tile.dart';
import 'package:habbit_tracker_app/components/my_floating_action_button.dart';
import 'package:habbit_tracker_app/components/new_habit_box.dart';

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
  void createNewHabit (){
    // Show alert dialog for user to create new habit
    showDialog(context: context, builder: (context) {
      return  const EnterNewHabitBox();
    },);
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
          );},
      ),
    );
  }
}
