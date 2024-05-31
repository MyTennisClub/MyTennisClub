import 'dart:typed_data';
import 'package:mytennisclub/models/person.dart';
import 'package:mytennisclub/Database/ConnectionDatabase.dart';

class Guest extends Person {
  const Guest({
    required this.searchHistory,
    required this.bookHistory,
    required this.reservations,
    required this.reviews,
    required super.id,
    required super.fullname,
    required super.tel,
    required super.address,
    required super.birthdate,
    required super.email,
    required super.startDate,
  });

  final List<String> searchHistory;
  final List<String> bookHistory;
  final List<String> reservations;
  final List<String> reviews;

  // IN p_full_name VARCHAR(255),
  // IN p_phone VARCHAR(50),
  // IN p_address VARCHAR(255),
  // IN p_email VARCHAR(100),
  // IN p_birth_date DATE,
  // IN p_identification BLOB,
  // IN p_doctors_note BLOB,
  // IN p_tennis_club_id INT,
  // IN p_guest_id INT
  static Future<void> youMemberApply(String fullName , String phone, String address, String email, String birth, Uint8List? identificationEnterted ,int tennisClubId, int guestId) async {
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        await conn.query(
          'CALL you_member_apply(?,?,?,?,?,?,?,?);',
          [fullName, phone, address ,email ,birth,identificationEnterted,tennisClubId ,guestId]  ,
        );

        print('object');

      }
    } catch (e) {
      throw Exception('Error fetching reservation: $e');
    }
  }

  // static Future<void> fet(String fullName , String phone, String address, String email, DateTime birthDate, Uint8List identification, Uint8List p_identification,Uint8List  doctorsNote, int tennisClubId, int guestId) async {
  //   try {
  //     final conn = await MySQLConnector.createConnection();
  //     if (conn != null) {
  //       await conn.query(
  //         'CALL you_member_apply(?,?,?,?,?,?,?,?,?);',
  //         [fullName, phone, address ,email ,birthDate ,identification ,p_identification ,doctorsNote,tennisClubId ,guestId]  ,
  //       );
  //
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching reservation: $e');
  //   }
  // }

}
