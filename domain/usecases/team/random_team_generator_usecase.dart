import 'dart:math';

import '../../../data/repositories/player_repository_impl.dart';
import '../../../data/repositories/trainer_repository_impl.dart';
import '../../entities/formation.dart';
import '../../entities/player.dart';
import '../../entities/team.dart';
import '../../entities/trainer.dart';
import '../../enums/formation_type.dart';
import '../../enums/positions.dart';
import '../../enums/strategy_enums.dart';
import '../../enums/team_city.dart';
import '../../enums/team_colors.dart';
import '../../enums/team_mascot.dart';
import '../../enums/team_motto.dart';
import '../../enums/team_name.dart';
import '../formation/get_formations_usecase.dart';
import '../player/random_player_generator_usecase.dart';
import '../team/create_team_usecase.dart';
import '../trainer/random_trainer_generator_usecase.dart';

class RandomTeamGeneratorUseCase {
  final CreateTeamUseCase _createTeamUseCase;
  final PlayerRepositoryImpl _playerRepository;
  final TrainerRepositoryImpl _trainerRepository;
  final GetFormationsUseCase? _getFormationsUseCase;
  final Random _random = Random();

  RandomTeamGeneratorUseCase(
    this._createTeamUseCase,
    this._playerRepository,
    this._trainerRepository, {
    GetFormationsUseCase? getFormationsUseCase,
  }) : _getFormationsUseCase = getFormationsUseCase;

  Team call() {
    final String name = _generateRandomTeamName();
    final String city = _generateRandomCity();
    final String mascot = _generateRandomMascot();
    final String motto = _generateRandomMotto();
    final List<TeamColor> colors = _generateRandomColors();

    final Trainer trainer =
        RandomTrainerGeneratorUseCase(_trainerRepository).call();

    final List<Player> starters = List.generate(
      11,
      (_) => RandomPlayerGeneratorUseCase(_playerRepository).call(),
    );

    final List<Player> bench = List.generate(
      7,
      (_) => RandomPlayerGeneratorUseCase(_playerRepository).call(),
    );

    final StrategyType strategy =
        StrategyType.values[_random.nextInt(StrategyType.values.length)];
    final Formation formation = _pickRandomFormation();

    final team = _createTeamUseCase.call(
      teamName: name,
      trainer: trainer,
      players: starters,
      bench: bench,
      strategy: strategy,
      formation: formation,
      city: city,
      mascot: mascot,
      motto: motto,
      teamColors: colors,
    );

    for (var player in team.players) {
      player.team = team;
    }
    for (var player in team.bench) {
      player.team = team;
    }

    return team;
  }

  String _generateRandomTeamName() {
    final values = TeamName.values;
    return values[_random.nextInt(values.length)].displayName;
  }

  String _generateRandomCity() {
    final values = TeamCity.values;
    return values[_random.nextInt(values.length)].displayName;
  }

  String _generateRandomMascot() {
    final mascots = TeamMascot.values;
    return mascots[_random.nextInt(mascots.length)].name;
  }

  String _generateRandomMotto() {
    final mottos = TeamMotto.values;
    return mottos[_random.nextInt(mottos.length)].display;
  }

  List<TeamColor> _generateRandomColors() {
    List<TeamColor> allColors = TeamColor.values.toList()..shuffle();
    return allColors.take(2).toList();
  }

  Formation _pickRandomFormation() {
    final randomType =
        FormationType.values[_random.nextInt(FormationType.values.length)];

    return Formation(
      type: randomType,
      name: randomType.displayName,
      description: 'Balanced classic formation',
      positions: [
        Position.GK.displayName,
        Position.LB.displayName,
        Position.CB.displayName,
        Position.CB.displayName,
        Position.RB.displayName,
        Position.LM.displayName,
        Position.CM.displayName,
        Position.CM.displayName,
        Position.RM.displayName,
        Position.ST.displayName,
        Position.ST.displayName,
      ],
      attackRating: 7,
      defenseRating: 7,
    );
  }
}
