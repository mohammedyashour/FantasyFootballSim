import '../../entities/formation.dart';
import '../../enums/strategy_enums.dart';
import '../../repositories/formation_repository.dart';

class GetRecommendedFormationsUseCase {
  final FormationRepository _repository;

  GetRecommendedFormationsUseCase(this._repository);

  List<Formation> call(StrategyType strategyType) {
    final allFormations = _repository.getAll();

    return _filterFormationsByStrategy(allFormations, strategyType);
  }

  List<Formation> _filterFormationsByStrategy(
    List<Formation> formations,
    StrategyType strategyType,
  ) {
    switch (strategyType) {
      case StrategyType.offensive:
        return formations.where((f) => f.attackRating >= 8).toList();
      case StrategyType.defensive:
        return formations.where((f) => f.defenseRating >= 8).toList();
      case StrategyType.counterAttack:
        return formations
            .where(
              (f) => f.positions.contains('RWB') && f.positions.contains('LWB'),
            )
            .toList();
      case StrategyType.highPress:
        return formations
            .where(
              (f) => f.positions.where((p) => p.startsWith('CM')).length >= 3,
            )
            .toList();
      case StrategyType.parkTheBus:
        return formations
            .where((f) => f.positions.where((p) => _isDefender(p)).length >= 5)
            .toList();
      default: // balanced
        return formations
            .where((f) => f.attackRating >= 6 && f.defenseRating >= 6)
            .toList();
    }
  }

  bool _isDefender(String position) {
    return position.contains('B') || position.contains('D');
  }
}
