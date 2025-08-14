import '../enums/team_colors.dart';
import '../enums/strategy_enums.dart';
import 'formation.dart';
import 'player.dart';
import 'trainer.dart';

class Team {
  final String name;
  final Trainer trainer;
  final List<Player> players;
  final List<Player> bench;
  final StrategyType strategy;
  final Formation formation;

  final String? mascot;
  final String? city;
  final List<TeamColor>? teamColors;
  final String? motto;

  Team({
    required this.name,
    required this.trainer,
    required this.players,
    this.bench = const [],
    required this.strategy,
    required this.formation,
    this.mascot,
    this.city,
    this.teamColors,
    this.motto,
  });

  double get totalPower {
    double playersPower = players.fold(
      0,
      (sum, player) => sum + player.overallRate,
    );
    double trainerBonus = trainer.experience * 0.5;
    return playersPower + trainerBonus;
  }

  @override
  String toString() {
    return '''
Team: $name
Trainer: ${trainer.name}
Players count: ${players.length}
Bench count: ${bench.length}
Mascot: ${mascot ?? "N/A"}
City: ${city ?? "N/A"}
Colors: ${teamColors?.map((color) => color.name).join(", ") ?? "N/A"}
Motto: ${motto ?? "N/A"}
Total Power: ${totalPower.toStringAsFixed(2)}
''';
  }
}
