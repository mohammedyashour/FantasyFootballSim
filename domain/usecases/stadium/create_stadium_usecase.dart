import '../../entities/stadium.dart';
import '../../enums/Weather.dart';
import '../../enums/team_city.dart';
import '../../enums/turf_type.dart';
import '../../repositories/stadium_repository.dart';

class CreateStadiumUseCase {
  final StadiumRepository stadiumRepository;

  CreateStadiumUseCase(this.stadiumRepository);

  Stadium call({
    required String name,
    required TeamCity location,
    required int capacity,
    int? attendance,
    WeatherCondition? weather,
    double? altitude,
    TurfType? turfType,
  }) {
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
}
