import '../../entities/player.dart';
import '../../repositories/player_repository.dart';

class GetPlayerByIdUseCase {
  final PlayerRepository playerRepository;

  GetPlayerByIdUseCase(this.playerRepository);

  Player? call(String id) {
    return playerRepository.getById(id);
  }
}
