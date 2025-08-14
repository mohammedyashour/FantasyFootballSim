enum MatchEventType {
  goal('⚽ Goal'),
  penalty('⚽ (PEN) Penalty'),
  shotOnTarget('🎯 Shot on Target'),
  shotOffTarget('🚀 Shot off Target'),
  blockedShot('🛡️ Blocked Shot'),
  hitWoodwork('🥅 Hit Woodwork'),
  corner('📐 Corner'),
  freeKick('🆓 Free Kick'),
  goalKick('🥅 Goal Kick'),
  kickOff('🔛 Kick Off'),
  throwIn('🤾 Throw In'),
  goalClearance('🧹 Goal Clearance'),
  yellowCard('🟨 Yellow Card'),
  redCard('🟥 Red Card'),
  secondYellow('🟨🟥 Second Yellow Card'),
  foul('🚫 Foul'),
  interception('✋ Interception'),
  tackle('⚔️ Tackle'),
  dangerousAttack('⚡ Dangerous Attack'),
  counterAttack('⚡ Counter Attack'),
  midfieldPossession('🔄 Midfield Possession'),
  offside('🚩 Offside'),
  substitution('🔁 Substitution'),
  injury('🤕 Injury'),
  playersClash('💥 Players Clash'),
  goalkeeperSave('🧤 Goalkeeper Save'),
  goalkeeperError('❌🧤 Goalkeeper Error'),
  varCheck('📺 VAR Check'),
  varDecision('✅ VAR Decision'),
  protest('🙋 Protest'),
  timeWasting('⏳ Time Wasting'),
  weatherChange('🌦️ Weather Change'),
  crowdDisturbance('👥 Crowd Disturbance'),
  specialEvent('✨ Special Event');

  final String displayName;

  const MatchEventType(this.displayName);

  @override
  String toString() => displayName;
}
