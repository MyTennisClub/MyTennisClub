import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mytennisclub/models/clubList.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mytennisclub/Database/ConnectionDatabase.dart';

class TennisClub {
  const TennisClub({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.email,
    required this.website,
    required this.longitude,
    required this.latitude,
    required this.startForPublic,
    required this.endForPublic,
  });

  final String id;
  final String name;
  final String description;
  final String address;
  final String email;
  final String website;
  final double longitude;
  final double latitude;
  final DateTime startForPublic;
  final DateTime endForPublic;

  static String capitalizeFields(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  static Future<List<dynamic>> getClubInfo(int id) async {
    List<dynamic> clubInfoList = [];
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        var clubInfo = await conn.query(
          "SELECT club_id,club_address,club_email FROM TennisClub where club_id=?",
          [id],
        );
        var clubFields = await conn.query(
          "select field_type from Courts where court_club_id=? and court_only_for_members=0",
          [id],
        );
        var clubPhones = await conn.query(
          " SELECT club_phone from ClubsPhone where club_id=?",
          [id],
        );

        if (clubInfo.isNotEmpty &&
            clubFields.isNotEmpty &&
            clubPhones.isNotEmpty) {
          var row1 = clubInfo.first;

          print(row1);
          print(clubFields);
          print(clubPhones);

          clubInfoList = [
            row1['club_id'],
            row1['club_address'],
            row1['club_email'],
          ];

          List<String> phones = [];
          List<String> fields = [];
          for (var row in clubFields) {
            if (!fields
                .contains(capitalizeFields(row['field_type']) + ' Court')) {
              fields.add(capitalizeFields(row['field_type']) + ' Court');
            }
          }
          for (var row in clubPhones) {
            phones.add(row['club_phone']);
          }

          clubInfoList.add(fields);
          clubInfoList.add(phones);

          print(clubInfoList);

          await conn.close();
        } else {
          await conn.close();
          throw Exception('No club found with the given ID');
        }
      }
    } catch (e) {
      throw Exception('Error fetching club: $e');
    }

    return clubInfoList;
  }

  static Future<List<dynamic>> getClubReviews(int id) async {
    List<dynamic> clubReviews = [];
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        var reviews = await conn.query(
          "call load_review_data(?)",
          [id],
        );

        if (reviews.isNotEmpty) {
          for (var row in reviews) {
            clubReviews.add([
              row['user_first_name'],
              row['user_id'],
              row['review_likes'],
              row['review_description'],
              row['review_check'],
              row['review_date'],
              row['review_stars'],
            ]);
          }

          print(clubReviews);

          await conn.close();
        } else {
          await conn.close();
          throw Exception('No club found with the given ID');
        }
      }
    } catch (e) {
      throw Exception('Error fetching reviews: $e');
    }

    return clubReviews;
  }
}
