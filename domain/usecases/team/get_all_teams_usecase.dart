import '../../entities/team.dart';
import '../../repositories/team_repository.dart';

class GetAllTeamsUseCase {
  final TeamRepository _teamRepository;

  GetAllTeamsUseCase(this._teamRepository);

  List<Team> call() {
    return _teamRepository.getAllTeams();
  }
}
