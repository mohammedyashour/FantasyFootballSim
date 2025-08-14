import '../enums/match_event_type.dart';
import 'player.dart';
import 'team.dart';

class MatchEvent {
  final int minute;
  final MatchEventType eventType;
  final Team team;
  final Player? player;
  final Player? secondaryPlayer;
  final String? additionalInfo;
  final bool isHomeTeam;

  const MatchEvent({
    required this.minute,
    required this.eventType,
    required this.team,
    this.player,
    this.secondaryPlayer,
    this.additionalInfo,
    required this.isHomeTeam,
  });
}
