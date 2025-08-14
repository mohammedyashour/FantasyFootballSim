enum FormationType {
  FOUR_FOUR_TWO('4-4-2', 'Balanced formation with 4 defenders, 4 midfielders and 2 strikers'),
  FOUR_THREE_THREE('4-3-3', 'Offensive formation with strong wingers'),
  THREE_FIVE_TWO('3-5-2', 'Formation with advanced wingbacks'),
  FOUR_TWO_THREE_ONE('4-2-3-1', 'Modern balanced formation with defensive midfielder'),
  FOUR_ONE_TWO_ONE_TWO('4-1-2-1-2', 'Narrow formation with diamond midfield'),
  THREE_FOUR_THREE('3-4-3', 'Very offensive formation with 3 defenders'),
  FIVE_THREE_TWO('5-3-2', 'Defensive formation with 5 defenders'),
  FOUR_FIVE_ONE('4-5-1', 'Counter-attacking formation with packed midfield'),
  FOUR_SIX_ZERO('4-6-0', 'No strikers with mobile midfielders'),
  THREE_FOUR_ONE_TWO('3-4-1-2', 'Hybrid between 3-5-2 and 4-4-2'),
  FOUR_THREE_TWO_ONE('4-3-2-1', 'Christmas tree shaped formation');

  final String displayName;
  final String description;

  const FormationType(this.displayName, this.description);

  @override
  String toString() => displayName;
}