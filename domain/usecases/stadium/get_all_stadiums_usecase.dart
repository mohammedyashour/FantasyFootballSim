import '../../entities/stadium.dart';
import '../../repositories/stadium_repository.dart';

class GetAllStadiumsUseCase {
  final StadiumRepository stadiumRepository;

  GetAllStadiumsUseCase(this.stadiumRepository);

  List<Stadium> call() => stadiumRepository.getAll();
}
