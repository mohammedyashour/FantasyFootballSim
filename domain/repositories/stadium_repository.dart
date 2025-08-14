import '../entities/stadium.dart';

abstract class StadiumRepository {
  Stadium create(Stadium stadium);
  List<Stadium> getAll();
  Stadium? getById(String id);
}
