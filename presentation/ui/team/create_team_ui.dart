import '../../../data/repositories/trainer_repository_impl.dart';
import '../../../domain/entities/formation.dart';
import '../../../domain/entities/player.dart';
import '../../../domain/entities/team.dart';
import '../../../domain/entities/trainer.dart';
import '../../../domain/enums/formation_type.dart';
import '../../../domain/enums/strategy_enums.dart';
import '../../../domain/enums/team_colors.dart';
import '../../../domain/repositories/player_repository.dart';
import '../../../domain/repositories/trainer_repository.dart';
import '../../../domain/usecases/formation/get_formations_usecase.dart';
import '../../../domain/usecases/player/CreatePlayerUseCase.dart';
import '../../../domain/usecases/player/random_player_generator_usecase.dart';
import '../../../domain/usecases/team/create_team_usecase.dart';
import '../../../domain/usecases/trainer/create_trainer_usecase.dart';
import '../../../domain/usecases/trainer/get_all_trainers_usecase.dart';
import '../../../domain/usecases/trainer/random_trainer_generator_usecase.dart';
import '../../io/input/console_input_reader.dart';
import '../../io/output/console_output_writer.dart';
import '../../io/output/output_writer.dart';
import '../colors/color_selection_ui.dart';
import '../player/create_player_ui.dart';
import '../player/list_players_ui.dart';
import '../trainer/create_trainer_ui.dart';
import '../trainer/list_trainers_ui.dart';
import '../trainer/trainer_printer.dart';
import '../ui_action.dart';
import 'team_printer.dart';

class CreateTeamUI {
  final CreateTeamUseCase _createTeamUseCase;
  final CreatePlayerUseCase _createPlayerUseCase;
  final CreateTrainerUseCase _createTrainerUseCase;
  final RandomTrainerGeneratorUseCase _randomTrainerGeneratorUseCase;
  final ConsoleInputReader reader;
  final OutputWriter writer;
  final GetFormationsUseCase? _getFormationsUseCase;
  final PlayerRepository _playerRepository;
  final TrainerRepository _trainerRepository;

  CreateTeamUI(
    this._createTeamUseCase,
    this._createPlayerUseCase,
    this._createTrainerUseCase,
    this._randomTrainerGeneratorUseCase,
    this.reader,
    this.writer,
    this._playerRepository,
    this._trainerRepository, {
    GetFormationsUseCase? getFormationsUseCase,
  }) : _getFormationsUseCase = getFormationsUseCase;

  List<Player> get _existingPlayers => _playerRepository.getAll();

  List<Trainer> get _existingTrainers => _trainerRepository.getAll();

  Team start() {
    writer.writeHeader("╔════════════════════════════╗");
    writer.writeHeader("║      CREATE NEW TEAM       ║");
    writer.writeHeader("╚════════════════════════════╝");

    final teamName = _getTeamName();
    final city = reader.readString("🏙️ City:");
    final mascot = reader.readString("🦁 Mascot:");
    final motto = reader.readString("📜 Motto:");
    final teamColors = ColorSelectionUI.selectColors(reader, writer);

    writer.writeHeader("\n=== TEAM STAFF ===");
    final trainer = _handleTrainerSelection();

    writer.writeHeader("\n=== PLAYERS ===");
    final players = _handlePlayerSelection();

    writer.writeHeader("\n=== TACTICS ===");
    final strategy = _selectStrategy();
    final formation = _selectFormation();

    return _createTeam(
      teamName,
      city,
      mascot,
      motto,
      teamColors,
      trainer,
      players,
      strategy,
      formation,
    );
  }
  String _getTeamName() {
    while (true) {
      final name = reader.readString("🔖 Team Name:");
      if (name.trim().isNotEmpty) return name;
      writer.writeError("Team name cannot be empty!");
    }
  }

  Trainer _handleTrainerSelection() {
    final trainerActions = [
      UiAction(name: '👔 Add New Trainer', action: () => _addNewTrainer()),
      UiAction(
        name: '🔍 Select Existing Trainer',
        action: () => _selectExistingTrainer(),
      ),
      UiAction(
        name: '📋 List Available Trainers',
        action: () => _printTrainersList(),
      ),
      UiAction(
        name: '🎲 Create Random Trainer',
        action: () => _createRandomTrainer(),
      ),
    ];

    while (true) {
      writer.writeLine("\n👔 Trainer Selection");
      _displayMenu(trainerActions);

      final choice = reader.readInt(
        "Enter choice (1-${trainerActions.length}):",
        min: 1,
        max: trainerActions.length,
      );

      final result = trainerActions[choice - 1].action();
      if (result is Trainer) return result;
    }
  }

  Trainer _addNewTrainer() {
    final consoleWriter =
        writer is ConsoleOutputWriter
            ? writer as ConsoleOutputWriter
            : ConsoleOutputWriter();
    final newTrainer =
        CreateTrainerUI(
          _createTrainerUseCase,
          reader,
          consoleWriter,
          TrainerRepositoryImpl(),
        ).start();
    return newTrainer;
  }

  Trainer? _selectExistingTrainer() {
    if (_existingTrainers.isEmpty) {
      writer.writeWarning("No existing trainers available.");
      return null;
    }
    _printTrainersList();
    final selected = reader.readInt(
      "Enter trainer number:",
      min: 1,
      max: _existingTrainers.length,
    );
    return _existingTrainers[selected - 1];
  }

  void _createRandomTrainer() {
    writer.writeHeader('🎲 Create Random Player');
    final player = _randomTrainerGeneratorUseCase.call();
    writer.writeSuccess('Random player created and saved successfully!');
    TrainerPrinter(writer).printDetails(player);
  }

  void _printTrainersList() {
    ListTrainersUI(
      GetAllTrainersUseCase(TrainerRepositoryImpl()),
      reader,
    ).start();
  }

  List<Player> _handlePlayerSelection() {
    final players = <Player>[];
    final playerActions = [
      UiAction(name: '👟 Add New Player', action: () => _addNewPlayer(players)),
      UiAction(
        name: '🔍 Select Existing Player',
        action: () => _selectExistingPlayer(players),
      ),
      UiAction(
        name: '📋 List Selected Players',
        action: () => _printSelectedPlayers(players),
      ),
      UiAction(
        name: '📜 List Available Players',
        action: () => ListPlayersUI(_existingPlayers, reader).start(),
      ),
      UiAction(
        name: '✅ Finish Selection',
        action: () => _finishPlayerSelection(players),
      ),
      UiAction(
        name: '🎲 Add Random Player',
        action: () => _addRandomPlayer(players),
      ),
      UiAction(
        name: '⚡ Fill with Random Players (Starters + Subs)',
        action: () => _fillWithRandomPlayers(players),
      ),
    ];

    while (true) {
      writer.writeLine("\n👟 Players (${players.length})");
      _displayMenu(playerActions);

      final choice = reader.readInt(
        "Enter choice (1-${playerActions.length}):",
        min: 1,
        max: playerActions.length,
      );

      final result = playerActions[choice - 1].action();
      if (result is List<Player>) return result;
    }
  }

  void _addNewPlayer(List<Player> players) {
    final newPlayer =
        CreatePlayerUI(
          _createPlayerUseCase,
          reader,
          writer,
          _playerRepository,
        ).start();
    players.add(newPlayer);
    writer.writeSuccess("Player added!");
  }

  Player? _selectExistingPlayer(List<Player> players) {
    if (_existingPlayers.isEmpty) {
      writer.writeWarning("No existing players available.");
      return null;
    }

    _printAvailablePlayers();
    final selected = reader.readInt(
      "Enter player number:",
      min: 1,
      max: _existingPlayers.length,
    );
    final player = _existingPlayers[selected - 1];

    if (players.contains(player)) {
      writer.writeWarning("Player already in the team.");
      return null;
    }

    players.add(player);
    writer.writeSuccess("Added ${player.name}");
    return player;
  }

  List<Player>? _finishPlayerSelection(List<Player> players) {
    if (players.length < 11) {
      writer.writeError(
        "Team must have at least 11 players! You currently have ${players.length}.",
      );
      return null;
    }
    return players;
  }

  void _addRandomPlayer(List<Player> players) {
    final randomPlayer = RandomPlayerGeneratorUseCase(_playerRepository).call();
    players.add(randomPlayer);
    writer.writeLine("🎲 Random player added: ${randomPlayer.name}");
  }

  void _fillWithRandomPlayers(List<Player> players) {
    final startingPlayersNeeded = 11 - players.length;
    final substitutesNeeded = 7;

    if (startingPlayersNeeded <= 0) {
      writer.writeSuccess("You already have 11 starting players.");

      if (players.length < 18) {
        final benchPlayersNeeded = 18 - players.length;
        for (int i = 0; i < benchPlayersNeeded; i++) {
          final randomPlayer = RandomPlayerGeneratorUseCase(_playerRepository).call();
          players.add(randomPlayer);
          writer.writeLine("🎲 Random substitute #${i + 1} added: ${randomPlayer.name}");
        }
        writer.writeSuccess("Added $benchPlayersNeeded substitutes to complete the squad (18 players)");
      }
      return;
    }

    for (int i = 0; i < startingPlayersNeeded; i++) {
      final randomPlayer = RandomPlayerGeneratorUseCase(_playerRepository).call();
      players.add(randomPlayer);
      writer.writeLine("🎲 Random starting player #${i + 1} added: ${randomPlayer.name}");
    }

    for (int i = 0; i < substitutesNeeded; i++) {
      final randomPlayer = RandomPlayerGeneratorUseCase(_playerRepository).call();
      players.add(randomPlayer);
      writer.writeLine("🎲 Random substitute #${i + 1} added: ${randomPlayer.name}");
    }

    writer.writeSuccess("Team now has 11 starting players and 7 substitutes (18 total)");
  }
  void _printAvailablePlayers() {
    writer.writeLine("\nAvailable Players:");
    _existingPlayers.asMap().forEach((index, player) {
      writer.writeLine(
        "${index + 1}. ${player.name} (${player.overallRate.toStringAsFixed(2)} rating)",
      );
    });
  }

  void _printSelectedPlayers(List<Player> players) {
    if (players.isEmpty) {
      writer.writeLine("No players selected yet.");
      return;
    }
    writer.writeLine("\nSelected Players:");
    players.asMap().forEach((index, player) {
      writer.writeLine(
        "${index + 1}. ${player.name} (${player.overallRate.toStringAsFixed(2)} rating)",
      );
    });
  }

  StrategyType _selectStrategy() {
    writer.writeHeader("\n🎯 Select Team Strategy:");

    StrategyType.values.asMap().forEach((index, strategy) {
      writer.writeLine("${index + 1}. ${strategy.fullDescription}");
    });

    final idx = reader.readInt(
      "Choose strategy (1-${StrategyType.values.length}):",
      min: 1,
      max: StrategyType.values.length,
    );
    return StrategyType.values[idx - 1];
  }
  Formation _selectFormation() {
    writer.writeHeader("\n📐 Select Formation:");

    final formations = _getFormationsUseCase?.call() ?? [];
    if (formations.isEmpty) {
      writer.writeWarning("No formations available, using default 4-4-2");
      return _getDefaultFormation();
    }

    formations.asMap().forEach((index, formation) {
      writer.writeLine("\n${index + 1}. ${formation.name.toUpperCase()}");
      writer.writeLine("   ${formation.description}");
      writer.writeLine("   ⚔️ Attack: ${'⭐' * formation.attackRating}");
      writer.writeLine("   🛡️ Defense: ${'⭐' * formation.defenseRating}");
      _printFormationDiagram(formation);
    });

    final idx = reader.readInt(
      "\nChoose formation (1-${formations.length}):",
      min: 1,
      max: formations.length,
    );

    final selected = formations[idx - 1];
    writer.writeSuccess("Selected: ${selected.name} formation");
    return selected;
  }

  void _printFormationDiagram(Formation formation) {
    final positions = formation.positions;
    writer.writeLine("\nFormation Diagram:");
    writer.writeLine("    ${positions[0]}");
    writer.writeLine("  ${positions[3]}   ${positions[4]}");
    writer.writeLine("${positions[1]}     ${positions[2]}");
    writer.writeLine("  ${positions[5]}   ${positions[8]}");
    writer.writeLine("${positions[6]}     ${positions[7]}");
    writer.writeLine("  ${positions[9]}   ${positions[10]}");
  }
  Formation _getDefaultFormation() {
    return Formation(
      type: FormationType.FOUR_FOUR_TWO,
      name: '4-4-2',
      description: 'Balanced classic formation',
      positions: [
        'GK',
        'LB',
        'CB',
        'CB',
        'RB',
        'LM',
        'CM',
        'CM',
        'RM',
        'ST',
        'ST',
      ],
      attackRating: 7,
      defenseRating: 7,
    );
  }

  Team _createTeam(
    String teamName,
    String? city,
    String? mascot,
    String? motto,
    List<TeamColor> teamColors,
    Trainer trainer,
    List<Player> players,
    StrategyType strategy,
    Formation formation,
  ) {
    try {
      final team = _createTeamUseCase.call(
        teamName: teamName,
        city: city,
        mascot: mascot,
        motto: motto,
        teamColors: teamColors,
        trainer: trainer,
        players: players,
        strategy: strategy,
        formation: formation,
      );

      writer.writeSuccess("Team created successfully!");
      TeamPrinter(writer).printDetails(team);
      return team;
    } catch (e) {
      writer.writeError("Error creating team: ${e.toString()}");
      rethrow;
    }
  }

  void _displayMenu(List<UiAction> actions) {
    actions.asMap().forEach((index, action) {
      writer.writeLine("${index + 1}. ${action.name}");
    });
  }
}
