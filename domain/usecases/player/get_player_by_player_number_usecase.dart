import '../../entities/player.dart';
import '../../repositories/player_repository.dart';

class GetPlayerByPlayerNumberUseCase {
  final PlayerRepository playerRepository;

  GetPlayerByPlayerNumberUseCase(this.playerRepository);

  Player? call(int playerNumber) {
    return playerRepository.getByPlayerNumber(playerNumber);
  }
}
