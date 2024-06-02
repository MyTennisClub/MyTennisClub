import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mytennisclub/Database/ConnectionDatabase.dart';

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

          print(reservation);

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
    } catch (e) {
      throw Exception('Error fetching reservation: $e');
    }

    return reservationMap;
  }

  static Future<void> createPrivateCoachSession(
      int clubId,
      int courtId,
      String startTime,
      String endTime,
      int numPeople,
      int coachId,
      String memberIds) async {
    try {
      print(startTime);
      print(endTime);
      endTime = endTime.replaceAll(RegExp(r' [AP]M$'), '');
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        await conn.query(
          'CALL CreatePrivateCoachSession(?, ?, ?, ?, ?, ?, ?)',
          [
            clubId, // Replace with actual club ID
            courtId,
            convertTimeStringToDateTime(startTime).toUtc(),
            convertTimeStringToDateTime(endTime).toUtc(), // Calculated end date
            numPeople,
            coachId, // Replace with actual coach ID
            memberIds, // Replace with actual member ID
          ],
        );

        await conn.close();
        throw Exception(
            'Something went wrong with creating Private Reservation');
      }
    } catch (e) {
      throw Exception(
          'Something went wrong with creating Private Reservation: $e');
    }
  }

  static convertTimeStringToDateTime(String timeString) {
    // Parse the time string
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    // Get the current date
    DateTime now = DateTime.now();

    // Create a DateTime object with the current date and parsed time
    DateTime dateTime = DateTime(now.year, now.month, now.day, hours, minutes);

    return dateTime;
  }
}
