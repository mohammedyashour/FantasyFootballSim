import '../../../domain/entities/player.dart';
import '../../../domain/enums/nationality.dart';
import '../../../domain/usecases/player/CreatePlayerUseCase.dart';
import '../../../domain/usecases/player/get_all_players_usecase.dart';
import '../../../domain/usecases/player/get_player_by_player_number_usecase.dart';
import '../../../domain/usecases/player/get_player_by_name_usecase.dart';
import '../../../domain/usecases/player/get_player_by_nationality.dart';
import '../../../domain/usecases/player/random_player_generator_usecase.dart';
import '../../io/input/console_input_reader.dart';
import '../../io/output/console_output_writer.dart';
import '../../utils/terminal_utils.dart';
import '../../utils/ui_messages.dart';
import '../Nationality/nationality_printer.dart';
import '../ui_action.dart';
import 'create_player_ui.dart';
import 'player_printer.dart';

class PlayerUI {
  final GetAllPlayersUseCase _getAllPlayers;
  final GetPlayerByPlayerNumberUseCase _getPlayerByPlayerNumber;
  final GetPlayerByNameUseCase _getPlayerByName;
  final CreatePlayerUseCase _createPlayerUseCase;
  final GetPlayerByNationalityUseCase _getPlayerByNationalityUseCase;
  final RandomPlayerGeneratorUseCase _createRandomPlayer;
  final CreatePlayerUI _createPlayerUI;
  final PlayerPrinter _playerPrinter;
  final ConsoleOutputWriter _outputWriter;
  final ConsoleInputReader _inputReader;
  late final List<UiAction> _actions;

  PlayerUI({
    required GetAllPlayersUseCase getAllPlayers,
    required GetPlayerByPlayerNumberUseCase getPlayerByPlayerNumber,
    required GetPlayerByNameUseCase getPlayerByName,
    required CreatePlayerUseCase createPlayerUseCase,
    required RandomPlayerGeneratorUseCase createRandomPlayer,
    required GetPlayerByNationalityUseCase getPlayerByNationalityUseCase,
    required CreatePlayerUI createPlayerUI,
    required PlayerPrinter playerPrinter,
    required ConsoleOutputWriter outputWriter,
    required ConsoleInputReader inputReader,
  })  : _getAllPlayers = getAllPlayers,
        _getPlayerByPlayerNumber = getPlayerByPlayerNumber,
        _getPlayerByName = getPlayerByName,
        _createPlayerUseCase = createPlayerUseCase,
        _createRandomPlayer = createRandomPlayer,
        _getPlayerByNationalityUseCase = getPlayerByNationalityUseCase,
        _createPlayerUI = createPlayerUI,
        _playerPrinter = playerPrinter,
        _outputWriter = outputWriter,
        _inputReader = inputReader {
    _initializeActions();
  }

  void _initializeActions() {
    _actions = [
      UiAction(
        name: '👟 Create New Player'.withStyle(TerminalColor.GREEN),
        action: _createPlayerHandler,
      ),
      UiAction(
        name: '📋 View All Players'.withStyle(TerminalColor.CYAN),
        action: _viewAllPlayers,
      ),
      UiAction(
        name: '🔍 View Player Details'.withStyle(TerminalColor.MAGENTA),
        action: _viewPlayerDetails,
      ),
      UiAction(
        name: '🎲 Create Random Player'.withStyle(TerminalColor.YELLOW),
        action: _createRandomPlayerAction,
      ),
      UiAction(
        name: '🚪 Exit'.withStyle(TerminalColor.RED),
        action: _exit,
      ),
    ];
  }

  void showMenu() {
    while (true) {
      _outputWriter.writeHeader('Player Management System');
      for (int i = 0; i < _actions.length; i++) {
        _outputWriter.writeLine('${i + 1}. ${_actions[i].name}');
      }

      final choice = _inputReader.readString('Enter your choice:');
      final index = int.tryParse(choice);

      if (index == null || index < 1 || index > _actions.length) {
        _outputWriter.writeWarning(UIMessages.invalidChoice);
        continue;
      }

      final action = _actions[index - 1].action;
      action();

      if (_actions[index - 1].name.contains('Exit')) {
        break;
      }
    }
  }

  void _createPlayerHandler() {
    _createPlayerUI.start();
  }

  void _viewAllPlayers() {
    _outputWriter.writeHeader('All Players', color: TerminalColor.LIGHT_BLUE);
    final players = _getAllPlayers.call();

    if (players.isEmpty) {
      _outputWriter.writeWarning(UIMessages.noExistingPlayers);
      return;
    }

    for (final player in players) {
      _playerPrinter.printPlayer(player);
    }
  }

  void _viewPlayerDetails() {
    final searchActions = [
      UiAction(
        name: '🔎 Search by Name',
        action: _searchPlayerByName,
      ),
      UiAction(
        name: '🆔 Search by PlayerNumber',
        action: _searchPlayerByPlayerNumber,
      ),
      UiAction(
        name: '🌍 Search by Nationality',
        action: _searchPlayerByNationality,
      ),
      UiAction(
        name: '↩️ Back',
        action: () {},
      ),
    ];

    while (true) {
      _outputWriter.writeHeader('Search Player', color: TerminalColor.MAGENTA);
      for (int i = 0; i < searchActions.length; i++) {
        _outputWriter.writeLine('${i + 1}. ${searchActions[i].name}');
      }

      final choice = _inputReader.readString('Enter your choice:');
      final index = int.tryParse(choice);

      if (index == null || index < 1 || index > searchActions.length) {
        _outputWriter.writeWarning(UIMessages.invalidChoice);
        continue;
      }

      if (index == searchActions.length) {
        break;
      }

      searchActions[index - 1].action();
    }
  }

  void _searchPlayerByName() {
    final name = _inputReader.readString('Enter player name: ');
    final player = _getPlayerByName.call(name);

    if (player != null) {
      _playerPrinter.printPlayer(player);
    } else {
      _outputWriter.writeWarning('Player not found!');
    }
  }

  void _searchPlayerByPlayerNumber() {
    final playerNumber = _inputReader.readInt('Enter player Player Number: ');
    final player = _getPlayerByPlayerNumber.call(playerNumber);

    if (player != null) {
      _playerPrinter.printPlayer(player);
    } else {
      _outputWriter.writeWarning('Player not found!');
    }
  }

  void _searchPlayerByNationality() {
    _outputWriter.writeHeader('Available Nationalities');
    NationalityPrinter.printNationalitiesGridWithNumbers(_outputWriter, columns: 3);

    final input = _inputReader.readString('Enter number or name of nationality: ');
    final nationality = _getNationalityFromInput(input);

    if (nationality == null) {
      _outputWriter.writeWarning('Invalid nationality!');
      return;
    }

    final players = _getPlayerByNationalityUseCase.call(nationality.displayName);
    _displaySearchResults(players);
  }

  Nationality? _getNationalityFromInput(String input) {
    // Try to parse as number
    final index = int.tryParse(input);
    if (index != null && index > 0 && index <= Nationality.values.length) {
      return Nationality.values[index - 1];
    }

    return Nationality.values.firstWhere(
          (n) => n.displayName.toLowerCase() == input.trim().toLowerCase(),
      orElse: () => Nationality.other,
    );
  }

  void _displaySearchResults(List<Player> players) {
    if (players.isEmpty) {
      _outputWriter.writeWarning('No players found with this nationality!');
      return;
    }

    _outputWriter.writeHeader('Search Results (${players.length} players)');
    for (final player in players) {
      _playerPrinter.printPlayer(player);
    }
  }
  void _createRandomPlayerAction() {
    _outputWriter.writeHeader('🎲 Create Random Player');
    final player = _createRandomPlayer.call();
    _outputWriter.writeSuccess('Random player created and saved successfully!');
    _playerPrinter.printPlayer(player);
  }

  void _exit() {
    _outputWriter.writeLine('Exiting Player Management...');
  }
}