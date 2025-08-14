import '../../domain/entities/referee.dart';
import '../../domain/repositories/referee_repository.dart';

class RefereeRepositoryImpl implements RefereeRepository {
  final List<Referee> _referees = [];

  @override
  Referee create(Referee referee) {
    _referees.add(referee);
    return referee;
  }

  @override
  List<Referee> getAll() => _referees;

  @override
  Referee? getById(String id) {
    try {
      return _referees.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }
}
