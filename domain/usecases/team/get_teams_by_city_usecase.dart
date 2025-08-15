import '../../repositories/team_repository.dart';
import '../../entities/team.dart';

class GetTeamsByCityUseCase {
  final TeamRepository _teamRepository;

  GetTeamsByCityUseCase(this._teamRepository);

  List<Team> call(String city) => _teamRepository.findTeamsByCity(city);
}
