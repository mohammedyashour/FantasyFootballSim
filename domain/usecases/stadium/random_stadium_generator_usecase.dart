import 'dart:math';

import '../../entities/stadium.dart';
import '../../enums/Weather.dart';
import '../../enums/team_city.dart';
import '../../enums/turf_type.dart';
import '../../repositories/stadium_repository.dart';

class RandomStadiumGeneratorUseCase {
  final StadiumRepository stadiumRepository;
  final Random _random = Random();

  RandomStadiumGeneratorUseCase(this.stadiumRepository);

  Stadium call() {
    final String name = _randomName();
    final TeamCity location = _randomCity();
    final int capacity = 20000 + _random.nextInt(60001); // 20k - 80k
    final int attendance = _random.nextInt(capacity + 1);
    final WeatherCondition weather =
        WeatherCondition.values[_random.nextInt(
          WeatherCondition.values.length,
        )];
    final double altitude = 0 + _random.nextInt(2501).toDouble(); // 0 - 2500m
    final TurfType turfType = _randomTurf();

    final stadium = Stadium(
      name: name,
      location: location,
      capacity: capacity,
      attendance: attendance,
      weather: weather,
      altitude: altitude,
      turfType: turfType,
    );

    return stadiumRepository.create(stadium);
  }

  String _randomName() {
    const names = [
      'Liberty Arena',
      'Eagle Stadium',
      'Sunrise Park',
      'Victory Dome',
      'Royal Ground',
      'Unity Field',
    ];
    return names[_random.nextInt(names.length)];
  }

  TeamCity _randomCity() {
    final values = TeamCity.values;
    return values[_random.nextInt(values.length)];
  }

  TurfType _randomTurf() {
    final values = TurfType.values;
    return values[_random.nextInt(values.length)];
  }
}
