import '../../entities/referee.dart';
import '../../repositories/referee_repository.dart';

class GetAllRefereesUseCase {
  final RefereeRepository refereeRepository;

  GetAllRefereesUseCase(this.refereeRepository);

  List<Referee> call() {
    return refereeRepository.getAll();
  }
}
