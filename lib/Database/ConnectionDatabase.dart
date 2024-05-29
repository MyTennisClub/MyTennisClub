import 'package:mysql1/mysql1.dart';
import 'DatabaseConfig.dart';


class MySQLConnector {
  // Static method to create and return a connection
  static Future<MySqlConnection?> createConnection() async {
    MySqlConnection? connection;

    try {
      connection = await MySqlConnection.connect(ConnectionSettings(
        host: DatabaseConfig.getHost(),
        port: DatabaseConfig.getPort(),
        user: DatabaseConfig.getUserName(),
        password: DatabaseConfig.getPassword(),
        db: DatabaseConfig.getDatabaseName(),
      ));
      print('Connected to database');
      return connection;
    } catch (e) {
      print('An error occurred while connecting to the database: $e');
      return null;
    }
  }
}
