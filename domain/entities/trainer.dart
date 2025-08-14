import '../enums/nationality.dart';
import 'team.dart';

class Trainer {
  final String name;
  final int age;
  final Nationality nationality;
  final int experience;
  final String strategySpecialty;
  final int motivationLevel;
  Team? team;

  Trainer({
    required this.name,
    required this.age,
    required this.nationality,
    required this.experience,
    this.strategySpecialty = 'Balanced',
    this.motivationLevel = 50,
    this.team,
  });

  @override
  String toString() {
    final teamName = team != null ? team!.name : 'No Team';
    return 'Trainer(name: $name, age: $age, nationality: $nationality, experience: $experience, strategySpecialty: $strategySpecialty, motivationLevel: $motivationLevel, team: $teamName)';
  }
}
