import 'package:ahueni/components/my_task_tile.dart';
import 'package:ahueni/components/my_text_field.dart';
import 'package:ahueni/components/my_user_tile.dart';
import 'package:ahueni/models/user_sobriety.dart';
import 'package:ahueni/models/user_tasks.dart';
import 'package:ahueni/providers/task_provider.dart';
import 'package:ahueni/providers/user_sobriety_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ahueni/components/my_app_bar.dart';
import 'package:ahueni/components/my_button.dart';
import 'package:ahueni/components/my_drawer.dart';
import 'package:uuid/uuid.dart';

const List<String> commonAddictions = [
  'Alcohol',
  'Nicotine',
  'Cocaine',
  'Heroin',
  'Marijuana',
  'Methamphetamine',
  'Prescription Drugs',
  'Gambling',
  'Sex Addiction',
  'Internet Addiction',
  'Shopping',
  'Caffeine',
  'Food Addiction',
  'Video Games',
  'Social Media'
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedAddiction = commonAddictions.first;
  DateTime selectedStartDate = DateTime.now();
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    final userSobrietyProvider =
        Provider.of<UserSobrietyProvider>(context, listen: false);
    userSobrietyProvider.fetchSobrietyData();
  }

  @override
  Widget build(BuildContext context) {
    final userSobrietyProvider = Provider.of<UserSobrietyProvider>(context);
    final userSobriety = userSobrietyProvider.userSobriety;

    void editTask(BuildContext context, UserTask task) {
      // Initialize controllers with the current task data
      final TextEditingController taskTitleController =
          TextEditingController(text: task.title);
      final TextEditingController taskDescriptionController =
          TextEditingController(text: task.description);
      bool? isCompleted = task.isCompleted;

      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: MediaQuery.of(context).size.height * 0.17,
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Task',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      hintText: 'Title',
                      controller: taskTitleController,
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      hintText: 'Description',
                      controller: taskDescriptionController,
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: isCompleted,
                          onChanged: (bool? value) {
                            setState(() {
                              isCompleted = value ?? false;
                            });
                          },
                        ),
                        Text(
                          'Completed',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final userTaskProvider =
                                Provider.of<UserTaskProvider>(context,
                                    listen: false);
                            // Update the task with new values
                            final updatedTask = UserTask(
                              taskId: task.taskId,
                              title: taskTitleController.text,
                              description: taskDescriptionController.text,
                              isCompleted: isCompleted,
                              createdAt: task.createdAt,
                            );

                            userTaskProvider.updateTask(updatedTask);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Save'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final userTaskProvider =
                                Provider.of<UserTaskProvider>(context,
                                    listen: false);
                            userTaskProvider.deleteTask(task.taskId);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: const MyAppBar(title: 'Home'),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: userSobriety == null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Dropdown for selecting addiction
                    DropdownButton<String>(
                      value: selectedAddiction,
                      items: commonAddictions
                          .map((addiction) => DropdownMenuItem<String>(
                                value: addiction,
                                child: Text(addiction),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedAddiction = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    // Date picker for selecting start date
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedStartDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedStartDate = pickedDate;
                          });
                        }
                      },
                      child: Text(
                          "Select Start Date: ${DateFormat('dd-MM-yyyy').format(selectedStartDate)}"),
                    ),
                    const SizedBox(height: 20),
                    // Button to save and initialize the sobriety data
                    ElevatedButton(
                      onPressed: () {
                        // Initialize sobriety data
                        final newSobriety = UserSobriety(
                          startDate: selectedStartDate,
                          currentStreak: 0,
                          longestStreak: 0,
                          addiction: selectedAddiction,
                        );
                        userSobrietyProvider.updateSobrietyData(newSobriety);
                      },
                      child: const Text('Start Tracking Sobriety'),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Overcoming',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          DropdownButton<String>(
                            value: selectedAddiction,
                            items: commonAddictions
                                .map((addiction) => DropdownMenuItem<String>(
                                      value: addiction,
                                      child: Center(
                                        child: Text(
                                          addiction,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedAddiction = newValue!;
                                userSobrietyProvider.updateSobrietyData(
                                  UserSobriety(
                                    startDate: userSobriety.startDate,
                                    currentStreak: userSobriety.currentStreak,
                                    longestStreak: userSobriety.longestStreak,
                                    addiction: selectedAddiction,
                                  ),
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: 680,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 0.1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text(
                                'Sober Start Date: ',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 20),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  // Show the date picker
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: userSobriety.startDate,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                  );

                                  // If a date is picked, update the start date
                                  if (pickedDate != null &&
                                      pickedDate != userSobriety.startDate) {
                                    final userSobrietyProvider =
                                        Provider.of<UserSobrietyProvider>(
                                            context,
                                            listen: false);
                                    UserSobriety updatedSobriety = UserSobriety(
                                      startDate: pickedDate,
                                      currentStreak: userSobriety.currentStreak,
                                      longestStreak: userSobriety.longestStreak,
                                      addiction: userSobriety.addiction,
                                    );

                                    // Update the sobriety data with the new start date
                                    userSobrietyProvider
                                        .updateSobrietyData(updatedSobriety);
                                  }
                                },
                                child: Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(userSobriety.startDate.toLocal()),
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    widthFactor: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(250),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 2,
                        ),
                      ),
                      width: 250,
                      height: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Center(
                          widthFactor: 1,
                          child: Text(
                            '${userSobriety.sobrietyLength} Day(s) Sober',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: 680,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 0.1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text(
                                'Current Streak: ',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 20),
                              ),
                              Text(
                                '${userSobriety.sobrietyLength} Days',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyButton(
                        buttonText: 'Reset',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Confirm',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                                content: Text(
                                  'Are you sure you want to reset your sober start date to today?',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                                actions: <Widget>[
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(
                                      Icons.close,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Note',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                            ),
                                            content: Text(
                                              ' Your Accountability Partners will be notified about the relapse',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                            ),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Get the current date
                                                  DateTime today =
                                                      DateTime.now();

                                                  // Update the sobriety start date to today
                                                  final userSobrietyProvider =
                                                      Provider.of<
                                                              UserSobrietyProvider>(
                                                          context,
                                                          listen: false);

                                                  if (userSobrietyProvider
                                                          .userSobriety !=
                                                      null) {
                                                    // If there is existing sobriety data, update it with the new start date
                                                    UserSobriety
                                                        updatedSobriety =
                                                        UserSobriety(
                                                      startDate: today,
                                                      currentStreak:
                                                          0, // Reset the current streak
                                                      longestStreak:
                                                          userSobrietyProvider
                                                              .userSobriety!
                                                              .longestStreak,
                                                      addiction:
                                                          userSobrietyProvider
                                                              .userSobriety!
                                                              .addiction,
                                                    );

                                                    userSobrietyProvider
                                                        .updateSobrietyData(
                                                            updatedSobriety);
                                                  } else {
                                                    // If there's no existing sobriety data, create new data
                                                    UserSobriety newSobriety =
                                                        UserSobriety(
                                                      startDate: today,
                                                      currentStreak: 0,
                                                      longestStreak: 0,
                                                      addiction: commonAddictions
                                                          .first, // Default to the first addiction or choose accordingly
                                                    );

                                                    userSobrietyProvider
                                                        .updateSobrietyData(
                                                            newSobriety);
                                                  }

                                                  // Close the dialog or provide feedback
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.check,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      MyButton(
                          buttonText: 'Add Tasks',
                          onTap: () {
                            addTasks(context);
                          }),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: 680,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 0.1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'My Tasks',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    widthFactor: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 2,
                        ),
                      ),
                      width: 320,
                      child: Consumer<UserTaskProvider>(
                        builder: (context, userTaskProvider, child) {
                          final tasks = userTaskProvider.tasks;
                          return tasks.isEmpty
                              ? const Center(child: Text('No tasks available'))
                              : ListView.builder(
                                  itemCount: tasks.length,
                                  itemBuilder: (context, index) {
                                    final task = tasks[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: MyTaskTile(
                                        text: task.title,
                                        onTap: () {
                                          editTask(context,
                                              task); 
                                        },
                                      ),
                                    );
                                  },
                                );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<dynamic> addTasks(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: 16.0, // Adjust the horizontal padding as needed
            vertical: MediaQuery.of(context).size.height *
                0.17, // Adjust the vertical padding to occupy 2/3 of the height
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Task',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                      hintText: 'Title',
                      controller: _taskTitleController,
                      obscureText: false),
                  const SizedBox(height: 10),
                  MyTextField(
                      hintText: 'Description',
                      controller: _taskDescriptionController,
                      obscureText: false),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: isCompleted,
                        onChanged: (bool? value) {
                          setState(() {
                            isCompleted = value ?? false;
                          });
                        },
                      ),
                      Text(
                        'Completed',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final userTaskProvider =
                              Provider.of<UserTaskProvider>(context,
                                  listen: false);
                          final newTask = UserTask(
                            taskId: const Uuid()
                                .v4(), // Generate a unique ID using uuid
                            title: _taskTitleController.text,
                            description: _taskDescriptionController.text,
                            isCompleted: isCompleted,
                            createdAt: DateTime.now(),
                          );

                          // Add the task to the provider
                          userTaskProvider.addTask(newTask);

                          // Clear the controllers
                          _taskTitleController.clear();
                          _taskDescriptionController.clear();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
