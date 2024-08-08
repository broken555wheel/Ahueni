class UserTasks {
  final String title;
  bool value;

  UserTasks({required this.title, required this.value});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'value': value,
    };
  }

  factory UserTasks.fromMap(Map<String, dynamic> map) {
    return UserTasks(
      title: map['title'] ?? '',
      value: map['value'] ?? false,
    );
  }
}
