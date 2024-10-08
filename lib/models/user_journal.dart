class UserJournal {
  final String journalId;
  final String title;
  final String body;
  final DateTime createdAt;
  String userId;

  UserJournal({
    required this.journalId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.userId
  });

  // Convert a UserJournal to a map to save in the database
  Map<String, dynamic> toMap() {
    return {
      'journalId': journalId,
      'title': title,
      'body': body,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create a UserJournal from a map
  factory UserJournal.fromMap(Map<String, dynamic> map) {
    return UserJournal(
      journalId: map['journalId'],
      title: map['title'],
      body: map['body'],
      userId: map['userId'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
