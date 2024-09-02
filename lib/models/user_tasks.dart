class UserTask {
  final String taskId;
  final String title;
  final String description;
  bool? isCompleted;
  final DateTime createdAt;

  UserTask({
    required this.taskId,
    required this.title,
    required this.description,
    this.isCompleted,
    required this.createdAt,
  });

  /// Converts the [UserTask] instance to a map representation.
  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Creates a [UserTask] instance from a map.
  factory UserTask.fromMap(Map<String, dynamic> map) {
    return UserTask(
      taskId: map['taskId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
