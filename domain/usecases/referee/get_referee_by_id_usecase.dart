import '../../entities/referee.dart';
import '../../repositories/referee_repository.dart';

class GetRefereeByIdUseCase {
  final RefereeRepository refereeRepository;

  GetRefereeByIdUseCase(this.refereeRepository);

  Referee? call(String id) {
    return refereeRepository.getById(id);
  }
}
