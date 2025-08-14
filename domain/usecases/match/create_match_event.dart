import '../../entities/match_event.dart';
import '../../entities/player.dart';
import '../../entities/team.dart';
import '../../enums/match_event_type.dart';

class CreateMatchEvent {
  MatchEvent goal({
    required int minute,
    required Team team,
    required Player scorer,
    Player? assistant,
    bool isHomeTeam = true,
  }) {
    return MatchEvent(
      minute: minute,
      eventType: MatchEventType.goal,
      team: team,
      player: scorer,
      secondaryPlayer: assistant,
      additionalInfo: assistant != null ? 'Assist: ${assistant.name}' : null,
      isHomeTeam: isHomeTeam,
    );
  }

  MatchEvent card({
    required int minute,
    required Team team,
    required Player player,
    required MatchEventType cardType,
    String? reason,
    bool isHomeTeam = true,
  }) {
    assert(
      cardType == MatchEventType.yellowCard ||
          cardType == MatchEventType.redCard ||
          cardType == MatchEventType.secondYellow,
    );

    return MatchEvent(
      minute: minute,
      eventType: cardType,
      team: team,
      player: player,
      additionalInfo: reason,
      isHomeTeam: isHomeTeam,
    );
  }

  MatchEvent substitution({
    required int minute,
    required Team team,
    required Player playerOut,
    required Player playerIn,
    bool isHomeTeam = true,
  }) {
    return MatchEvent(
      minute: minute,
      eventType: MatchEventType.substitution,
      team: team,
      player: playerOut,
      secondaryPlayer: playerIn,
      additionalInfo: 'Sub: ${playerOut.name} ↔ ${playerIn.name}',
      isHomeTeam: isHomeTeam,
    );
  }
}
