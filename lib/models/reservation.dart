import 'dart:ffi';
import 'package:flutter/material.dart';
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
          'SELECT * FROM reservations WHERE id = ?',
          [id],
        );

        if (reservation.isNotEmpty) {
          var row = reservation.first;

          print(reservation);

          reservationMap = {
            'id': row['id'],
            'title': row['title'],
            'court': row['court'],
            'start_time': row['start_time'],
            'end_time': row['end_time'],
            'res_type': row['res_type'],
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
}
