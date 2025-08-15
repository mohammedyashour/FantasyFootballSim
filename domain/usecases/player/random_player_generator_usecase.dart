import 'dart:math';

import '../../entities/player.dart';
import '../../enums/nationality.dart';
import '../../enums/player_name.dart';
import '../../enums/positions.dart';
import '../../repositories/player_repository.dart';

class RandomPlayerGeneratorUseCase {
  static final Random _random = Random();
  final PlayerRepository _repository;

  RandomPlayerGeneratorUseCase(this._repository);

  Player call() {
    final player = _generatePlayer();
    _repository.add(player);
    return player;
  }

  static Player _generatePlayer() {
    final playerNumber = _generateNumber();
    final name = _generateName();
    final position = Position.values[_random.nextInt(Position.values.length)];
    final nationality =
        Nationality.values[_random.nextInt(Nationality.values.length)];
    final age = 18 + _random.nextInt(23);
    final preferredFoot =
        PreferredFoot.values[_random.nextInt(PreferredFoot.values.length)];
    final height = 160 + _random.nextInt(41);
    final weight = 60 + _random.nextInt(41);
    final power = 40 + _random.nextInt(61);
    final speed = 45 + _random.nextInt(56);
    final stamina = 50 + _random.nextInt(51);
    final skill = 50 + _random.nextInt(51);

    return Player(
      playerNumber: playerNumber,
      name: name,
      position: position,
      nationality: nationality,
      age: age,
      preferredFoot: preferredFoot,
      height: height.toDouble(),
      weight: weight.toDouble(),
      power: power,
      speed: speed,
      stamina: stamina,
      skill: skill,
    );
  }

  static int _generateNumber() {
    return _random.nextInt(99) + 1;
  }

  static String _generateName() {
    final names = PlayerName.values;
    return names[_random.nextInt(names.length)].toString();
  }
}
