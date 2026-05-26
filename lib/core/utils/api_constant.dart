import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static const String baseUrl = "https://v3.football.api-sports.io";

  static Map<String, String> headers = {
    "x-rapidapi-host": "v3.football.api-sports.io",
    "x-rapidapi-key": dotenv.env['apiKey'].toString(),
    //"Authorization": "Bearer token"
  };

  static const String fixtureLive = "$baseUrl/fixtures?live=all";

  static String upcomingMatch(String date) => "$baseUrl/fixtures?date=$date";

  static String liveMatchDetails(int id) =>
      "$baseUrl/fixtures/events?fixture=$id";

  static String liveMatchLineUp(int id) =>
      "$baseUrl/fixtures/lineups?fixture=$id";

  static String liveMatchStatistics(int id) =>
      "$baseUrl/fixtures/statistics?fixture=$id";

  static String allPlayersProfile(int page) =>
      "$baseUrl/players/profiles?page=$page";
  static String playerDetails(int id) => "$baseUrl/players?id=$id&season=2023";
  static String searchPlayer(String name) =>
      "$baseUrl/players/profiles?search=$name";
}
