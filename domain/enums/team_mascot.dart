enum TeamMascot {
  panther('Panther'),
  falcon('Falcon'),
  shark('Shark'),
  lion('Lion'),
  tiger('Tiger'),
  wolf('Wolf'),
  eagle('Eagle'),
  bear('Bear'),
  dragon('Dragon'),
  rhino('Rhino'),
  football('Football'),
  goldenBoot('Golden Boot'),
  trophy('Trophy'),
  championCup('Champion Cup'),
  soccerBall('Soccer Ball'),
  goalPost('Goal Post'),
  knight('Knight'),
  shield('Shield'),
  sword('Sword'),
  castle('Castle'),
  thunder('Thunder'),
  hurricane('Hurricane'),
  volcano('Volcano'),
  pharaoh('Pharaoh'),
  pyramid('Pyramid'),
  sphinx('Sphinx'),
  jersey('Jersey'),
  whistle('Whistle'),
  cleats('Cleats'),
  flame('Flame'),
  star('Star'),
  comet('Comet');

  final String displayName;

  const TeamMascot(this.displayName);

  @override
  String toString() => displayName;
}
