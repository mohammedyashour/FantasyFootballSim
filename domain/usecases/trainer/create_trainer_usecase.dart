import '../../entities/trainer.dart';
import '../../enums/nationality.dart';
import '../../repositories/trainer_repository.dart';

class CreateTrainerUseCase {
  final TrainerRepository trainerRepository;

  CreateTrainerUseCase(this.trainerRepository);

  Trainer call({
    required String name,
    required int age,
    required Nationality nationality,
    required int experience,
  }) {
    final trainer = Trainer(
      name: name,
      age: age,
      nationality: nationality,
      experience: experience,
    );
    trainerRepository.add(trainer);
    return trainer;
  }
}
