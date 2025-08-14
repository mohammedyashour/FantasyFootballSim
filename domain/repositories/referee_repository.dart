import '../entities/referee.dart';

abstract class RefereeRepository {
  Referee create(Referee referee);
  List<Referee> getAll();
  Referee? getById(String id);
}
