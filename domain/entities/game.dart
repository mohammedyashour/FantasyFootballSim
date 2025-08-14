import '../enums/Weather.dart';
import 'match_event.dart';
import 'referee.dart';
import 'stadium.dart';
import 'team.dart';

class Game {
  final Team homeTeam;
  final Team awayTeam;
  final Stadium stadium;
  final Referee referee;
  final DateTime matchTime;
  final WeatherCondition weather;
  final List<MatchEvent> events;
  final int homeScore;
  final int awayScore;
  final int currentMinute;

  Game({
    required this.homeTeam,
    required this.awayTeam,
    required this.stadium,
    required this.referee,
    required this.matchTime,
    this.weather = WeatherCondition.clear,
    this.events = const [],
    this.homeScore = 0,
    this.awayScore = 0,
    this.currentMinute = 0,
  });

  Game copyWith({
    Team? homeTeam,
    Team? awayTeam,
    List<MatchEvent>? events,
    int? homeScore,
    int? awayScore,
    WeatherCondition? weather,
    int? currentMinute,
  }) {
    return Game(
      homeTeam: homeTeam ?? this.homeTeam,
      awayTeam: awayTeam ?? this.awayTeam,
      stadium: stadium,
      referee: referee,
      matchTime: matchTime,
      weather: weather ?? this.weather,
      events: events ?? this.events,
      homeScore: homeScore ?? this.homeScore,
      awayScore: awayScore ?? this.awayScore,
      currentMinute: currentMinute ?? this.currentMinute,
    );
  }

  String get matchSummary {
    return '''
    Match: ${homeTeam.name} vs ${awayTeam.name}
    Score: $homeScore - $awayScore
    Venue: ${stadium.name}
    Referee: ${referee.name}
    Weather: ${weather.name}
    Total events: ${events.length}
    ''';
  }
}
