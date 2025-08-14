import 'dart:math';

import '../../entities/referee.dart';
import 'create_referee_usecase.dart';
import '../../enums/referee_name.dart';

class RandomRefereeGeneratorUseCase {
  final CreateRefereeUseCase _createReferee;
  final Random _random = Random();

  RandomRefereeGeneratorUseCase(this._createReferee);

  Referee call() {
    final String name = _generateRandomName();
    final int experienceYears = 1 + _random.nextInt(30);
    final double strictness = _generateStrictness();

    return _createReferee.call(
      name: name,
      experienceYears: experienceYears,
      strictness: strictness,
    );
  }

  String _generateRandomName() {
    return RefereeName
        .values[_random.nextInt(RefereeName.values.length)]
        .displayName;
  }

  double _generateStrictness() {
    final int percentage = 10 + _random.nextInt(86);
    return percentage / 100.0;
  }
}
