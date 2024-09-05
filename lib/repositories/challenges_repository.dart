import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChallengeRepo {
  static Future<String> getChallenge() async {
    final Random random = Random();

    try {
      final response = await http.get(Uri.parse(
          'https://dev-xmzye8zkmh5en24.api.raw-labs.com/mock/json-api'));

      if (response.statusCode == 200) {
        final List<dynamic> rawData = jsonDecode(response.body);
        final Map<String, dynamic> data = rawData[0];
        final Map<String, dynamic> challenges = data['mindfulnessChallenges'];

        final int randomIndex = random.nextInt(challenges.keys.length) + 1;
        final String challengeKey = randomIndex.toString();

        debugPrint('CHALLENGE: $challenges');
        debugPrint('Selected Challenge: ${challenges[challengeKey]}');

        return challenges[challengeKey] ?? 'No challenge found';
      } else {
        return 'Drink 8 glasses of water today';
      }
    } catch (e) {
      debugPrint('ERROR $e');
      return 'Error: $e';
    }
  }
}
