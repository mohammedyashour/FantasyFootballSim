import '../../entities/trainer.dart';
import '../../repositories/trainer_repository.dart';

class GetAllTrainersUseCase {
  final TrainerRepository trainerRepository;

  GetAllTrainersUseCase(this.trainerRepository);

  List<Trainer> call() => trainerRepository.getAll();
}
