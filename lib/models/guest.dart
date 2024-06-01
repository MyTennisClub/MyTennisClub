import 'dart:typed_data';
import 'package:flutter/foundation.dart';
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
    // required super.accDate,
    // required super.hasChildren,
    // required super.identification,
    // required super.doctorsfile,
    // required super.solemn,
  });

  final List<String> searchHistory;
  final List<String> bookHistory;
  final List<String> reservations;
  final List<String> reviews;

  static Future<void> guestApply(
      Uint8List? p_identification,
      Uint8List? p_doctors_note,
      String p_to_become,
      int p_tennis_club_id,
      int p_user_id) async {
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        await conn.query('CALL you_member_apply(?,?,?,?,?);', [
          p_identification,
          p_doctors_note,
          p_to_become,
          p_tennis_club_id,
          p_user_id
        ]);
      }
    } catch (e) {
      throw Exception('Error creating request: $e');
    }
  }

  static Future<void> kidApply(
      Uint8List? p_identification,
      Uint8List? p_doctors_note,
      Uint8List? p_solemn_decl,
      String p_to_become,
      int p_tennis_club_id,
      int p_guardian_id,
      String p_first_name,
      String p_last_name,
      DateTime p_birth_date,
      String p_email,
      String p_phone,
      String p_address) async {
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        await conn.query('CALL kid_apply_to_club(?,?,?,?,?,?,?,?,?,?,?);', [
          p_identification,
          p_doctors_note,
          p_to_become,
          p_tennis_club_id,
          p_guardian_id,
          p_first_name,
          p_last_name,
          p_birth_date,
          p_email,
          p_phone,
          p_address
        ]);
      }
    } catch (e) {
      throw Exception('Error creating request: $e');
    }
  }

  static Future<List<dynamic>> getUserInfo(int guestID) async {
    List<dynamic> guestInfo = [];
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        var result = await conn.query(
          'CALL get_user_info(?);',
          [guestID],
        );

        if (result.isNotEmpty) {
          var row = result.first;

          guestInfo = [
            row['full_name'],
            row['user_address'],
            row['user_email'],
            row['user_phone'],
            row['user_birth_date']
          ];
          await conn.close();
        } else {
          await conn.close();
          throw Exception('No guest found with the given ID');
        }
      }
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
    return guestInfo;
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
