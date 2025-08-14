enum Position {
  GK('Goalkeeper', '🧤'),
  CB('Center Back', '🛡️'),
  LB('Left Back', '⬅️🛡️'),
  RB('Right Back', '➡️🛡️'),
  LWB('Left Wing Back', '⬅️🚀'),
  RWB('Right Wing Back', '➡️🚀'),
  CDM('Central Defensive Midfielder', '🛡️⚽'),
  CM('Central Midfielder', '⚽'),
  CAM('Central Attacking Midfielder', '🎯⚽'),
  RAM('Right Attacking Midfielder', '➡️🎯'),
  LAM('Left Attacking Midfielder', '⬅️🎯'),
  LM('Left Midfielder', '⬅️⚽'),
  RM('Right Midfielder', '➡️⚽'),
  LW('Left Winger', '⬅️⚡'),
  RW('Right Winger', '➡️⚡'),
  CF('Center Forward', '🎯'),
  ST('Striker', '👟'),
  SS('Second Striker', '👟👟');

  final String displayName;
  final String emoji;

  const Position(this.displayName, this.emoji);

  @override
  String toString() => '$emoji $displayName';

  String toEmoji() => '$emoji';
}
