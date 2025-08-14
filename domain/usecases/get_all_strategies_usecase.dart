import '../entities/strategy.dart';
import '../enums/strategy_enums.dart';
import '../repositories/strategy_repository.dart';

class GetAllStrategiesUseCase {
  final StrategyRepository strategyRepository;

  GetAllStrategiesUseCase(this.strategyRepository);

  Map<StrategyType, Strategy> call() {
    return strategyRepository.getPredefinedStrategies();
  }
}
