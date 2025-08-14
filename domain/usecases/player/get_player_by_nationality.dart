import '../../entities/player.dart';
import '../../enums/nationality.dart';
import '../../repositories/player_repository.dart';

class GetPlayerByNationalityUseCase {
  final PlayerRepository playerRepository;

  GetPlayerByNationalityUseCase(this.playerRepository);

  List<Player> call(String nationalityInput) {
    final nationalityEnum = Nationality.values.firstWhere(
          (n) => n.displayName.toLowerCase() == nationalityInput.trim().toLowerCase()
    );

    return playerRepository.getAll()
        .where((p) => p.nationality == nationalityEnum)
        .toList();
  }
}