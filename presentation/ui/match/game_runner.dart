import '../../../domain/entities/game.dart';
import '../../../domain/usecases/match/create_match_event.dart';
import '../../../domain/usecases/match/game_simulator.dart';
import '../../../domain/usecases/match/game_event_handler.dart';
import '../../io/output/output_writer.dart';
import '../../utils/terminal_utils.dart';
import 'game_presenter.dart';

class GameRunner {
  final Game _game;
  final CreateMatchEvent _createEvent;
  final GamePresenter _presenter;
  final OutputWriter _output;

  GameRunner(this._game, this._createEvent, this._presenter, this._output);

  void start() {
    _output.writeLine('${'🎮 MATCH STARTING'.withStyle(TerminalColor.GREEN)}');
    _output.writeLine('${_game.homeTeam.name} vs ${_game.awayTeam.name}');
    _output.writeLine('🏟️  ${_game.stadium.name}');
    _output.writeLine('👨‍⚖️  Referee: ${_game.referee.name}');
    _output.writeLine('🌦  Weather: ${_game.weather.name}');
    _output.writeLine('${'=' * 50}');
    _printLineups(_game);

    final simulator = GameSimulator(_createEvent, GameEventHandler());
    final finalGame = simulator.simulateMatch(_game);

    _presenter.displayMatchSummary(finalGame);

    _presenter.promptForDetailedStats(finalGame);
  }

  void startWithLiveUpdates() {
    _output.writeLine('${'🎮 LIVE MATCH'.withStyle(TerminalColor.GREEN)}');
    _output.writeLine('${_game.homeTeam.name} vs ${_game.awayTeam.name}');
    _output.writeLine('🏟️  ${_game.stadium.name}');
    _output.writeLine('👨‍⚖️  Referee: ${_game.referee.name}');
    _output.writeLine('🌦  Weather: ${_game.weather.name}');
    _output.writeLine('${'=' * 50}');
    _printLineups(_game);

    final simulator = GameSimulator(_createEvent, GameEventHandler());
    Game currentGame = _game;

    // Simulate minute by minute with live updates
    for (int minute = 1; minute <= 90; minute++) {
      currentGame = currentGame.copyWith(currentMinute: minute);
      currentGame = simulator.simulateMinute(currentGame, minute);

      // Display current status
      _presenter.displayMatchStatus(currentGame);

      // Display events for this minute
      final minuteEvents =
          currentGame.events.where((e) => e.minute == minute).toList();
      _presenter.displayEvents(minuteEvents);
    }

    // Add extra time
    final extraTime = simulator.calculateExtraTime(currentGame);
    for (int minute = 91; minute <= 90 + extraTime; minute++) {
      currentGame = currentGame.copyWith(currentMinute: minute);
      currentGame = simulator.simulateMinute(currentGame, minute);

      _presenter.displayMatchStatus(currentGame);
      final minuteEvents =
          currentGame.events.where((e) => e.minute == minute).toList();
      _presenter.displayEvents(minuteEvents);
    }

    // Display final summary
    _presenter.displayMatchSummary(currentGame);

    // Prompt for detailed statistics
    _presenter.promptForDetailedStats(currentGame);
  }

  void _printLineups(Game game) {
    _output.writeLine('${'📋 LINEUPS'.withStyle(TerminalColor.CYAN)}');
    _output.writeLine(
      '- ${game.homeTeam.name} (${game.homeTeam.formation.name})',
    );
    for (final p in game.homeTeam.players) {
      _output.writeLine('   • ${p.name} (${p.position.name})');
    }
    if (game.homeTeam.bench.isNotEmpty) {
      _output.writeLine('   Bench:');
      for (final p in game.homeTeam.bench) {
        _output.writeLine('     - ${p.name} (${p.position.name})');
      }
    }
    _output.writeLine(
      '- ${game.awayTeam.name} (${game.awayTeam.formation.name})',
    );
    for (final p in game.awayTeam.players) {
      _output.writeLine('   • ${p.name} (${p.position.name})');
    }
    if (game.awayTeam.bench.isNotEmpty) {
      _output.writeLine('   Bench:');
      for (final p in game.awayTeam.bench) {
        _output.writeLine('     - ${p.name} (${p.position.name})');
      }
    }
    _output.writeLine('${'=' * 50}');
  }
}
