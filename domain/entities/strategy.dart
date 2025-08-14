import '../enums/strategy_enums.dart';

class Strategy {
  final StrategyType type;
  final String description;
  final int baseBonus;

  const Strategy({
    required this.type,
    required this.description,
    required this.baseBonus,
  });
}
