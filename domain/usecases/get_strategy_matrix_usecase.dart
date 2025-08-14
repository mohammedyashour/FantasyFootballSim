import '../enums/strategy_enums.dart';
import '../repositories/strategy_repository.dart';

class GetStrategyMatrixUseCase {
  final StrategyRepository strategyRepository;

  GetStrategyMatrixUseCase(this.strategyRepository);

  Map<StrategyType, Map<StrategyType, int>> call() {
    final strategies = strategyRepository.getPredefinedStrategies().keys;
    final matrix = <StrategyType, Map<StrategyType, int>>{};

    for (final attacker in strategies) {
      matrix[attacker] = {};
      for (final defender in strategies) {
        matrix[attacker]![defender] = strategyRepository.calculateMatchupBonus(
          attacker,
          defender,
        );
      }
    }

    return matrix;
  }
}
