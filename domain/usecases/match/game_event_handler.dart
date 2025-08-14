import '../../entities/game.dart';
import '../../entities/team.dart';
import '../../entities/match_event.dart';
import '../../enums/match_event_type.dart';

class GameEventHandler {
  Game handle(Game game, MatchEvent event) {
    switch (event.eventType) {
      case MatchEventType.goal:
        return _handleGoal(game, event);
      case MatchEventType.yellowCard:
        _logEvent(
          game,
          '${MatchEventType.yellowCard.displayName}: ${event.player?.name}',
        );
        break;
      case MatchEventType.redCard:
        return _handleRedCard(game, event);
      case MatchEventType.injury:
        _logEvent(
          game,
          '${MatchEventType.injury.displayName}: ${event.player?.name}',
        );
        break;
      case MatchEventType.substitution:
        return _handleSubstitution(game, event);
      case MatchEventType.corner:
        _logEvent(
          game,
          '${MatchEventType.corner.displayName} for ${event.team.name}',
        );
        break;
      case MatchEventType.freeKick:
        _logEvent(
          game,
          '${MatchEventType.freeKick.displayName} for ${event.team.name}',
        );
        break;
      case MatchEventType.penalty:
        _logEvent(
          game,
          '${MatchEventType.penalty.displayName} for ${event.team.name}',
        );
        break;
      case MatchEventType.shotOnTarget:
        _logEvent(
          game,
          '${MatchEventType.shotOnTarget.displayName} by ${event.player?.name}',
        );
        break;
      case MatchEventType.shotOffTarget:
        _logEvent(
          game,
          '${MatchEventType.shotOffTarget.displayName} by ${event.player?.name}',
        );
        break;
      case MatchEventType.blockedShot:
        _logEvent(
          game,
          '${MatchEventType.blockedShot.displayName} by ${event.player?.name}',
        );
        break;
      case MatchEventType.goalKick:
        _logEvent(
          game,
          '${MatchEventType.goalKick.displayName} for ${event.team.name}',
        );
        break;
      case MatchEventType.hitWoodwork:
        _logEvent(
          game,
          '${MatchEventType.hitWoodwork.displayName} by ${event.player?.name}',
        );
        break;
      case MatchEventType.dangerousAttack:
        _logEvent(
          game,
          '${MatchEventType.dangerousAttack.displayName} by ${event.team.name}',
        );
        break;
      case MatchEventType.interception:
        _logEvent(
          game,
          '${MatchEventType.interception.displayName} by ${event.player?.name}',
        );
        break;
      case MatchEventType.foul:
        _logEvent(
          game,
          '${MatchEventType.foul.displayName} by ${event.player?.name}',
        );
        break;
      case MatchEventType.secondYellow:
        _logEvent(
          game,
          '${MatchEventType.secondYellow.displayName}: ${event.player?.name}',
        );
        break;
      case MatchEventType.timeWasting:
        _logEvent(
          game,
          '${MatchEventType.timeWasting.displayName} by ${event.player?.name}',
        );
        break;
      case MatchEventType.protest:
        _logEvent(
          game,
          '${MatchEventType.protest.displayName} by ${event.team.name}',
        );
        break;
      case MatchEventType.offside:
        _logEvent(
          game,
          '${MatchEventType.offside.displayName} by ${event.player?.name}',
        );
        break;
      case MatchEventType.midfieldPossession:
        _logEvent(
          game,
          '${MatchEventType.midfieldPossession.displayName} by ${event.team.name}',
        );
        break;
      case MatchEventType.counterAttack:
        _logEvent(
          game,
          '${MatchEventType.counterAttack.displayName} by ${event.team.name}',
        );
        break;
      case MatchEventType.goalkeeperSave:
        _logEvent(
          game,
          '${MatchEventType.goalkeeperSave.displayName} by ${event.team.name}',
        );
        break;
      case MatchEventType.goalkeeperError:
        _logEvent(
          game,
          '${MatchEventType.goalkeeperError.displayName} by ${event.team.name}',
        );
        break;
      case MatchEventType.tackle:
        _logEvent(
          game,
          '${MatchEventType.tackle.displayName} by ${event.player?.name}',
        );
        break;
      case MatchEventType.kickOff:
        _logEvent(
          game,
          '${MatchEventType.kickOff.displayName} by ${event.team.name}',
        );
        break;
      case MatchEventType.throwIn:
        _logEvent(
          game,
          '${MatchEventType.throwIn.displayName} for ${event.team.name}',
        );
        break;
      case MatchEventType.goalClearance:
        _logEvent(
          game,
          '${MatchEventType.goalClearance.displayName} by ${event.team.name}',
        );
        break;
      case MatchEventType.playersClash:
        _logEvent(game, '${MatchEventType.playersClash.displayName}');
        break;
      case MatchEventType.varCheck:
        _logEvent(game, '${MatchEventType.varCheck.displayName}');
        break;
      case MatchEventType.varDecision:
        _logEvent(game, '${MatchEventType.varDecision.displayName}');
        break;
      case MatchEventType.weatherChange:
        _logEvent(game, '${MatchEventType.weatherChange.displayName}');
        break;
      case MatchEventType.crowdDisturbance:
        _logEvent(game, '${MatchEventType.crowdDisturbance.displayName}');
        break;
      case MatchEventType.specialEvent:
        _logEvent(game, '${MatchEventType.specialEvent.displayName}');
        break;
    }

    return game;
  }

  Game _handleGoal(Game game, MatchEvent event) {
    final isHomeTeam = event.team == game.homeTeam;
    _logEvent(
      game,
      '⚽ GOAL! ${event.team.name} scores! (${event.player?.name})',
    );

    return game.copyWith(
      homeScore: isHomeTeam ? game.homeScore + 1 : game.homeScore,
      awayScore: !isHomeTeam ? game.awayScore + 1 : game.awayScore,
    );
  }

  Game _logEvent(Game game, String message) {
    print(message);
    return game;
  }

  Game _handleSubstitution(Game game, MatchEvent event) {
    final isHome = event.team == game.homeTeam;
    final team = isHome ? game.homeTeam : game.awayTeam;
    final outPlayer = event.player;
    final inPlayer = event.secondaryPlayer;

    if (outPlayer == null || inPlayer == null) {
      return game;
    }

    final newStarters = List.of(team.players);
    final newBench = List.of(team.bench);

    if (!newStarters.contains(outPlayer) || !newBench.contains(inPlayer)) {
      return game;
    }

    newStarters.remove(outPlayer);
    newBench.remove(inPlayer);
    newStarters.add(inPlayer);
    newBench.add(outPlayer);

    final updatedTeam = Team(
      name: team.name,
      trainer: team.trainer,
      players: newStarters,
      bench: newBench,
      strategy: team.strategy,
      formation: team.formation,
      mascot: team.mascot,
      city: team.city,
      teamColors: team.teamColors,
      motto: team.motto,
    );

    return game.copyWith(
      homeTeam: isHome ? updatedTeam : null,
      awayTeam: isHome ? null : updatedTeam,
    );
  }

  Game _handleRedCard(Game game, MatchEvent event) {
    final isHome = event.team == game.homeTeam;
    final team = isHome ? game.homeTeam : game.awayTeam;
    final sentOff = event.player;
    if (sentOff == null) return game;

    final newStarters = List.of(team.players);
    final newBench = List.of(team.bench);
    if (newStarters.remove(sentOff)) {
      // Player removed from field; not added to bench
      final updatedTeam = Team(
        name: team.name,
        trainer: team.trainer,
        players: newStarters,
        bench: newBench,
        strategy: team.strategy,
        formation: team.formation,
        mascot: team.mascot,
        city: team.city,
        teamColors: team.teamColors,
        motto: team.motto,
      );

      return game.copyWith(
        homeTeam: isHome ? updatedTeam : null,
        awayTeam: isHome ? null : updatedTeam,
      );
    }
    return game;
  }
}
