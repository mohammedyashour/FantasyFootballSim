import '../../entities/referee.dart';
import '../../repositories/referee_repository.dart';

class CreateRefereeUseCase {
  final RefereeRepository refereeRepository;

  CreateRefereeUseCase(this.refereeRepository);

  Referee call({
    required String name,
    required int experienceYears,
    double strictness = 0.5,
  }) {
    final referee = Referee(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      experienceYears: experienceYears,
      strictness: strictness,
    );
    return refereeRepository.create(referee);
  }
}
