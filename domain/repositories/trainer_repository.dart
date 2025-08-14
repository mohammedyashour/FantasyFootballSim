import '../entities/trainer.dart';

abstract class TrainerRepository {
  void add(Trainer trainer);
  List<Trainer> getAll();
  Trainer? getByName(String name);
}
