import '../entities/strategy.dart';
import '../enums/strategy_enums.dart';

abstract class StrategyRepository {
  Map<StrategyType, Strategy> getPredefinedStrategies();

  int calculateMatchupBonus(StrategyType attacking, StrategyType defending);
}
