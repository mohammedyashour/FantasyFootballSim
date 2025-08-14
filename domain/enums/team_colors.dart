enum TeamColor {
  red('Red'),
  green('Green'),
  blue('Blue'),
  yellow('Yellow'),
  orange('Orange'),
  purple('Purple'),
  pink('Pink'),
  brown('Brown'),
  black('Black'),
  white('White'),
  gray('Gray'),
  cyan('Cyan'),
  magenta('Magenta'),
  lime('Lime'),
  teal('Teal'),
  navy('Navy'),
  olive('Olive'),
  maroon('Maroon'),
  silver('Silver'),
  gold('Gold');

  final String displayName;

  const TeamColor(this.displayName);

  @override
  String toString() => displayName;
}
