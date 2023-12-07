class Options {
  final String email;
  String pfp;
  int notifications;
  int autoLogin;

  Options(
      {required this.email,
      required this.pfp,
      required this.notifications,
      required this.autoLogin});

  factory Options.fromSqfliteDatabase(Map<String, dynamic> map) => Options(
      email: map['email'] ?? '',
      pfp: map['pfp'] ??
          "https://soccerpointeclaire.com/wp-content/uploads/2021/06/default-profile-pic-e1513291410505.jpg",
      notifications: map['notifications'] ?? 0,
      autoLogin: map['autoLogin'] ?? 0);
}
