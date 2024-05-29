import 'dart:async';
import 'package:mysql1/mysql1.dart';

class DbConnection {
  final String host;
  final int port;
  final String user;
  final String password;
  final String db;

  DbConnection({
    required this.host,
    required this.port,
    required this.user,
    required this.password,
    required this.db,
  });

  Future<MySqlConnection> openConnection() async {
    final settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }
}
