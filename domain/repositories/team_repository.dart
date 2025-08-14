

import '../entities/player.dart';
import '../entities/team.dart';
import '../enums/strategy_enums.dart';

abstract class TeamRepository {
  void saveTeam(Team team);

  bool teamExists(String teamName);

  List<Player> findPlayersInTeams(List<Player> players);

  List<Team> getAllTeams();

  Team? getTeamByName(String name);

  void updateTeam(Team team);

  void deleteTeam(String teamName);

  List<Team> findTeamsByCity(String city);

  List<Team> findTeamsByStrategy(StrategyType strategy);
}