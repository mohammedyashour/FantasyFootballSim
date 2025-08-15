import '../../domain/entities/trainer.dart';
import '../../domain/repositories/trainer_repository.dart';

class TrainerRepositoryImpl implements TrainerRepository {
  final List<Trainer> _trainers = [];
  static final TrainerRepositoryImpl _instance =
      TrainerRepositoryImpl._internal();

  factory TrainerRepositoryImpl() => _instance;

  TrainerRepositoryImpl._internal();

  @override
  void add(Trainer trainer) {
    if (!_trainers.any((t) => t.name == trainer.name)) {
      _trainers.add(trainer);
    }
  }

  @override
  List<Trainer> getAll() => List.unmodifiable(_trainers);

  @override
  Trainer? getByName(String name) {
    try {
      return _trainers.firstWhere((t) => t.name == name);
    } catch (_) {
      return null;
    }
  }
}
