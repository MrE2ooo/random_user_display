// user_model.dart

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String thumbnail;

  User({required this.firstName, required this.lastName, required this.email, required this.thumbnail});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['name']['first'],
      lastName: json['name']['last'],
      email: json['email'],
      thumbnail: json['picture']['thumbnail'],
    );
  }
}
