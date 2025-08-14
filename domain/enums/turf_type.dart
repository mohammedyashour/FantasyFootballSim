enum TurfType {
  naturalGrass('Natural Grass'),
  hybridGrass('Hybrid Grass'),
  artificialTurf('Artificial Turf');

  final String displayName;

  const TurfType(this.displayName);

  @override
  String toString() => displayName;
}
