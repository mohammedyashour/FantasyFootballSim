import '../../repositories/team_repository.dart';

class TeamExistsUseCase {
  final TeamRepository _teamRepository;

  TeamExistsUseCase(this._teamRepository);

  bool call(String teamName) =>
      _teamRepository.teamExists(teamName);
}