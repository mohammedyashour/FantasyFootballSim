import '../../entities/player.dart';
import '../../repositories/player_repository.dart';

class GetPlayerByNameUseCase {
  final PlayerRepository playerRepository;

  GetPlayerByNameUseCase(this.playerRepository);

  Player? call(String name) {
    return playerRepository.getByName(name);
  }
}
