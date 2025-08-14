import '../../entities/formation.dart';
import '../../repositories/formation_repository.dart';

class GetFormationsUseCase {
  final FormationRepository _repository;

  GetFormationsUseCase(this._repository);

  List<Formation> call() {
    try {
      return _repository.getAll();
    } catch (e) {
      print("Error getting formations: $e");
      return [];
    }
  }
}