class User {
  final String name; // corresponds to Laravel 'name'
  final String email;
  final String password; // optional, we won't store real password

  User({
    required this.name,
    required this.email,
    this.password = '',
  });

  // Helper: create a User from JSON (from API)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

//Helper: for updating user info
  User copyWith({String? name, String? email}) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password,
    );
  }
}
