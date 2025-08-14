enum TeamMotto {
  victoryThroughUnity('Victory Through Unity'),
  strongerTogether('Stronger Together'),
  bornToWin('Born to Win'),
  noGutsNoGlory('No Guts No Glory'),
  attackIsTheBestDefense('Attack is the Best Defense');

  final String display;

  const TeamMotto(this.display);

  @override
  String toString() => display;
}
