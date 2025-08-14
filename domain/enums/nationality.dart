enum Nationality {
  egypt('Egypt'),
  saudiArabia('Saudi Arabia'),
  jordan('Jordan'),
  morocco('Morocco'),
  algeria('Algeria'),
  palestine('Palestine'),
  qatar('Qatar'),
  iraq('Iraq'),
  lebanon('Lebanon'),
  syria('Syria'),
  tunisia('Tunisia'),
  yemen('Yemen'),
  uae('United Arab Emirates'),
  kuwait('Kuwait'),
  oman('Oman'),
  bahrain('Bahrain'),
  sudan('Sudan'),
  libya('Libya'),
  mauritania('Mauritania'),
  somalia('Somalia'),
  djibouti('Djibouti'),
  comoros('Comoros'),
  other('Other');

  final String displayName;

  const Nationality(this.displayName);

  @override
  String toString() => displayName;
}
