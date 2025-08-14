import '../../entities/player.dart';
import '../../enums/nationality.dart';
import '../../enums/positions.dart';
import '../../repositories/player_repository.dart';

class CreatePlayerUseCase {
  final PlayerRepository repository;

  CreatePlayerUseCase(this.repository);

  Player call({
    required String id,
    required String name,
    required Position position,
    required Nationality nationality,
    required int age,
    required PreferredFoot preferredFoot,
    required double height,
    required double weight,
    required int power,
    required int speed,
    required int stamina,
    required int skill,
    int health = 100,
    bool isInjured = false,
  }) {
    final player = Player(
      id: id,
      name: name,
      position: position,
      nationality: nationality,
      age: age,
      preferredFoot: preferredFoot,
      height: height,
      weight: weight,
      power: power,
      speed: speed,
      stamina: stamina,
      skill: skill,
      health: health,
      isInjured: isInjured,
    );

    repository.add(player);
    return player;
  }
}
