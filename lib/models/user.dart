class User {
  final String name; 
  final String email;
  final String password; 

  User({
    required this.name,
    required this.email,
    this.password = '',
  });

  // create a user from the jsonm data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

//update user info
  User copyWith({String? name, String? email}) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password,
    );
  }
}
