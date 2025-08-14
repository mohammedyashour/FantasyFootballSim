enum RefereeName {
  john,
  david,
  michael,
  robert,
  james,
  william,
  daniel,
  thomas,
  lucas,
  hassan,
  omar,
  yousef,
  karim,
  mohamed,
  ali,
  noor,
  rami,
  fares,
}

extension RefereeFirstNameX on RefereeName {
  String get displayName => name[0].toUpperCase() + name.substring(1);
}
