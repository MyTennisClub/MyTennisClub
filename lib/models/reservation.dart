import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mytennisclub/Database/ConnectionDatabase.dart';
import 'package:intl/intl.dart';

enum Type {
  valid,
  invalid,
}

class Reservation {
  Reservation({
    required this.resId,
    required this.status,
    required this.date,
    required this.duration,
    required this.noPeople,
    required this.courtId,
    required this.equipment,
  }) {
    qrCode = QrImageView(
      data: resId.toString(),
      version: QrVersions.auto,
      gapless: false,
    ); // Call function to generate QR code
  }

  final int resId;
  final Type status;
  final DateTime date;
  final String duration;
  final int noPeople;
  final int courtId;
  final Bool equipment;
  late Widget qrCode;

  static Future<Map<String, dynamic>> fetchReservationFromDb(int id) async {
    Map<String, dynamic> reservationMap = {};
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        var reservation = await conn.query(
          'SELECT * FROM courtreservations WHERE res_id = ?',
          [id],
        );

        if (reservation.isNotEmpty) {
          var row = reservation.first;

          reservationMap = {
            'id': row['res_id'],
            'court': row['res_court_id'],
            'start_time': row['res_start_date'],
            'end_time': row['res_end_date'],
            'res_type': row['res_type'],
            'status': row['res_status'],
          };

          await conn.close();
        } else {
          await conn.close();
          throw Exception('No reservation found with the given ID');
        }
      }
    }
    catch (e) {
      throw Exception('Error fetching reservation: $e');
    }

    return reservationMap;
  }

  static Future<String> createPrivateCoachSession(
      int clubId,
      int courtId,
      String startTime,
      String endTime,
      int numPeople,
      int coachId,
      String memberIds,
      DateTime enteredDate,
      ) async {
    String errorCode = '';
    try {
      final conn = await MySQLConnector.createConnection();

      if (conn != null) {
        final results = await conn.query(
          'CALL CreatePrivateCoachSession(?, ?, ?, ?, ?, ?, ?)',
          [
            clubId, // Replace with actual club ID
            courtId,
            DateFormat('yyyy-MM-dd HH:mm:ss').format(convertTimeStringToDateTime(startTime, enteredDate)),
            DateFormat('yyyy-MM-dd HH:mm:ss').format(convertTimeStringToDateTime(endTime, enteredDate)),
            numPeople,
            coachId, // Replace with actual coach ID
            memberIds, // Replace with actual member ID
          ],
        );
        var row = results.first;
        errorCode= row['res_id'].toString();
        await conn.close();
      }
    }
    on MySqlException catch (msqle) {
      errorCode = msqle.errorNumber.toString();
    } catch (e) {
      throw Exception('Error: $e');
    }

    return errorCode;
  }

  static convertTimeStringToDateTime(String timeString, DateTime date) {
    // Parse the time string
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    // Get the current date
    DateTime now = date;

    // Create a DateTime object with the current date and parsed time
    DateTime dateTime = DateTime(now.year, now.month, now.day, hours, minutes);

    return dateTime.toLocal();
  }

  static Future<Map<int, dynamic>> getUpcomingRes(int user_id) async {
    Map<int, dynamic> reservationMap = {};
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        var reservations = await conn.query("call userUpcomingReservations(?)", [user_id]);
        for (var row in reservations) {
          reservationMap[row['res_id']] = {
            'id': row['res_id'],
            'court_name': row['court_name'],
            'start_time': row['start_time'],
            'end_time': row['end_time'],
            'club_name': row['club_name']
          };
        }
        await conn.close();
      }
    } catch (e) {
      throw Exception('Error fetching reservations: $e');
    }

    return reservationMap;
  }

  static Future<void> cancelRes(int res_id) async {
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        await conn.query("call cancel_reservation(?)", [res_id]);
        await conn.close();
      }
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }
  static Future<void> markAsAbsent(int res_id,int user_id) async {
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        await conn.query("call athlete_session_absence(?,?)", [res_id,user_id]);
        await conn.close();
      }
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }


  static Future<Map<int, dynamic>> getUpcomingResCalendar(int user_id) async {
    Map<int, dynamic> reservationMap = {};
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        var reservations = await conn.query("call userUpcomingCalendar(?)", [user_id]);
        for (var row in reservations) {
          reservationMap[row['res_id']] = {
            'id': row['res_id'],
            'court': row['court_name'],
            'start_time': row['start_time'],
            'end_time': row['end_time'],
            'club_name': row['club_name'],
            'type': row['res_type'],
            'absence': row['absence'],
          };
        }
        await conn.close();
      }
    } catch (e) {
      throw Exception('Error fetching reservations: $e');
    }

    return reservationMap;
  }

}
