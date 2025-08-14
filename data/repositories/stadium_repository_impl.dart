import '../../domain/entities/stadium.dart';
import '../../domain/repositories/stadium_repository.dart';

class StadiumRepositoryImpl implements StadiumRepository {
  final List<Stadium> _stadiums = [];

  @override
  Stadium create(Stadium stadium) {
    _stadiums.add(stadium);
    return stadium;
  }

  @override
  List<Stadium> getAll() => _stadiums;

  @override
  Stadium? getById(String id) {
    try {
      return _stadiums.firstWhere((s) => s.name == id);
    } catch (_) {
      return null;
    }
  }
}
