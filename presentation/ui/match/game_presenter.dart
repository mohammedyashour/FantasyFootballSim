import '../../../domain/entities/game.dart';
import '../../../domain/entities/match_event.dart';
import '../../../domain/enums/match_event_type.dart';
import '../../../domain/enums/positions.dart';
import '../../../domain/usecases/match/describe_match_event.dart';
import '../../../domain/usecases/match/match_statistics.dart';
import '../../io/input/console_input_reader.dart';
import '../../io/output/output_writer.dart';
import '../../utils/terminal_utils.dart';
import '../../utils/ui_messages.dart';
import '../ui_action.dart';

class GamePresenter {
  final DescribeMatchEvent _describeEvent;
  final OutputWriter _output;
  final ConsoleInputReader? _input;
  bool _showAllEvents = false;

  GamePresenter(this._describeEvent, this._output, [this._input]);

  void displayMatchStatus(Game game) {
    _output.writeLine('\n${'=' * 50}');
    _output.writeLine(
      '${'🔹Minute ${game.currentMinute}'.withStyle(TerminalColor.LIGHT_BLUE)} '
      '${game.homeTeam.name} ${game.homeScore} - ${game.awayScore} ${game.awayTeam.name}',
    );
    _output.writeLine('${'=' * 50}');
  }

  void displayEvents(List<MatchEvent> events) {
    if (events.isEmpty) {
      _output.writeLine(UIMessages.noEventsThisMinute);
      return;
    }

    final filtered = events.where(_isImportantEvent).toList();
    if (filtered.isEmpty) {
      _output.writeLine(UIMessages.noEventsThisMinute);
      return;
    }

    for (final event in filtered) {
      _output.writeLine(_formatImportantEvent(event));
    }
  }

  void displayMatchSummary(Game game) {
    _output.writeLine(
      '\n${UIMessages.matchSummary.withStyle(TerminalColor.GREEN)}',
    );
    _output.writeLine('${'=' * 50}');
    _output.writeLine(
      '🏆 ${UIMessages.formatScore(game.homeTeam.name, game.homeScore, game.awayScore, game.awayTeam.name)}',
    );
    _output.writeLine('🏟️  Stadium: ${game.stadium.name}');
    _output.writeLine('👨‍⚖️  Referee: ${game.referee.name}');
    _output.writeLine('🌦  Weather: ${game.weather.name}');
    _output.writeLine('📊 Total Events: ${game.events.length}');

    final goals =
        game.events.where((e) => e.eventType == MatchEventType.goal).length;
    final cards =
        game.events
            .where(
              (e) =>
                  e.eventType == MatchEventType.yellowCard ||
                  e.eventType == MatchEventType.redCard,
            )
            .length;

    _output.writeLine('⚽ ${UIMessages.goals}: $goals');
    _output.writeLine('🟨🟥 Cards: $cards');

    if (game.homeScore > game.awayScore) {
      _output.writeLine('🏆 ${UIMessages.winner}: ${game.homeTeam.name}');
    } else if (game.awayScore > game.homeScore) {
      _output.writeLine('🏆 ${UIMessages.winner}: ${game.awayTeam.name}');
    } else {
      _output.writeLine('🤝 ${UIMessages.draw}');
    }
  }

  void displayDetailedStatistics(Game game) {
    final stats = MatchStatistics(game);

    _output.writeLine(
      '\n${UIMessages.detailedStatsTitle.withStyle(TerminalColor.BLUE)}',
    );
    _output.writeLine('${'=' * 60}');

    _output.writeLine(
      '🔢 ${UIMessages.score}: ${UIMessages.formatScore(game.homeTeam.name, game.homeScore, game.awayScore, game.awayTeam.name)}',
    );
    _output.writeLine('');

    final possession = stats.getPossession();
    _output.writeLine(
      '📊 ${UIMessages.possession}: ${game.homeTeam.name} ${UIMessages.formatPercentage(possession['home']!)} | '
      '${game.awayTeam.name} ${UIMessages.formatPercentage(possession['away']!)}',
    );

    final shots = stats.getShots();
    final shotsOnTarget = stats.getShotsOnTarget();
    _output.writeLine(
      '🎯 ${UIMessages.shots}: ${game.homeTeam.name} ${shots['home']} | ${game.awayTeam.name} ${shots['away']}',
    );
    _output.writeLine(
      '🎯 ${UIMessages.shotsOnTarget}: ${game.homeTeam.name} ${shotsOnTarget['home']} | ${game.awayTeam.name} ${shotsOnTarget['away']}',
    );

    final fouls = stats.getFouls();
    final corners = stats.getCorners();
    final offsides = stats.getOffsides();
    final saves = stats.getSaves();

    _output.writeLine(
      '🚫 ${UIMessages.fouls}: ${game.homeTeam.name} ${fouls['home']} | ${game.awayTeam.name} ${fouls['away']}',
    );
    _output.writeLine(
      '📐 ${UIMessages.corners}: ${game.homeTeam.name} ${corners['home']} | ${game.awayTeam.name} ${corners['away']}',
    );
    _output.writeLine(
      '🚩 ${UIMessages.offsides}: ${game.homeTeam.name} ${offsides['home']} | ${game.awayTeam.name} ${offsides['away']}',
    );
    _output.writeLine(
      '🧤 ${UIMessages.saves}: ${game.homeTeam.name} ${saves['home']} | ${game.awayTeam.name} ${saves['away']}',
    );

    final cards = stats.getCards();
    _output.writeLine(
      '🟨 ${UIMessages.yellowCards}: ${game.homeTeam.name} ${cards['home']!['yellow']} | ${game.awayTeam.name} ${cards['away']!['yellow']}',
    );
    _output.writeLine(
      '🟥 ${UIMessages.redCards}: ${game.homeTeam.name} ${cards['home']!['red']} | ${game.awayTeam.name} ${cards['away']!['red']}',
    );

    _output.writeLine('${'=' * 60}');

    final timeline =
        stats.getEventsByMinute().where(_isImportantEvent).toList();
    if (timeline.isNotEmpty) {
      _output.writeLine(
        '\n${'🕒 Important Events Timeline'.withStyle(TerminalColor.CYAN)}',
      );
      for (final e in timeline) {
        _output.writeLine(_formatImportantEvent(e));
      }
    }
  }

  void displayGoals(Game game) {
    final stats = MatchStatistics(game);
    final goals = stats.getGoals();

    if (goals.isEmpty) {
      _output.writeLine('\n${UIMessages.noGoals}');
      return;
    }

    _output.writeLine(
      '\n${'⚽ ${UIMessages.goals}'.withStyle(TerminalColor.GREEN)}',
    );
    _output.writeLine('${'=' * 40}');

    for (final goal in goals) {
      final assistant =
          goal['assistant'] != null ? ' (Assist: ${goal['assistant']})' : '';
      _output.writeLine(
        '${UIMessages.formatMinute(goal['minute'])} ⚽ ${goal['scorer']} - ${goal['team']}$assistant',
      );
    }
  }

  void displaySubstitutions(Game game) {
    final stats = MatchStatistics(game);
    final substitutions = stats.getSubstitutions();

    if (substitutions.isEmpty) {
      _output.writeLine('\n${UIMessages.noSubstitutions}');
      return;
    }

    _output.writeLine(
      '\n${'🔄 ${UIMessages.substitutions}'.withStyle(TerminalColor.YELLOW)}',
    );
    _output.writeLine('${'=' * 40}');

    for (final sub in substitutions) {
      _output.writeLine(
        '${UIMessages.formatMinute(sub['minute'])} 🔄 ${sub['team']}: ${sub['playerOut']} → ${sub['playerIn']}',
      );
    }
  }

  void displayEventsByMinute(Game game) {
    final stats = MatchStatistics(game);
    final events =
        stats.getEventsByMinute().toList()
          ..sort((a, b) => a.minute.compareTo(b.minute));

    if (events.isEmpty) {
      _output.writeLine('\n${UIMessages.noEvents}');
      return;
    }

    _output.writeLine(
      '\n${'📅 ${UIMessages.eventsByMinute}'.withStyle(TerminalColor.CYAN)}',
    );
    _output.writeLine('${'=' * 50}');

    int? currentMinute;
    List<MatchEvent> minuteEvents = [];

    void printMinuteEvents(int minute, List<MatchEvent> eventsForMinute) {
      _output.writeHeader(
        'Minute $minute ${game.homeTeam.name} ${game.homeScore} - ${game.awayScore} ${game.awayTeam.name}',
        color: TerminalColor.CYAN,
      );

      if (eventsForMinute.isEmpty) {
        _output.writeLineWithColor(
          '⏱️  No events in this minute',
          TerminalColor.GREY,
        );
        return;
      }

      final displayEventsList =
          _showAllEvents
              ? eventsForMinute
              : eventsForMinute.where(_isImportantEvent).toList();

      if (displayEventsList.isEmpty) {
        return;
      }

      for (final e in displayEventsList) {
        _output.writeLine(_formatImportantEvent(e, showMinuteLabel: false));
      }
    }

    for (final event in events) {
      if (currentMinute == null) {
        currentMinute = event.minute;
        minuteEvents = [event];
      } else if (event.minute == currentMinute) {
        minuteEvents.add(event);
      } else {
        printMinuteEvents(currentMinute, minuteEvents);
        currentMinute = event.minute;
        minuteEvents = [event];
      }
    }

    if (currentMinute != null) {
      printMinuteEvents(currentMinute, minuteEvents);
    }
  }

  void promptForDetailedStats(Game game) {
    if (_input == null) return;

    _output.writeLine('\n${UIMessages.matchEnded}');
    _output.writeLine(UIMessages.viewDetailedStats);
    _output.writeLine('1. ${UIMessages.yesShowStats}');
    _output.writeLine('2. ${UIMessages.noReturnMenu}');

    final choice = _input.readString('Enter your choice (1-2):');

    if (choice == '1') {
      _showInteractiveStatsMenu(game);
    }
  }

  void _showInteractiveStatsMenu(Game game) {
    final actions = <UiAction>[
      UiAction(
        name: "1. ${UIMessages.detailedStatistics}",
        action: () => displayDetailedStatistics(game),
      ),
      UiAction(
        name: "2. ${UIMessages.goalsSummary}",
        action: () => displayGoals(game),
      ),
      UiAction(
        name: "3. ${UIMessages.substitutionsMenu}",
        action: () => displaySubstitutions(game),
      ),
      UiAction(
        name: "4. ${UIMessages.minuteByMinuteEvents}",
        action: () => displayEventsByMinute(game),
      ),
      UiAction(
        name: "5. ${UIMessages.teamDetails}",
        action: () => _displayTeamDetails(game),
      ),
      UiAction(
        name:
            "6. ${UIMessages.fullEventLogToggle}(${_showAllEvents ? 'ON' : 'OFF'})",
        action: () {
          _showAllEvents = !_showAllEvents;
          _output.writeLine(
            'Full event log is now ${_showAllEvents ? 'ON' : 'OFF'}',
          );
        },
      ),
      UiAction(name: "7. ${UIMessages.backToMainMenu}", action: () {}),
    ];

    if (_input == null) return;

    while (true) {
      _output.writeLine(
        '\n${UIMessages.statsDashboardTitle.withStyle(TerminalColor.BLUE)}',
      );

      _output.writeDivider();

      for (final action in actions) {
        _output.writeLine(action.name);
      }

      final choice = _input.readInt(
        'Enter your choice (1-${actions.length}):',
        min: 1,
        max: actions.length,
      );

      if (choice == actions.length) return;

      actions[choice - 1].action();
      _input.waitForEnter(UIMessages.pressEnterContinue);
    }
  }

  bool _isImportantEvent(MatchEvent e) {
    return e.eventType == MatchEventType.goal ||
        e.eventType == MatchEventType.penalty ||
        e.eventType == MatchEventType.yellowCard ||
        e.eventType == MatchEventType.redCard ||
        e.eventType == MatchEventType.substitution ||
        e.eventType == MatchEventType.injury;
  }

  String _formatImportantEvent(MatchEvent e, {bool showMinuteLabel = true}) {
    final minuteLabel =
        showMinuteLabel ? '${_formatMinuteDisplay(e.minute)} ' : '';

    TerminalColor color = TerminalColor.WHITE;
    String emoji = '';
    String eventText = '';

    switch (e.eventType) {
      case MatchEventType.goal:
        emoji = '⚽️';
        color = TerminalColor.LIGHT_GREEN;
        eventText = 'GOAL - ${e.team.name}: ${e.player?.name ?? 'Unknown'}';
        break;

      case MatchEventType.penalty:
        emoji = '🎯';
        color = TerminalColor.LIGHT_GREEN;
        eventText = 'PENALTY - ${e.team.name}: ${e.player?.name ?? 'Unknown'}';
        break;

      case MatchEventType.yellowCard:
        emoji = '🟨';
        color = TerminalColor.LIGHT_YELLOW;
        eventText =
            'Yellow Card - ${e.team.name}: ${e.player?.name ?? 'Unknown'}';
        break;

      case MatchEventType.redCard:
        emoji = '🟥';
        color = TerminalColor.LIGHT_RED;
        eventText = 'Red Card - ${e.team.name}: ${e.player?.name ?? 'Unknown'}';
        break;

      case MatchEventType.substitution:
        emoji = '🔁';
        color = TerminalColor.LIGHT_CYAN;
        final out = e.player?.name ?? 'Unknown';
        final inP = e.secondaryPlayer?.name ?? 'Unknown';
        eventText = 'Substitution - ${e.team.name}: $out ➡ $inP';
        break;

      case MatchEventType.injury:
        emoji = '💊';
        color = TerminalColor.LIGHT_MAGENTA;
        eventText = 'Injury - ${e.team.name}: ${e.player?.name ?? 'Unknown'}';
        break;

      default:
        emoji = '🔹';
        color = TerminalColor.WHITE;
        eventText = _describeEvent.execute(e);
        break;
    }

    return '${minuteLabel}${emoji} $eventText'.withStyle(color);
  }

  String _formatMinuteDisplay(int minute) {
    if (minute > 90) {
      return '${90}+${minute - 90}’';
    }
    return '${minute}’';
  }

  void _displayTeamDetails(Game game) {
    if (_input == null) return;
    _output.writeHeader('Team Details', color: TerminalColor.CYAN);
    _output.writeLine('1. ${game.homeTeam.name} (Home)');
    _output.writeLine('2. ${game.awayTeam.name} (Away)');
    _output.writeLine('0. Back');
    final selection = _input.readString('Select team (0-2):');
    if (selection == '0') return;
    final isHome = selection == '1';
    final team = isHome ? game.homeTeam : game.awayTeam;

    _output.writeLine('\n${'—' * 60}');
    _output.writeLine('🏳️  Team: ${team.name}');
    _output.writeLine('🏟️  Stadium: ${game.stadium.name}');
    _output.writeLine('📅 Founded: N/A');
    final colors =
        team.teamColors?.map((c) => c.displayName).join(', ') ?? 'N/A';
    _output.writeLine('🎨 Colors: $colors');
    _output.writeDivider(symbol: '-', count: 60);

    _output.writeLine('\n${'Starting Players'.withStyle(TerminalColor.GREEN)}');
    final starters = team.players;
    final roles = team.formation.positions;
    for (int i = 0; i < starters.length; i++) {
      final p = starters[i];
      final jerseyNum = (i + 1).toString();
      final icon = p.position.emoji;
      final preferred = p.position.displayName;
      final playingAs =
          i < roles.length
              ? Position.values
                  .firstWhere(
                    (pos) => pos.name.toUpperCase() == roles[i].toUpperCase(),
                    orElse: () => p.position,
                  )
                  .displayName
              : preferred;
      final injuryMark = p.isInjured ? ' (Injured)' : '';

      _output.writeLine('$jerseyNum. ${p.name} $icon');
      _output.writeLine('   Preferred: $preferred');
      _output.writeLine('   Playing as: $playingAs$injuryMark');
    }

    _output.writeLine('\n${'Substitutes'.withStyle(TerminalColor.YELLOW)}');
    if (team.bench.isEmpty) {
      _output.writeLine('   — None —');
    } else {
      for (int i = 0; i < team.bench.length; i++) {
        final p = team.bench[i];
        final idx = (i + 1).toString();
        final icon = p.position.emoji;
        final preferred = p.position.displayName;
        final injuryMark = p.isInjured ? ' (Injured)' : '';
        _output.writeLine('$idx. ${p.name} $icon');
        _output.writeLine('   Preferred: $preferred');
        _output.writeLine('   Playing as: Substitute$injuryMark');
      }
    }

    _output.writeLine('\nPress back to return to the previous menu.');
  }
}
