import '../entities/formation.dart';
import '../enums/formation_type.dart';

abstract class FormationRepository {
  List<Formation> getAll();

  Formation? getByName(String name);

  List<Formation> getByType(FormationType type);
}
