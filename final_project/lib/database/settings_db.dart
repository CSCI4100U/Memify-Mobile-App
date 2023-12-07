import 'package:sqflite/sqflite.dart';
import 'options.dart';
import 'database_service.dart';

class SettingsDB {
  // all user settings will be saved locally (linked to email)
  final tableName = 'settings';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
    "email" TEXT NOT NULL DEFAULT "",
    "pfp" TEXT NOT NULL DEFAULT "https://soccerpointeclaire.com/wp-content/uploads/2021/06/default-profile-pic-e1513291410505.jpg",
    "notifications" INTEGER NOT NULL DEFAULT 0,
    "autoLogin" INTEGER NOT NULL DEFAULT 0
    );""");
  }

  Future<void> rememberSettings(
      {required String email,
      required String pfp,
      required int notifications,
      required int autoLogin}) async {
    final database = await DatabaseService().database;

    await database.rawInsert(
        """INSERT INTO $tableName (email, pfp, notifications, autoLogin) VALUES (?, ?, ?, ?)""",
        [email, pfp, notifications, autoLogin]);
  }

  Future<void> updatePfp(String newPfp, String email) async {
    final database = await DatabaseService().database;
    await database.rawUpdate(
      """UPDATE $tableName SET pfp = ? WHERE email = ?""",
      [newPfp, email],
    );
  }

  Future<void> updateNotifications(String email) async {
    final database = await DatabaseService().database;
    await database.rawUpdate(
      """UPDATE $tableName SET notifications = CASE WHEN notifications = 1 THEN 0 ELSE 1 END WHERE email = ?""",
      [email],
    );
  }

  Future<void> updateAutoLogin(String email) async {
    final database = await DatabaseService().database;
    await database.rawUpdate(
      """UPDATE $tableName SET autoLogin = CASE WHEN autoLogin = 1 THEN 0 ELSE 1 END WHERE email = ?""",
      [email],
    );
  }

  Future<bool> isNotificationsDisabled(String? email) async {
    if (email == null) {
      return false;
    }
    final databaseService = DatabaseService();
    final database = await databaseService.database;
    final result = await database.rawQuery(
        """SELECT notifications FROM $tableName WHERE email = ? LIMIT 1""",
        [email]);

    if (result.isNotEmpty) {
      return result.first['notifications'] == 1;
    } else {
      return false;
    }
  }

  Future<bool> isAutoLoginDisabled(String email) async {
    final databaseService = DatabaseService();
    final database = await databaseService.database;
    final result = await database.rawQuery(
        """SELECT autoLogin FROM $tableName WHERE email = ? LIMIT 1""",
        [email]);

    if (result.isNotEmpty) {
      return result.first['autoLogin'] == 1;
    } else {
      return false;
    }
  }

  Future<Options> fetchSettings(String email) async {
    final databaseService = DatabaseService();
    final database = await databaseService.database;
    final optionsList = await database.rawQuery(
        """SELECT * FROM $tableName WHERE email = ? LIMIT 1""", [email]);

    if (optionsList.isNotEmpty) {
      final optionsMap = optionsList.first;
      return Options.fromSqfliteDatabase(optionsMap);
    } else {
      // Handle the case where no options were found for the given email.
      // You can return a default Options instance or handle it as needed.
      return Options(
        email: email,
        pfp:
            "https://soccerpointeclaire.com/wp-content/uploads/2021/06/default-profile-pic-e1513291410505.jpg",
        notifications: 0,
        autoLogin: 0,
      );
    }
  }
}
