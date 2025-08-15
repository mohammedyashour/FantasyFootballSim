import '../../../domain/entities/team.dart';
import '../../../domain/enums/strategy_enums.dart';
import '../../../domain/repositories/player_repository.dart';
import '../../../domain/repositories/trainer_repository.dart';
import '../../../domain/usecases/player/CreatePlayerUseCase.dart';
import '../../../domain/usecases/team/create_team_usecase.dart';
import '../../../domain/usecases/team/get_all_teams_usecase.dart';
import '../../../domain/usecases/team/get_teams_by_city_usecase.dart';
import '../../../domain/usecases/team/get_teams_by_strategy_usecase.dart';
import '../../../domain/usecases/team/random_team_generator_usecase.dart';
import '../../../domain/usecases/team/search_teams_usecase.dart';
import '../../../domain/usecases/trainer/create_trainer_usecase.dart';
import '../../../domain/usecases/trainer/random_trainer_generator_usecase.dart';
import '../../io/input/console_input_reader.dart';
import '../../io/output/output_writer.dart';
import '../../utils/menu_printer.dart';
import '../ui_action.dart';
import 'create_team_ui.dart';
import 'team_printer.dart';

class TeamUi {
  final CreateTeamUseCase _createTeamUseCase;
  final CreatePlayerUseCase _createPlayerUseCase;
  final CreateTrainerUseCase _createTrainerUseCase;
  final RandomTrainerGeneratorUseCase _randomTrainerGeneratorUseCase;
  final RandomTeamGeneratorUseCase _randomTeamGeneratorUseCase;
  final GetAllTeamsUseCase _getAllTeamsUseCase;
  final SearchTeamsUseCase _searchTeamsUseCase;
  final GetTeamsByCityUseCase _getTeamsByCityUseCase;
  final GetTeamsByStrategyUseCase _getTeamsByStrategyUseCase;
  final PlayerRepository _playerRepository;
  final TrainerRepository _trainerRepository;
  final ConsoleInputReader _inputReader;
  final OutputWriter _outputWriter;
  final TeamPrinter _teamPrinter;
  final MenuPrinter _menuPrinter = MenuPrinter();

  late final List<UiAction> _actions;

  TeamUi({
    required CreateTeamUseCase createTeamUseCase,
    required CreatePlayerUseCase createPlayerUseCase,
    required CreateTrainerUseCase createTrainerUseCase,
    required RandomTrainerGeneratorUseCase randomTrainerGeneratorUseCase,
    required RandomTeamGeneratorUseCase randomTeamGeneratorUseCase,
    required GetAllTeamsUseCase getAllTeamsUseCase,
    required SearchTeamsUseCase searchTeamsUseCase,
    required GetTeamsByCityUseCase getTeamsByCityUseCase,
    required GetTeamsByStrategyUseCase getTeamsByStrategyUseCase,
    required PlayerRepository playerRepository,
    required TrainerRepository trainerRepository,
    required ConsoleInputReader inputReader,
    required OutputWriter outputWriter,
  }) : _createTeamUseCase = createTeamUseCase,
       _createPlayerUseCase = createPlayerUseCase,
       _createTrainerUseCase = createTrainerUseCase,
       _randomTrainerGeneratorUseCase = randomTrainerGeneratorUseCase,
       _randomTeamGeneratorUseCase = randomTeamGeneratorUseCase,
       _getAllTeamsUseCase = getAllTeamsUseCase,
       _searchTeamsUseCase = searchTeamsUseCase,
       _getTeamsByCityUseCase = getTeamsByCityUseCase,
       _getTeamsByStrategyUseCase = getTeamsByStrategyUseCase,
       _playerRepository = playerRepository,
       _trainerRepository = trainerRepository,
       _inputReader = inputReader,
       _outputWriter = outputWriter,
       _teamPrinter = TeamPrinter(outputWriter) {
    _initializeActions();
  }

  void _initializeActions() {
    _actions = [
      UiAction(name: '🏟️ Create New Team', action: _createTeamHandler),
      UiAction(name: '📋 View All Teams', action: _viewAllTeams),
      UiAction(name: '🔍 Search Teams', action: _searchTeamsMenu),
      UiAction(name: '🎲 Create Random Team', action: _createRandomTeam),
      UiAction(name: '🚪 Exit', action: _exit),
    ];
  }

  void showMenu() {
    while (true) {
      _outputWriter.writeHeader('Team Management System');
      _menuPrinter.display(_actions, (text) => _outputWriter.writeLine(text));

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

  void _createTeamHandler() {
    final ui = CreateTeamUI(
      _createTeamUseCase,
      _createPlayerUseCase,
      _createTrainerUseCase,
      _randomTrainerGeneratorUseCase,
      _inputReader,
      _outputWriter,
      _playerRepository,
      _trainerRepository,
    );
    ui.start();
  }

  void _viewAllTeams() {
    _outputWriter.writeHeader('📋 All Teams');
    final teams = _getAllTeamsUseCase();
    if (teams.isEmpty) {
      _outputWriter.writeError('No teams found.');
    } else {
      _displayTeamsList(teams);
    }
    _inputReader.waitForEnter();
  }

  void _searchTeamsMenu() {
    while (true) {
      _outputWriter.writeHeader('🔍 Search Teams');

      final searchActions = [
        UiAction(name: '🔎 Search by Name', action: _searchTeamsByName),
        UiAction(name: '🏙️ Search by City', action: _searchTeamsByCity),
        UiAction(name: '⚽ Search by Strategy', action: _searchTeamsByStrategy),
        UiAction(name: '🔙 Back to Main Menu', action: () {}),
      ];

      _menuPrinter.display(
        searchActions,
        (text) => _outputWriter.writeLine(text),
      );

      final choice = _inputReader.readInt(
        'Enter your choice (1-${searchActions.length}):',
        min: 1,
        max: searchActions.length,
      );

      if (choice == searchActions.length) {
        return;
      }

      searchActions[choice - 1].action();
    }
  }

  void _searchTeamsByName() {
    _outputWriter.writeHeader('🔎 Search Teams by Name');
    final query = _inputReader.readString('Enter team name to search:');
    final results = _searchTeamsUseCase(query);
    _displaySearchResults(results, 'name', query);
  }

  void _searchTeamsByCity() {
    _outputWriter.writeHeader('🏙️ Search Teams by City');
    final city = _inputReader.readString('Enter city name to search:');
    final results = _getTeamsByCityUseCase(city);
    _displaySearchResults(results, 'city', city);
  }

  void _searchTeamsByStrategy() {
    _outputWriter.writeHeader('⚽ Search Teams by Strategy');

    _outputWriter.writeLine('Available Strategies:');
    StrategyType.values.asMap().forEach((index, strategy) {
      _outputWriter.writeLine('${index + 1}. ${strategy.displayName}');
    });

    final choice = _inputReader.readInt(
      'Enter strategy number (1-${StrategyType.values.length}):',
      min: 1,
      max: StrategyType.values.length,
    );

    final selectedStrategy = StrategyType.values[choice - 1];
    _outputWriter.writeLine(
      'Searching for teams with ${selectedStrategy.displayName} strategy...',
    );

    final results = _getTeamsByStrategyUseCase(selectedStrategy);
    _displaySearchResults(results, 'strategy', selectedStrategy.displayName);
  }

  void _displaySearchResults(
    List<Team> results,
    String searchType,
    String query,
  ) {
    if (results.isEmpty) {
      _outputWriter.writeError('No teams found with $searchType "$query"');
      _inputReader.waitForEnter();
      return;
    }

    _displayTeamsList(results);
  }

  void _displayTeamsList(List<Team> teams) {
    final teamActions =
        teams
            .map(
              (team) => UiAction(
                name:
                    '${team.name} (${team.city}) - ${team.strategy.displayName}',
                action: () => _showTeamDetails(team),
              ),
            )
            .toList();

    teamActions.add(UiAction(name: '🔙 Back', action: () {}));

    while (true) {
      _outputWriter.writeHeader('Select Team to View Details');
      _menuPrinter.display(
        teamActions,
        (text) => _outputWriter.writeLine(text),
      );

      final choice = _inputReader.readInt(
        'Enter choice (1-${teamActions.length}):',
        min: 1,
        max: teamActions.length,
      );

      if (choice == teamActions.length) {
        return;
      }

      teamActions[choice - 1].action();
    }
  }

  void _showTeamDetails(Team team) {
    final detailsActions = [
      UiAction(name: '📋 General Info', action: () => _showGeneralInfo(team)),
      UiAction(
        name: '👥 Players & Formation',
        action: () => _showPlayersAndFormation(team),
      ),
      UiAction(
        name: '⚽ Strategy Analysis',
        action: () => _showStrategyAnalysis(team),
      ),
      UiAction(name: '🔙 Back', action: () {}),
    ];

    while (true) {
      _outputWriter.writeHeader('⚽ ${team.name.toUpperCase()}');
      _menuPrinter.display(
        detailsActions,
        (text) => _outputWriter.writeLine(text),
      );

      final choice = _inputReader.readInt(
        'Select detail to view (1-${detailsActions.length}):',
        min: 1,
        max: detailsActions.length,
      );

      if (choice == detailsActions.length) {
        return;
      }

      detailsActions[choice - 1].action();
      _inputReader.waitForEnter();
    }
  }

  void _showGeneralInfo(Team team) {
    _outputWriter.writeHeader('📋 Team Information');
    _outputWriter.writeLine('🏙️ City: ${team.city}');
    _outputWriter.writeLine('📜 Motto: "${team.motto}"');
    _outputWriter.writeLine('🦁 Mascot: ${team.mascot}');
    _outputWriter.writeLine('🎨 Colors: ${team.teamColors?.join(', ')}');
    _outputWriter.writeLine(
      '🧑‍🏫 Trainer: ${team.trainer.name} (${team.trainer.experience} yrs)',
    );
    _outputWriter.writeDivider();
  }

  void _showPlayersAndFormation(Team team) {
    _outputWriter.writeHeader('👥 Starting Lineup (${team.formation.name})');

    team.players.take(11).forEach((player) {
      _outputWriter.writeLine(
        '⭐ ${player.name.padRight(20)} ${player.position} '
        'Rating: ${player.overallRate.toStringAsFixed(1)}',
      );
    });

    if (team.players.length > 11) {
      _outputWriter.writeLine('\n🔄 Substitutes (${team.players.length - 11})');
      team.players.skip(11).forEach((player) {
        _outputWriter.writeLine(
          '🔹 ${player.name.padRight(20)} ${player.position} '
          'Rating: ${player.overallRate.toStringAsFixed(1)}',
        );
      });
    }

    _outputWriter.writeDivider();

    _outputWriter.writeHeader('🧩 Formation Diagram');
    final positions = team.formation.positions;
    _outputWriter.writeLine('    ${positions[0]}');
    _outputWriter.writeLine('  ${positions[3]}   ${positions[4]}');
    _outputWriter.writeLine('${positions[1]}     ${positions[2]}');
    _outputWriter.writeLine('  ${positions[5]}   ${positions[8]}');
    _outputWriter.writeLine('${positions[6]}     ${positions[7]}');
    _outputWriter.writeLine('  ${positions[9]}   ${positions[10]}');
  }

  void _showStrategyAnalysis(Team team) {
    _outputWriter.writeHeader('⚽ ${team.strategy.displayName} Strategy');
    _outputWriter.writeLine('🔹 ' + _getStrategyDescription(team.strategy));
    _outputWriter.writeLine('\n');
    _outputWriter.writeDivider();
    _outputWriter.writeLine('🔍 Formation Compatibility:');
    _outputWriter.writeLine(
      '⚔️ Attack Rating: ${'⭐' * team.formation.attackRating}',
    );
    _outputWriter.writeLine(
      '🛡️ Defense Rating: ${'⭐' * team.formation.defenseRating}',
    );
  }

  String _getStrategyDescription(StrategyType strategy) {
    switch (strategy) {
      case StrategyType.offensive:
        return '⚡ All-out attacking play with high press and many players forward';
      case StrategyType.defensive:
        return '🛡️ Strong defensive structure with deep block and counter-attacks';
      case StrategyType.balanced:
        return '⚖️ Balanced approach between attack and defense';
      case StrategyType.counterAttack:
        return '💨 Quick counter-attacks after regaining possession';
      case StrategyType.possession:
        return '🔄 Focus on ball retention and positional play';
      default:
        return strategy.toString();
    }
  }

  void _createRandomTeam() {
    _outputWriter.writeHeader('🎲 Create Random Team');
    final team = _randomTeamGeneratorUseCase.call();
    _outputWriter.writeSuccess('Random team created successfully!');
    _teamPrinter.printDetails(team);
    _inputReader.waitForEnter();
  }

  void _exit() {
    _outputWriter.writeLine('Exiting Team Management...');
  }
}
