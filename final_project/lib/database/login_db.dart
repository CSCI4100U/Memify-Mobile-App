import 'package:sqflite/sqflite.dart';
import 'account.dart';
import 'database_service.dart';

class LoginDB {
  final tableName = 'account';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL
    );""");
  }

  Future<int> rememberAccount(
      {required String email, required String password}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
        """INSERT INTO $tableName (email, password) VALUES (?, ?)""",
        [email, password]);
  }

  Future<Map<String, String>> fetchAccount() async {
    final database = await DatabaseService().database;
    final account =
        await database.rawQuery("""SELECT * FROM $tableName LIMIT 1""");

    if (account.isNotEmpty) {
      final login = Account.fromSqfliteDatabase(account.first);
      return {'email': login.email, 'password': login.password};
    } else {
      return {'email': '', 'password': ''};
    }
  }

  Future<void> forgetAccount() async {
    final database = await DatabaseService().database;
    await database.rawDelete("""DELETE FROM $tableName""");
  }
}
