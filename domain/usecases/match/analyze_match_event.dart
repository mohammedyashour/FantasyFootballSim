import '../../entities/match_event.dart';
import '../../enums/match_event_type.dart';

class AnalyzeMatchEvent {
  int execute(MatchEvent event) {
    switch (event.eventType) {
      case MatchEventType.goal:
        return 10;
      case MatchEventType.penalty:
        return 9;
      case MatchEventType.redCard:
        return 8;
      case MatchEventType.secondYellow:
        return 7;
      case MatchEventType.varDecision:
        return 6;
      case MatchEventType.injury:
        return 5;
      case MatchEventType.yellowCard:
        return 4;
      case MatchEventType.substitution:
        return 3;
      default:
        return 1;
    }
  }
}
