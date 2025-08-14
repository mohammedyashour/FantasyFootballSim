import '../../domain/enums/strategy_enums.dart';
import '../../domain/repositories/team_repository.dart';
import '../../domain/entities/team.dart';
import '../../domain/entities/player.dart';

class TeamRepositoryImpl implements TeamRepository {
  final List<Team> _teams = [];

  @override
  void saveTeam(Team team) {
    if (teamExists(team.name)) {
      print('Warning: Team "${team.name}" already exists');
      return;
    }

    final unavailablePlayers = findPlayersInTeams(team.players);
    if (unavailablePlayers.isNotEmpty) {
      print('Warning: ${unavailablePlayers.length} players already in other teams:');
      unavailablePlayers.take(3).forEach((p) => print('- ${p.name}'));
    }

    _teams.add(team);
    print('Team "${team.name}" saved successfully (with ${unavailablePlayers.length} shared players)');
  }

  @override
  bool teamExists(String teamName) {
    return _teams.any((team) => team.name == teamName);
  }

  @override
  List<Player> findPlayersInTeams(List<Player> players) {
    final playerIds = players.map((p) => p.id).toList();
    return _teams
        .expand((team) => team.players.where((p) => playerIds.contains(p.id)))
        .toList();
  }

  @override
  List<Team> getAllTeams() {
    print('Returning all ${_teams.length} teams');
    return List.unmodifiable(_teams);
  }

  @override
  Team? getTeamByName(String name) {
    try {
      final team = _teams.firstWhere((team) => team.name == name);
      print('Retrieved team "$name"');
      return team;
    } catch (e) {
      print('Team "$name" not found');
      return null;
    }
  }

  @override
  void updateTeam(Team team) {
    final index = _teams.indexWhere((t) => t.name == team.name);
    if (index == -1) {
      print('Failed to update: Team "${team.name}" not found');
      return;
    }
    _teams[index] = team;
    print(' Team "${team.name}" updated successfully');
  }

  @override
  void deleteTeam(String teamName) {
    final initialCount = _teams.length;
    _teams.removeWhere((team) => team.name == teamName);
    if (_teams.length < initialCount) {
      print(' Team "$teamName" deleted successfully');
    } else {
      print(' Team "$teamName" not found for deletion');
    }
  }

  @override
  List<Team> findTeamsByCity(String city) {
    final results = _teams.where((team) => team.city?.toLowerCase() == city.toLowerCase()).toList();
    print('Found ${results.length} teams in city "$city"');
    return results;
  }

  @override
  List<Team> findTeamsByStrategy(StrategyType strategy) {
    final results = _teams.where((team) => team.strategy == strategy).toList();
    print('Found ${results.length} teams with strategy "${strategy.toString()}"');
    return results;
  }

  void clear() {
    _teams.clear();
    print('All teams cleared');
  }
}