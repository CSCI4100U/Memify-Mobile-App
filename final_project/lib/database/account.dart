class Account {
  final String email;
  final String password;

  Account({required this.email, required this.password});

  factory Account.fromSqfliteDatabase(Map<String, dynamic> map) => Account(
        email: map['email'] ?? '',
        password: map['password'] ?? '',
      );
}
