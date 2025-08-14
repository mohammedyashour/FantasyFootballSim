import '../enums/nationality.dart';
import '../enums/positions.dart';
import 'team.dart';

enum PreferredFoot { right, left, both }

class Player {
  final String id;
  final String name;
  final Position position;
  final int power;
  final int speed;
  final int stamina;
  final int skill;
  final Nationality nationality;
  final int age;
  final double height;
  final double weight;
  final PreferredFoot preferredFoot;
  Team? team;
  int health;
  bool isInjured;

  Player({
    required this.id,
    required this.name,
    required this.position,
    required this.power,
    required this.speed,
    required this.stamina,
    required this.skill,
    required this.nationality,
    required this.age,
    required this.preferredFoot,
    required this.height,
    required this.weight,
    this.team,
    this.health = 100,
    this.isInjured = false,
  });

  double get overallRate {
    return (power + speed + stamina + skill) / 4;
  }

  double get injuryChance {
    double chance = 1 - (health / 100);
    if (stamina < 50) {
      chance += 0.1;
    }
    return chance.clamp(0, 1);
  }

  @override
  String toString() {
    final teamName = team != null ? team!.name : "Free Agent";
    return 'Player(id: $id, name: $name, position: $position, nationality: $nationality, age: $age, preferredFoot: ${preferredFoot.name}, power: $power, speed: $speed, stamina: $stamina, skill: $skill, overallRate: ${overallRate.toStringAsFixed(2)}, health: $health, injured: ${isInjured ? "Yes" : "No"}, team: $teamName)';
  }
}
