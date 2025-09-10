class ApiConstant {
  static const String baseUrl = "https://v3.football.api-sports.io";
  static const String apiKey = "e068e888f3486ca5e278cc107f19e35c";
  static Map<String, String> headers = {
    "x-rapidapi-host": "v3.football.api-sports.io",
    "x-rapidapi-key": apiKey,
  };

  static const String fixtureLive = "$baseUrl/fixtures?live=all";

  static String upcomingMatch(String date) => "$baseUrl/fixtures?date=$date";

  static String liveMatchDetails(int id) =>
      "$baseUrl/fixtures/events?fixture=$id";

  static String liveMatchLineUp(int id)=> "$baseUrl/fixtures/lineups?fixture=$id";

  static String liveMatchStatistics(int id)=> "$baseUrl/fixtures/statistics?fixture=$id";

  static String allLeague = "$baseUrl/leagues?current=true";

  static String standingsByLeague(int leagueId, int season) =>
      "$baseUrl/standings?league=$leagueId&season=$season";
}
