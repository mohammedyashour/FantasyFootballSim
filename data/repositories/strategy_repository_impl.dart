import '../../domain/entities/strategy.dart';
import '../../domain/enums/strategy_enums.dart';
import '../../domain/repositories/strategy_repository.dart';

class StrategyRepositoryImpl implements StrategyRepository {
  static Map<StrategyType, Map<StrategyType, int>> _payoffMatrix = {
    StrategyType.offensive: {
      StrategyType.offensive: 5,
      StrategyType.defensive: -5,
      StrategyType.balanced: 3,
      StrategyType.counterAttack: -8,
      StrategyType.highPress: 7,
      StrategyType.parkTheBus: -10,
    },
    StrategyType.defensive: {
      StrategyType.offensive: 10,
      StrategyType.defensive: 2,
      StrategyType.balanced: 4,
      StrategyType.counterAttack: 5,
      StrategyType.highPress: -3,
      StrategyType.parkTheBus: 6,
    },
    StrategyType.balanced: {
      StrategyType.offensive: 5,
      StrategyType.defensive: 5,
      StrategyType.balanced: 7,
      StrategyType.counterAttack: 4,
      StrategyType.highPress: 6,
      StrategyType.parkTheBus: 5,
    },
    StrategyType.counterAttack: {
      StrategyType.offensive: 12,
      StrategyType.defensive: 3,
      StrategyType.balanced: 4,
      StrategyType.counterAttack: 0,
      StrategyType.highPress: -2,
      StrategyType.parkTheBus: 8,
    },
    StrategyType.highPress: {
      StrategyType.offensive: 8,
      StrategyType.defensive: 5,
      StrategyType.balanced: 6,
      StrategyType.counterAttack: 5,
      StrategyType.highPress: 4,
      StrategyType.parkTheBus: -5,
    },
    StrategyType.parkTheBus: {
      StrategyType.offensive: 15,
      StrategyType.defensive: 4,
      StrategyType.balanced: 3,
      StrategyType.counterAttack: -3,
      StrategyType.highPress: 8,
      StrategyType.parkTheBus: 1,
    },
  };

  @override
  Map<StrategyType, Strategy> getPredefinedStrategies() {
    return {
      StrategyType.offensive: Strategy(
        type: StrategyType.offensive,
        description: 'Aggressive attacking focus on scoring',
        baseBonus: 10,
      ),
      StrategyType.defensive: Strategy(
        type: StrategyType.defensive,
        description: 'Strong defensive focus and coverage',
        baseBonus: 8,
      ),
      StrategyType.balanced: Strategy(
        type: StrategyType.balanced,
        description: 'Equal balance between attack and defense',
        baseBonus: 12,
      ),
      StrategyType.counterAttack: Strategy(
        type: StrategyType.counterAttack,
        description: 'Deep defense with fast counter-attacks',
        baseBonus: 14,
      ),
      StrategyType.highPress: Strategy(
        type: StrategyType.highPress,
        description: 'High pressure in midfield',
        baseBonus: 15,
      ),
      StrategyType.parkTheBus: Strategy(
        type: StrategyType.parkTheBus,
        description: 'Extreme defense with all players back',
        baseBonus: 20,
      ),
    };
  }

  @override
  int calculateMatchupBonus(StrategyType attacking, StrategyType defending) {
    return _payoffMatrix[attacking]?[defending] ?? 0;
  }
}
