import '../../entities/formation.dart';
import '../../entities/player.dart';
import '../../entities/team.dart';
import '../../entities/trainer.dart';
import '../../enums/strategy_enums.dart';
import '../../enums/team_colors.dart';
import '../../repositories/team_repository.dart';

class CreateTeamUseCase {
  final TeamRepository _teamRepository;

  CreateTeamUseCase(this._teamRepository);


  Team call({
    required String teamName,
    required Trainer trainer,
    required List<Player> players,
    List<Player>? bench,
    required StrategyType strategy,
    required Formation formation,
    String? mascot,
    String? city,
    List<TeamColor>? teamColors,
    String? motto,
  }) {
    if (players.length < 11) {
      print('❌ Error: Team must have at least 11 players');
    }

    if (_teamRepository.teamExists(teamName)) {
      print('❌ Error: Team name "$teamName" already exists');
    }


    final team = Team(
      name: teamName,
      trainer: trainer,
      players: players,
      bench: bench ?? const [],
      strategy: strategy,
      formation: formation,
      mascot: mascot,
      city: city,
      teamColors: teamColors,
      motto: motto,
    );

    for (var player in team.players) {
      player.team = team;
    }
    for (var player in team.bench) {
      player.team = team;
    }

    _teamRepository.saveTeam(team);
    print('✅ Team "$teamName" created successfully!');
    print('   👨‍🏫 Trainer: ${trainer.name}');
    print('   ⚽ Players: ${players.length} (${bench?.length ?? 0} on bench)');
    print('   🎯 Strategy: ${strategy.name}');
    print('   🧩 Formation: ${formation.name}');

    return team;
  }
}
