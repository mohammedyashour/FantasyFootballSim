import '../../entities/team.dart';
import '../../repositories/team_repository.dart';

class GetTeamByNameUseCase {
  final TeamRepository _teamRepository;

  GetTeamByNameUseCase(this._teamRepository);

  Team? call(String name) {
    return _teamRepository.getTeamByName(name);
  }
}
