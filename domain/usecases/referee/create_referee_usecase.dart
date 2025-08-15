import 'package:uuid/uuid.dart';

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
    final uuid = Uuid();
    final referee = Referee(
      id: uuid.v4(),
      name: name,
      experienceYears: experienceYears,
      strictness: strictness,
    );
    return refereeRepository.add(referee);
  }
}
