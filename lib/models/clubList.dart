import 'package:mytennisclub/Database/ConnectionDatabase.dart';

class Clublist {
  static String capitalizeFields(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  static Future<List<List<dynamic>>> retrieveClubs(
      var covered, var field, var equipment) async {
    List<List<dynamic>> clubs = [];
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        var results = await conn
            .query("call getClubs(?,?,?)", [covered, field, equipment]);

        if (results.isNotEmpty) {
          for (var row in results) {
            clubs.add([
              row['club_id'],
              row['club_name'],
              row['club_latitude'],
              row['club_longitude'],
              row['club_address'],
            ]);
          }
          await conn.close();
        } else {
          await conn.close();
          return [];
        }
      }
    } catch (e) {
      throw Exception('Error fetching clubs: $e');
    }

    return clubs;
  }
}
