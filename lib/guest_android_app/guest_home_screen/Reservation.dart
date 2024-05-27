import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Reservation {
  final int id;
  final String title;
  final String court;
  final DateTime startTime;
  final DateTime endTime;
  late Widget qrCode; // Variable to store the QR code

  Reservation({
    required this.id,
    required this.title,
    required this.court,
    required this.startTime,
    required this.endTime,
  }){
    qrCode = QrImageView(
      data: id.toString(),
      version: QrVersions.auto,
      gapless: false,
    ); // Call function to generate QR code
  }
}
