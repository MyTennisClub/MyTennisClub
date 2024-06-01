import 'package:mytennisclub/Database/ConnectionDatabase.dart';

class Clublist {
  static String capitalizeFields(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  static Future<List<List<dynamic>>> retrieveClubs() async {
    List<List<dynamic>> clubs = [];
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        var results = await conn.query(
          "SELECT TennisClub.club_id,club_name,club_address,club_latitude,club_longitude,field_type,court_covered,court_equipment FROM TennisClub RIGHT JOIN Courts ON tennisclub.club_id = Courts.court_club_id WHERE court_only_for_members=0 and Courts.court_status='AVAILABLE';",
        );

        if (results.isNotEmpty) {
          for (var row in results) {
            clubs.add([
              row['club_id'],
              row['club_name'],
              row['club_latitude'],
              row['club_longitude'],
              (row['court_covered'] == 1) ? 'Covered' : 'Not Covered',
              capitalizeFields(row['field_type']),
              (row['court_equipment'] == 1) ? 'Has equipment' : 'No equipment',
              row['club_address'],
            ]);
          }
          print(clubs);
          await conn.close();
        } else {
          await conn.close();
          throw Exception('No clubs found');
        }
      }
    } catch (e) {
      throw Exception('Error fetching clubs: $e');
    }

    return clubs;
  }
}
