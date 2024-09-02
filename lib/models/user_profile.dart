class UserProfile {
  final String uid;
  final String email;
  final String name;
  final String username;
  final String phoneNumber;
  final String bio;
  final String location;
  String profileImageUrl;

  UserProfile({
    required this.uid,
    required this.email,
    required this.name,
    required this.username,
    required this.phoneNumber,
    required this.bio,
    required this.location,
    required this.profileImageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'username': username,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'location': location,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      bio: map['bio'] ?? '',
      location: map['location'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
    );
  }

  void updateProfileImageUrl(String url) {
    profileImageUrl = url;
  }
}
