import '../entities/referee.dart';

abstract class RefereeRepository {
  Referee add(Referee referee);
  List<Referee> getAll();
  Referee? getById(String id);
}
