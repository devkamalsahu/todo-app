class UserProfile {
  final String userId;
  final String name;
  final String email;

  // constructer
  UserProfile({required this.userId, required this.name, required this.email});

  // converts object -> json
  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'name': name, 'email': email};
  }

  // converts json -> object
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
