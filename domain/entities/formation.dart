import '../enums/formation_type.dart';

class Formation {
  final FormationType type;
  final String name;
  final String description;
  final List<String> positions;
  final int attackRating;
  final int defenseRating;

  const Formation({
    required this.type,
    required this.name,
    required this.description,
    required this.positions,
    required this.attackRating,
    required this.defenseRating,
  });

  @override
  String toString() => name;
}
