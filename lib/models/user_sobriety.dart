class UserSobriety {
  final DateTime startDate;
  DateTime? endDate;
  int currentStreak; // in days
  int longestStreak; // in days
  String addiction;  // The addiction the user is overcoming

  UserSobriety({
    required this.startDate,
    this.endDate,
    required this.currentStreak,
    required this.longestStreak,
    required this.addiction,  // Initialize addiction
  });

  // Calculate the length of sobriety based on the startDate and endDate
  int get sobrietyLength {
    final end = endDate ?? DateTime.now();
    return end.difference(startDate).inDays;
  }

  // Convert the object to a Map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'addiction': addiction,
    };
  }

  // Create an instance from a Firestore Map
  factory UserSobriety.fromMap(Map<String, dynamic> map) {
    return UserSobriety(
      startDate: DateTime.parse(map['startDate']),
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      currentStreak: map['currentStreak'] ?? 0,
      longestStreak: map['longestStreak'] ?? 0,
      addiction: map['addiction'] ?? 'Unknown',
    );
  }
}
