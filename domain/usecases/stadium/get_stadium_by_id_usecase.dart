import '../../entities/stadium.dart';
import '../../repositories/stadium_repository.dart';

class GetStadiumByIdUseCase {
  final StadiumRepository stadiumRepository;

  GetStadiumByIdUseCase(this.stadiumRepository);

  Stadium? call(String id) => stadiumRepository.getById(id);
}
