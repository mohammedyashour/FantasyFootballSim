import '../../entities/trainer.dart';
import '../../repositories/trainer_repository.dart';

class SelectTrainerUseCase {
  final TrainerRepository _repository;

  SelectTrainerUseCase(this._repository);
  List<Trainer> get existingTrainers => _repository.getAll();
  Trainer? findTrainerByName(String name) => _repository.getByName(name);

  List<Trainer> getAllTrainers() => _repository.getAll();

  List<Trainer> getTrainersByExperience(int minExperience) =>
      _repository.getAll().where((t) => t.experience >= minExperience).toList();
}