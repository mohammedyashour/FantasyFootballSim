import 'dart:math';

import '../../entities/game.dart';
import '../../entities/match_event.dart';
import '../../entities/player.dart';
import '../../entities/team.dart';
import '../../enums/match_event_type.dart';
import 'create_match_event.dart';
import 'game_event_handler.dart';

class GameSimulator {
  final CreateMatchEvent _createEvent;
  final GameEventHandler _eventHandler;
  final Random _random = Random();

  GameSimulator(this._createEvent, this._eventHandler);

  Game simulateMatch(Game game) {
    Game currentGame = game;

    // Simulate 90 minutes + potential extra time
    for (int minute = 1; minute <= 90; minute++) {
      currentGame = simulateMinute(currentGame, minute);
    }

    // Add extra time if needed (injury time)
    final extraTime = calculateExtraTime(currentGame);
    for (int minute = 91; minute <= 90 + extraTime; minute++) {
      currentGame = simulateMinute(currentGame, minute);
    }

    return currentGame;
  }

  Game simulateMinute(Game game, int minute) {
    Game currentGame = game;

    final eventCount = _random.nextInt(4);

    for (int i = 0; i < eventCount; i++) {
      final event = _generateRandomEvent(currentGame, minute);
      if (event != null) {
        currentGame = _eventHandler.handle(currentGame, event);
        currentGame = currentGame.copyWith(
          events: [...currentGame.events, event],
        );
      }
    }

    return currentGame;
  }

  MatchEvent? _generateRandomEvent(Game game, int minute) {
    final eventType = _getRandomEventType(minute);
    final isHomeTeam = _random.nextBool();
    final team = isHomeTeam ? game.homeTeam : game.awayTeam;
    final player = _getRandomPlayer(team);

    switch (eventType) {
      case MatchEventType.goal:
        return _createEvent.goal(
          minute: minute,
          team: team,
          scorer: player,
          assistant: _getRandomPlayer(team),
          isHomeTeam: isHomeTeam,
        );

      case MatchEventType.yellowCard:
        return _createEvent.card(
          minute: minute,
          team: team,
          player: player,
          cardType: MatchEventType.yellowCard,
          reason: _getRandomCardReason(),
          isHomeTeam: isHomeTeam,
        );

      case MatchEventType.redCard:
        return _createEvent.card(
          minute: minute,
          team: team,
          player: player,
          cardType: MatchEventType.redCard,
          reason: _getRandomCardReason(),
          isHomeTeam: isHomeTeam,
        );

      case MatchEventType.substitution:
        final madeSubs =
            game.events
                .where(
                  (e) =>
                      e.eventType == MatchEventType.substitution &&
                      e.team == team,
                )
                .length;
        if (madeSubs >= 3 || team.bench.isEmpty || team.players.isEmpty) {
          return null;
        }
        final playerOut = player;
        final playerIn = team.bench[_random.nextInt(team.bench.length)];
        return _createEvent.substitution(
          minute: minute,
          team: team,
          playerOut: playerOut,
          playerIn: playerIn,
          isHomeTeam: isHomeTeam,
        );

      default:
        return MatchEvent(
          minute: minute,
          eventType: eventType,
          team: team,
          player: player,
          isHomeTeam: isHomeTeam,
        );
    }
  }

  MatchEventType _getRandomEventType(int minute) {
    final random = _random.nextDouble();

    if (random < 0.05) return MatchEventType.goal;
    if (random < 0.06) return MatchEventType.penalty;
    if (random < 0.10) return MatchEventType.yellowCard;
    if (random < 0.105) return MatchEventType.redCard;
    if (random < 0.115) return MatchEventType.injury;
    if (random < 0.145) return MatchEventType.substitution;
    if (random < 0.295) return MatchEventType.shotOnTarget;
    if (random < 0.495) return MatchEventType.shotOffTarget;
    if (random < 0.695) return MatchEventType.foul;
    if (random < 0.765) return MatchEventType.corner;
    if (random < 0.835) return MatchEventType.freeKick;
    if (random < 0.865) return MatchEventType.offside;
    if (random < 0.895) return MatchEventType.tackle;
    if (random < 0.925) return MatchEventType.goalkeeperSave;

    return MatchEventType.midfieldPossession;
  }

  Player _getRandomPlayer(Team team) {
    return team.players[_random.nextInt(team.players.length)];
  }

  String _getRandomCardReason() {
    final reasons = ['Foul', 'Dissent', 'Time wasting', 'Dangerous play'];
    return reasons[_random.nextInt(reasons.length)];
  }

  int calculateExtraTime(Game game) {
    int extraTime = 0;

    for (final event in game.events) {
      switch (event.eventType) {
        case MatchEventType.injury:
          extraTime += 2;
          break;
        case MatchEventType.substitution:
          extraTime += 1;
          break;
        case MatchEventType.yellowCard:
        case MatchEventType.redCard:
          extraTime += 1;
          break;
        case MatchEventType.varCheck:
          extraTime += 3;
          break;
        default:
          break;
      }
    }

    return extraTime.clamp(1, 6);
  }
}
