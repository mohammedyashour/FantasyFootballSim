import 'dart:math';

import '../../../domain/entities/game.dart';
import '../../../domain/entities/referee.dart';
import '../../../domain/entities/stadium.dart';
import '../../../domain/entities/team.dart';
import '../../../domain/enums/Weather.dart';
import '../../../domain/usecases/match/create_match_event.dart';
import '../../../domain/usecases/match/describe_match_event.dart';
import '../../../domain/usecases/referee/random_referee_generator_usecase.dart';
import '../../../domain/usecases/stadium/random_stadium_generator_usecase.dart';
import '../../../domain/usecases/team/get_all_teams_usecase.dart';
import '../../../domain/usecases/team/random_team_generator_usecase.dart';
import '../../io/input/console_input_reader.dart';
import '../../io/output/output_writer.dart';
import '../../utils/match_utils.dart';
import '../../utils/menu_printer.dart';
import '../referee/referee_ui.dart';
import '../stadium/stadium_ui.dart';
import '../team/team_ui.dart';
import '../ui_action.dart';
import 'game_presenter.dart';
import 'game_runner.dart';

class MatchUI {
  final CreateMatchEvent _createEvent;
  final DescribeMatchEvent _describeEvent;
  final GetAllTeamsUseCase _getAllTeams;
  final ConsoleInputReader _inputReader;
  final OutputWriter _outputWriter;
  final MatchUtils _matchManager;
  final RefereeUI _refereeUI;
  final StadiumUI _stadiumUI;
  final TeamUi _teamUi;
  final menuPrinter = MenuPrinter();
  final Random _random = Random();
  final RandomRefereeGeneratorUseCase _randomRefereeGenerator;
  final RandomStadiumGeneratorUseCase _randomStadiumGenerator;
  final RandomTeamGeneratorUseCase _randomTeamGeneratorUseCase;
  late final List<UiAction> _actions;
  List<UiAction> _matchActions = [];

  MatchUI({
    required CreateMatchEvent createEvent,
    required DescribeMatchEvent describeEvent,
    required GetAllTeamsUseCase getAllTeams,
    required ConsoleInputReader inputReader,
    required OutputWriter outputWriter,
    required MatchUtils matchManager,
    required RefereeUI refereeUI,
    required StadiumUI stadiumUI,
    required TeamUi teamUi,
    required RandomRefereeGeneratorUseCase randomRefereeGenerator,
    required RandomStadiumGeneratorUseCase randomStadiumGenerator,
    required RandomTeamGeneratorUseCase randomTeamGenerator,
  }) : _createEvent = createEvent,
       _describeEvent = describeEvent,
       _getAllTeams = getAllTeams,
       _inputReader = inputReader,
       _outputWriter = outputWriter,
       _matchManager = matchManager,
       _refereeUI = refereeUI,
       _stadiumUI = stadiumUI,
       _teamUi = teamUi,
       _randomRefereeGenerator = randomRefereeGenerator,
       _randomStadiumGenerator = randomStadiumGenerator,
       _randomTeamGeneratorUseCase = randomTeamGenerator {
    _initializeActions();
  }

  void _initializeActions() {
    _actions = [
      UiAction(name: "🏟️ Start New Match", action: _startNewMatch),
      UiAction(name: '⚡ Quick Match', action: _quickMatch),
      UiAction(name: '🚪 Exit', action: _exit),
    ];
  }

  void showMenu() {
    while (true) {
      _outputWriter.writeHeader('⚽ Match Simulation');
      menuPrinter.display(_actions, (text) => _outputWriter.writeLine(text));

      final choice = _inputReader.readInt(
        'Enter your choice (1-${_actions.length}):',
        min: 1,
        max: _actions.length,
      );

      _actions[choice - 1].action();

      if (choice == _actions.length) {
        break;
      }
    }
  }

  void _startNewMatch() {
    _outputWriter.writeHeader('🏟️ New Match Setup');

    final teams = _getAllTeams();
    if (teams.isEmpty) {
      _outputWriter.writeError(
        'No teams available. Redirecting to Team Management...',
      );
      _teamUi.showMenu();
      return;
    }

    final homeTeam = _selectTeam('Home Team');
    if (homeTeam == null) return;

    final awayTeam = _selectTeam('Away Team');
    if (awayTeam == null) return;

    _outputWriter.writeLine('\n⚽ Select Stadium:');
    final stadium = _selectStadium();
    if (stadium == null) return;

    _outputWriter.writeLine('\n🧑‍⚖️ Select Referee:');
    final referee = _selectReferee();
    if (referee == null) return;

    final game = Game(
      homeTeam: homeTeam,
      awayTeam: awayTeam,
      stadium: stadium,
      referee: referee,
      matchTime: DateTime.now(),
      weather: WeatherCondition.clear,
    );

    _matchManager.displayMatchSetup(game: game, output: _outputWriter);
    _runMatch(game);
  }

  Team? _selectTeam(String teamType) {
    _outputWriter.writeHeader('Select $teamType');
    final teams = _getAllTeams();

    if (teams.isEmpty) {
      _outputWriter.writeError(
        'No teams available. Please create teams first.',
      );
      _teamUi.showMenu();
      return null;
    }

    for (int i = 0; i < teams.length; i++) {
      _outputWriter.writeLine('${i + 1}. ${teams[i].name} (${teams[i].city})');
    }

    final choice = _inputReader.readInt(
      'Select team (1-${teams.length}):',
      min: 1,
      max: teams.length,
    );

    return teams[choice - 1];
  }

  Stadium? _selectStadium() {
    final stadiums = _stadiumUI.getAllStadiums();
    if (stadiums.isEmpty) {
      _outputWriter.writeError(
        'No stadiums available. Redirecting to Stadium Management...',
      );
      _stadiumUI.showMenu();
      return _stadiumUI.getAllStadiums().isNotEmpty
          ? _stadiumUI.getAllStadiums().first
          : null;
    }

    _outputWriter.writeLine('Available Stadiums:');
    for (int i = 0; i < stadiums.length; i++) {
      _outputWriter.writeLine(
        '${i + 1}. ${stadiums[i].name} (Capacity: ${stadiums[i].capacity})',
      );
    }

    final choice = _inputReader.readInt(
      'Select stadium (1-${stadiums.length}):',
      min: 1,
      max: stadiums.length,
    );

    return stadiums[choice - 1];
  }

  Referee? _selectReferee() {
    final referees = _refereeUI.getAllReferees();
    if (referees.isEmpty) {
      _outputWriter.writeError(
        'No referees available. Redirecting to Referee Management...',
      );
      _refereeUI.showMenu();
      return _refereeUI.getAllReferees().isNotEmpty
          ? _refereeUI.getAllReferees().first
          : null;
    }

    _outputWriter.writeLine('Available Referees:');
    for (int i = 0; i < referees.length; i++) {
      _outputWriter.writeLine(
        '${i + 1}. ${referees[i].name} (Experience: ${referees[i].experienceYears} years)',
      );
    }

    final choice = _inputReader.readInt(
      'Select referee (1-${referees.length}):',
      min: 1,
      max: referees.length,
    );

    return referees[choice - 1];
  }

  void _quickMatch() {
    _outputWriter.writeHeader('⚡ Quick Match - Fully Automatic');

    final teams = _getAllTeams();
    if (teams.isEmpty) {
      _outputWriter.writeError('No teams available. Creating random teams...');
      _randomTeamGeneratorUseCase.call();
      _randomTeamGeneratorUseCase.call();
      return _quickMatch();
    }

    Team homeTeam, awayTeam;
    if (teams.length == 1) {
      homeTeam = teams[0];
      awayTeam = teams[0];
      _outputWriter.writeWarning(
        'Only one team available. Playing against itself!',
      );
    } else {
      homeTeam = teams[_random.nextInt(teams.length)];
      do {
        awayTeam = teams[_random.nextInt(teams.length)];
      } while (awayTeam == homeTeam);
    }

    final stadium = _randomStadiumGenerator();
    _outputWriter.writeLine(
      '🏟️ Random Stadium: ${stadium.name} (Capacity: ${stadium.capacity})',
    );

    final referee = _randomRefereeGenerator();
    _outputWriter.writeLine(
      '🧑‍⚖️ Random Referee: ${referee.name} (Exp: ${referee.experienceYears} yrs)',
    );

    final weather =
        WeatherCondition.values[_random.nextInt(
          WeatherCondition.values.length,
        )];

    final game = Game(
      homeTeam: homeTeam,
      awayTeam: awayTeam,
      stadium: stadium,
      referee: referee,
      matchTime: DateTime.now(),
      weather: weather,
    );

    _outputWriter.writeSuccess('Automatic Match Setup:');
    _outputWriter.writeLine('🏠 Home: ${homeTeam.name}');
    _outputWriter.writeLine('🛫 Away: ${awayTeam.name}');
    _outputWriter.writeLine('🏟️ Stadium: ${stadium.name}');
    _outputWriter.writeLine('🧑‍⚖️ Referee: ${referee.name}');
    _outputWriter.writeLine('🌤️ Weather: ${weather.name}');

    _matchManager.displayMatchSetup(game: game, output: _outputWriter);
    _runMatch(game);
  }

  void _runMatch(Game game) {
    _matchActions = [
      UiAction(
        name: "⚡ Quick Simulation",
        action: () => _startGameRunner(game, false),
      ),
      UiAction(
        name: '⏱️ Live Simulation',
        action: () => _startGameRunner(game, true),
      ),
      UiAction(name: '🚪 Cancel', action: () {}),
    ];

    _outputWriter.writeHeader('🎮 Match Options');
    menuPrinter.display(_matchActions, (text) => _outputWriter.writeLine(text));

    final choice = _inputReader.readInt(
      'Select simulation type (1-${_matchActions.length}):',
      min: 1,
      max: _matchActions.length,
    );

    if (choice == _matchActions.length) return;
    _matchActions[choice - 1].action();
  }

  void _startGameRunner(Game game, bool liveUpdates) {
    final presenter = GamePresenter(
      _describeEvent,
      _outputWriter,
      _inputReader,
    );
    final runner = GameRunner(game, _createEvent, presenter, _outputWriter);

    if (liveUpdates) {
      runner.startWithLiveUpdates();
    } else {
      runner.start();
    }
  }

  void _exit() {
    _outputWriter.writeLine('Exiting Match Simulation...');
  }
}
