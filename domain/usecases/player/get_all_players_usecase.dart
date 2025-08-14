import '../../entities/player.dart';
import '../../repositories/player_repository.dart';

class GetAllPlayersUseCase {
  final PlayerRepository playerRepository;

  GetAllPlayersUseCase(this.playerRepository);

  List<Player> call() => playerRepository.getAll();
}
