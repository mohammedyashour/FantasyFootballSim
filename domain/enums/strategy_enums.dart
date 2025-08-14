enum StrategyType {
  offensive('⚡ Offensive', 'All-out attack with focus on scoring'),
  defensive('🛡️ Defensive', 'Strong defense focused on preventing goals'),
  balanced('⚖️ Balanced', 'Equal balance between attack and defense'),
  counterAttack('💨 Counter Attack', 'Quick counter-attacks after regaining possession'),
  highPress('🔝 High Press', 'High-intensity pressing in midfield'),
  parkTheBus('🚌 Park the Bus', 'Ultra-defensive formation near the goal'),
  possession('🔄 Possession', 'Maintain ball control and tire opponents'),
  gegenpress('⚡ Gegenpress', 'Aggressive pressing immediately after losing the ball'),
  tikiTaka('👟 Tiki-taka', 'Quick short passes to dominate play'),
  longBall('🎯 Long Ball', 'Direct long balls to forwards'),
  wingPlay('✈️ Wing Play', 'Focus on attacking through the wings'),
  directPlay('⬆️ Direct Play', 'Straightforward attacking play toward goal'),
  catenaccio('🔒 Catenaccio', 'Classic Italian defensive system'),
  zonalMarking('📊 Zonal Marking', 'Defensive zone coverage'),
  manToMan('👥 Man to Man', 'Man-to-man defensive marking');

  final String displayName;
  final String description;

  const StrategyType(this.displayName, this.description);

  String get fullDescription => '$displayName - $description';

  @override
  String toString() => displayName;
}