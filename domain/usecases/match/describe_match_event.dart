import '../../entities/match_event.dart';
import '../../enums/match_event_type.dart';

class DescribeMatchEvent {
  String execute(MatchEvent event) {
    switch (event.eventType) {
      case MatchEventType.goal:
        return '⚽ Goal by ${event.player?.name} (${event.team.name}) ${event.additionalInfo ?? ''}';
      case MatchEventType.yellowCard:
        return '🟨 Yellow card for ${event.player?.name}';
      case MatchEventType.redCard:
        return '🟥 Red card for ${event.player?.name}';
      case MatchEventType.secondYellow:
        return '🟨🟥 Second yellow for ${event.player?.name}';
      case MatchEventType.substitution:
        return '🔄 ${event.additionalInfo}';
      case MatchEventType.injury:
        return '💊 Injury for ${event.player?.name}';
      case MatchEventType.penalty:
        return '🎯 Penalty for ${event.team.name}';
      case MatchEventType.varDecision:
        return '📺 VAR Decision: ${event.additionalInfo}';
      default:
        return '[${event.minute}\'] ${event.eventType.toString().split('.').last}';
    }
  }
}
