import 'package:mytennisclub/models/member.dart';

import '../Database/ConnectionDatabase.dart';

class Athletes extends Member {
  Athletes(
      {required super.calendar,
      required super.searchHistory,
      required super.bookHistory,
      required super.reservations,
      required super.reviews,
      required super.id,
      required super.fullname,
      required super.tel,
      required super.address,
      required super.birthdate,
      required super.email,
      required super.startDate});

  static Future<List<Map<String, dynamic>>> fetchAthletesFromClub(
      int clubId) async {
    List<Map<String, dynamic>> athletes = [];
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        var result =
            (await conn.query('CALL fetch_athletes_from_club(?)', [clubId]));

        // Convert the result to a list of maps
        for (var row in result) {
          athletes.add({
            'user_id': row[0],
            // Assuming the first column is user_id
            'user_first_name': row[1],
            // Assuming the second column is user_first_name
            'user_last_name': row[2],
            // Assuming the third column is user_last_name
          });
        }
        await conn.close();
      }
    } catch (e) {
      throw Exception('Error fetching reservation: $e');
    }

    return athletes;
  }
}
