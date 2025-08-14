import '../../repositories/team_repository.dart';
import '../../entities/team.dart';
import '../../enums/strategy_enums.dart';

class GetTeamsByStrategyUseCase {
  final TeamRepository _teamRepository;

  GetTeamsByStrategyUseCase(this._teamRepository);

  List<Team> call(StrategyType strategy) =>
      _teamRepository.findTeamsByStrategy(strategy);
}