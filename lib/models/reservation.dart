import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mytennisclub/models/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
}
