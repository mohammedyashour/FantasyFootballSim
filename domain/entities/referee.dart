class Referee {
  final String id;
  final String name;
  final int experienceYears;
  final double strictness;

  const Referee({
    required this.id,
    required this.name,
    this.experienceYears = 5,
    this.strictness = 0.5,
  });

  bool get isStrict => strictness > 0.7;

  bool get isLenient => strictness < 0.3;
}
