import 'package:flutter/cupertino.dart';
import 'package:football_app/features/list_of_match/domain/entity/live_match_details.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../list_of_match/domain/entity/match_statistics.dart';

class AiAnalystService {
  static const _apiKey = 'AIzaSyDCLkv_2UFSqL9PyvlRliua73w0_GKrdvg';
  final GenerativeModel _model;

  AiAnalystService()
    : _model = GenerativeModel(apiKey: _apiKey, model: 'gemini-2.5-flash');

  Future<String> analyzeMatch(List<LiveMatchDetails> events, List<MatchStatistics> stats) async {
    try{
      final prompt = _buildPrompt(events, stats);
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      return response.text ?? "Analysis could not be generated.";
    }catch (e){
      debugPrint("Error generating AI analysis: $e");
      return "Error: Could not generate analysis at this time.";
    }
  }

  static String _buildPrompt(List<LiveMatchDetails> events, List<MatchStatistics> stats) {
    String eventsSummary = events.map((e) => "${e.time.elapsed}' - ${e.type}: ${e.player.name} (${e.team.name})").join('\n');
    String statsSummary = stats.map((s) => "${s.team.name}: \n${s.statistics.map((item) => "  ${item.type}: ${item.value}").join('\n')}").join('\n\n');

    return """
    As a professional football analyst, write a brief, insightful summary of the match based on the following events and statistics.
    Focus on the key moments and which team had the upper hand.

    **Match Events:**
    $eventsSummary

    **Match Statistics:**
    $statsSummary

    **Your Analysis:**
    """;
  }
}
