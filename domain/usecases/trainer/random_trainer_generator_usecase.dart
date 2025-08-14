import 'dart:math';

import '../../entities/trainer.dart';
import '../../enums/nationality.dart';
import '../../enums/strategy_enums.dart';
import '../../enums/trainer_name.dart';
import '../../repositories/trainer_repository.dart';

class RandomTrainerGeneratorUseCase {
  final TrainerRepository trainerRepository;
  static final _random = Random();

  RandomTrainerGeneratorUseCase(this.trainerRepository);

  Trainer call() {
    final trainer = _generateRandomTrainer();
    trainerRepository.add(trainer);
    return trainer;
  }

  static Trainer _generateRandomTrainer() {
    final name =
        TrainerName.values[_random.nextInt(TrainerName.values.length)].name;
    final age = 30 + _random.nextInt(26);
    final nationality =
        Nationality.values[_random.nextInt(Nationality.values.length)];
    final experience = 1 + _random.nextInt(54);
    final strategy =
        StrategyType.values[_random.nextInt(StrategyType.values.length)].name;
    final motivationLevel = 40 + _random.nextInt(61);

    return Trainer(
      name: name,
      age: age,
      nationality: nationality,
      experience: experience,
      strategySpecialty: strategy,
      motivationLevel: motivationLevel,
    );
  }
}
