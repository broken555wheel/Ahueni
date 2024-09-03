import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:ahueni/components/my_app_bar.dart';
import 'package:ahueni/components/my_drawer.dart';
import 'package:ahueni/components/my_button.dart';
import 'package:ahueni/components/my_task_tile.dart';
import 'package:ahueni/models/user_sobriety.dart';
import 'package:ahueni/models/user_tasks.dart';
import 'package:ahueni/providers/task_provider.dart';
import 'package:ahueni/providers/user_sobriety_provider.dart';
import 'package:ahueni/services/auth/auth_service.dart';
import 'package:ahueni/services/chat/chat_service.dart';
import 'package:uuid/uuid.dart';

const List<String> commonAddictions = [
  'Alcohol', 'Nicotine', 'Cocaine', 'Heroin', 'Marijuana',
  'Methamphetamine', 'Prescription Drugs', 'Gambling',
  'Sex Addiction', 'Internet Addiction', 'Shopping',
  'Caffeine', 'Food Addiction', 'Video Games', 'Social Media'
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController = TextEditingController();
  String selectedAddiction = commonAddictions.first;
  DateTime selectedStartDate = DateTime.now();
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    final userSobrietyProvider = Provider.of<UserSobrietyProvider>(context, listen: false);
    userSobrietyProvider.fetchSobrietyData();
  }

  @override
  Widget build(BuildContext context) {
    final userSobrietyProvider = Provider.of<UserSobrietyProvider>(context);
    final userSobriety = userSobrietyProvider.userSobriety;

    return Scaffold(
      appBar: const MyAppBar(title: 'Home'),
      drawer: const MyDrawer(),
      body: userSobriety == null
          ? _buildInitialSetupView()
          : _buildMainView(userSobriety),
    );
  }

  Widget _buildInitialSetupView() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
            Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          ],
        ),
      ),
      child: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const  EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Start Your Journey',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const  SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  value: selectedAddiction,
                  decoration: const InputDecoration(
                    labelText: 'Select Addiction',
                    border: OutlineInputBorder(),
                  ),
                  items: commonAddictions.map((addiction) {
                    return DropdownMenuItem(value: addiction, child: Text(addiction));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedAddiction = value!;
                    });
                  },
                ),
                const  SizedBox(height: 16),
                OutlinedButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  label: Text('Select Start Date: ${DateFormat('dd-MM-yyyy').format(selectedStartDate)}'),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedStartDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        selectedStartDate = picked;
                      });
                    }
                  },
                ),
                const  SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    final newSobriety = UserSobriety(
                      startDate: selectedStartDate,
                      currentStreak: 0,
                      longestStreak: 0,
                      addiction: selectedAddiction,
                    );
                    Provider.of<UserSobrietyProvider>(context, listen: false)
                        .updateSobrietyData(newSobriety);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text('Begin Tracking'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainView(UserSobriety userSobriety) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overcoming ${userSobriety.addiction}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          '${userSobriety.sobrietyLength}',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                          'Days Sober',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Start Date: ${DateFormat('MMM d, y').format(userSobriety.startDate)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    OutlinedButton(
                      onPressed: () => _showEditStartDateDialog(context, userSobriety),
                      style: OutlinedButton.styleFrom(
                        iconColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                      ),
                      child: const Text('Edit'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyButton(
                      buttonText: 'Reset',
                      onTap: () => _showResetConfirmationDialog(context),
                    ),
                    MyButton(
                      buttonText: 'Add Tasks',
                      onTap: () => _showAddTaskDialog(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Tasks',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Consumer<UserTaskProvider>(
                      builder: (context, taskProvider, child) {
                        return taskProvider.tasks.isEmpty
                            ? const Center(child: Text('No tasks available'))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: taskProvider.tasks.length,
                                itemBuilder: (context, index) {
                                  final task = taskProvider.tasks[index];
                                  return MyTaskTile(
                                    text: task.title.toUpperCase(),
                                    onTap: () => _showEditTaskDialog(context, task),
                                  );
                                },
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showEditStartDateDialog(BuildContext context, UserSobriety userSobriety) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: userSobriety.startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != userSobriety.startDate) {
      final userSobrietyProvider = Provider.of<UserSobrietyProvider>(context, listen: false);
      UserSobriety updatedSobriety = UserSobriety(
        startDate: picked,
        currentStreak: userSobriety.currentStreak,
        longestStreak: userSobriety.longestStreak,
        addiction: userSobriety.addiction,
      );
      userSobrietyProvider.updateSobrietyData(updatedSobriety);
    }
  }

  void _showResetConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Reset'),
        content: const Text('Are you sure you want to reset your sober start date to today?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text('Reset'),
            onPressed: () {
              Navigator.pop(context);
              _resetSobriety(context);
            },
          ),
        ],
      ),
    );
  }

  void _resetSobriety(BuildContext context) async {
    final userSobrietyProvider = Provider.of<UserSobrietyProvider>(context, listen: false);
    final currentSobriety = userSobrietyProvider.userSobriety;
    if (currentSobriety != null) {
      UserSobriety updatedSobriety = UserSobriety(
        startDate: DateTime.now(),
        currentStreak: 0,
        longestStreak: currentSobriety.longestStreak,
        addiction: currentSobriety.addiction,
      );
      await userSobrietyProvider.updateSobrietyData(updatedSobriety);
      await _sendRelapseMessageToAccountabilityPartners(context);
    }
  }

  Future<void> _sendRelapseMessageToAccountabilityPartners(BuildContext context) async {
    final chatService = ChatService();
    final authService = AuthService();
    final currentUser = authService.getCurrentUser();
    if (currentUser == null) return;

    const message = "I have reset my sobriety start date to today.";
    final partnersStream = chatService.getUserStreamExcludingBlocked();

    partnersStream.listen((partners) async {
      for (var partner in partners) {
        final receiverId = partner['uid'];
        await chatService.sendMessage(receiverId, message);
      }
    });
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskTitleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _taskDescriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text('Add'),
            onPressed: () {
              final taskProvider = Provider.of<UserTaskProvider>(context, listen: false);
              final newTask = UserTask(
                taskId: const Uuid().v4(),
                title: _taskTitleController.text,
                description: _taskDescriptionController.text,
                isCompleted: false,
                createdAt: DateTime.now(),
              );
              taskProvider.addTask(newTask);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showEditTaskDialog(BuildContext context, UserTask task) {
    final TextEditingController titleController = TextEditingController(text: task.title);
    final TextEditingController descriptionController = TextEditingController(text: task.description);
    bool? isCompleted = task.isCompleted;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            Row(
              children: [
                Checkbox(
                  value: isCompleted,
                  onChanged: (value) {
                    setState(() {
                      isCompleted = value ?? false;
                    });
                  },
                ),
                const Text('Completed'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              final taskProvider = Provider.of<UserTaskProvider>(context, listen: false);
              final updatedTask = UserTask(
                taskId: task.taskId,
                title: titleController.text,
                description: descriptionController.text,
                isCompleted: isCompleted,
                createdAt: task.createdAt,
              );
              taskProvider.updateTask(updatedTask);
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Delete'),
            onPressed: () {
              final taskProvider = Provider.of<UserTaskProvider>(context, listen: false);
              taskProvider.deleteTask(task.taskId);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}