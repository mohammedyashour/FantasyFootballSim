import '../../repositories/team_repository.dart';
import '../../entities/team.dart';

class SearchTeamsUseCase {
  final TeamRepository _teamRepository;

  SearchTeamsUseCase(this._teamRepository);

  List<Team> call(String query) {
    final allTeams = _teamRepository.getAllTeams();
    return allTeams
        .where(
          (team) =>
              team.name.toLowerCase().contains(query.toLowerCase()) ||
              (team.city?.toLowerCase().contains(query.toLowerCase()) ?? false),
        )
        .toList();
  }
}
