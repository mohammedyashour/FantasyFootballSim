import '../../entities/game.dart';
import '../../entities/match_event.dart';
import '../../enums/match_event_type.dart';

class MatchStatistics {
  final Game game;

  MatchStatistics(this.game);

  Map<String, double> getPossession() {
    final homeEvents = game.events.where((e) => e.isHomeTeam).length;
    final awayEvents = game.events.where((e) => !e.isHomeTeam).length;
    final totalEvents = game.events.length;

    if (totalEvents == 0) return {'home': 50.0, 'away': 50.0};

    final homePossession = (homeEvents / totalEvents) * 100;
    final awayPossession = (awayEvents / totalEvents) * 100;

    return {'home': homePossession, 'away': awayPossession};
  }

  Map<String, int> getShots() {
    final homeShots =
        game.events
            .where(
              (e) =>
                  e.isHomeTeam &&
                  (e.eventType == MatchEventType.shotOnTarget ||
                      e.eventType == MatchEventType.shotOffTarget),
            )
            .length;

    final awayShots =
        game.events
            .where(
              (e) =>
                  !e.isHomeTeam &&
                  (e.eventType == MatchEventType.shotOnTarget ||
                      e.eventType == MatchEventType.shotOffTarget),
            )
            .length;

    return {'home': homeShots, 'away': awayShots};
  }

  Map<String, int> getShotsOnTarget() {
    final homeShotsOnTarget =
        game.events
            .where(
              (e) => e.isHomeTeam && e.eventType == MatchEventType.shotOnTarget,
            )
            .length;

    final awayShotsOnTarget =
        game.events
            .where(
              (e) =>
                  !e.isHomeTeam && e.eventType == MatchEventType.shotOnTarget,
            )
            .length;

    return {'home': homeShotsOnTarget, 'away': awayShotsOnTarget};
  }

  Map<String, int> getFouls() {
    final homeFouls =
        game.events
            .where((e) => e.isHomeTeam && e.eventType == MatchEventType.foul)
            .length;

    final awayFouls =
        game.events
            .where((e) => !e.isHomeTeam && e.eventType == MatchEventType.foul)
            .length;

    return {'home': homeFouls, 'away': awayFouls};
  }

  Map<String, int> getCorners() {
    final homeCorners =
        game.events
            .where((e) => e.isHomeTeam && e.eventType == MatchEventType.corner)
            .length;

    final awayCorners =
        game.events
            .where((e) => !e.isHomeTeam && e.eventType == MatchEventType.corner)
            .length;

    return {'home': homeCorners, 'away': awayCorners};
  }

  Map<String, int> getOffsides() {
    final homeOffsides =
        game.events
            .where((e) => e.isHomeTeam && e.eventType == MatchEventType.offside)
            .length;

    final awayOffsides =
        game.events
            .where(
              (e) => !e.isHomeTeam && e.eventType == MatchEventType.offside,
            )
            .length;

    return {'home': homeOffsides, 'away': awayOffsides};
  }

  Map<String, int> getSaves() {
    final homeSaves =
        game.events
            .where(
              (e) =>
                  e.isHomeTeam && e.eventType == MatchEventType.goalkeeperSave,
            )
            .length;

    final awaySaves =
        game.events
            .where(
              (e) =>
                  !e.isHomeTeam && e.eventType == MatchEventType.goalkeeperSave,
            )
            .length;

    return {'home': homeSaves, 'away': awaySaves};
  }

  Map<String, Map<String, int>> getCards() {
    final homeYellowCards =
        game.events
            .where(
              (e) => e.isHomeTeam && e.eventType == MatchEventType.yellowCard,
            )
            .length;

    final homeRedCards =
        game.events
            .where((e) => e.isHomeTeam && e.eventType == MatchEventType.redCard)
            .length;

    final awayYellowCards =
        game.events
            .where(
              (e) => !e.isHomeTeam && e.eventType == MatchEventType.yellowCard,
            )
            .length;

    final awayRedCards =
        game.events
            .where(
              (e) => !e.isHomeTeam && e.eventType == MatchEventType.redCard,
            )
            .length;

    return {
      'home': {'yellow': homeYellowCards, 'red': homeRedCards},
      'away': {'yellow': awayYellowCards, 'red': awayRedCards},
    };
  }

  List<Map<String, dynamic>> getGoals() {
    return game.events
        .where((e) => e.eventType == MatchEventType.goal)
        .map(
          (e) => {
            'minute': e.minute,
            'team': e.isHomeTeam ? game.homeTeam.name : game.awayTeam.name,
            'scorer': e.player?.name,
            'assistant': e.secondaryPlayer?.name,
          },
        )
        .toList();
  }

  List<Map<String, dynamic>> getSubstitutions() {
    return game.events
        .where((e) => e.eventType == MatchEventType.substitution)
        .map(
          (e) => {
            'minute': e.minute,
            'team': e.isHomeTeam ? game.homeTeam.name : game.awayTeam.name,
            'playerOut': e.player?.name,
            'playerIn': e.secondaryPlayer?.name,
          },
        )
        .toList();
  }

  List<MatchEvent> getEventsByMinute() {
    final sortedEvents = List<MatchEvent>.from(game.events);
    sortedEvents.sort((a, b) => a.minute.compareTo(b.minute));
    return sortedEvents;
  }

  int getMatchDuration() {
    if (game.events.isEmpty) return 90;
    final maxMinute = game.events
        .map((e) => e.minute)
        .reduce((a, b) => a > b ? a : b);
    return maxMinute > 90 ? maxMinute : 90;
  }

  Map<String, double> getTeamPerformance() {
    final homeEvents = game.events.where((e) => e.isHomeTeam).length;
    final awayEvents = game.events.where((e) => !e.isHomeTeam).length;
    final totalEvents = game.events.length;

    if (totalEvents == 0) return {'home': 50.0, 'away': 50.0};

    final homePerformance = (homeEvents / totalEvents) * 100;
    final awayPerformance = (awayEvents / totalEvents) * 100;

    return {'home': homePerformance, 'away': awayPerformance};
  }
}
