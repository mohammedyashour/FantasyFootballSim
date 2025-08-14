enum TrainerName {
  guardiola('Pep Guardiola'),
  klopp('Jürgen Klopp'),
  mourinho('José Mourinho'),
  ancelotti('Carlo Ancelotti'),
  zidane('Zinedine Zidane'),
  arteta('Mikel Arteta'),
  tenHag('Erik ten Hag'),
  xavi('Xavi Hernández'),
  deschamps('Didier Deschamps'),
  southgate('Gareth Southgate'),
  conte('Antonio Conte'),
  tuchel('Thomas Tuchel'),
  simone('Diego Simeone'),
  spalletti('Luciano Spalletti'),
  allegri('Massimiliano Allegri'),
  vanGaal('Louis van Gaal'),
  rafaBenitez('Rafael Benítez'),
  marceloBielsa('Marcelo Bielsa'),
  frankLampard('Frank Lampard'),
  stevenGerrard('Steven Gerrard'),
  robertoMartinez('Roberto Martínez'),
  hansiFlick('Hansi Flick'),
  julianNagelsmann('Julian Nagelsmann'),
  fernandoSantos('Fernando Santos'),
  tite('Tite'),
  scolari('Luiz Felipe Scolari'),
  dunga('Dunga'),
  joachimLow('Joachim Löw'),
  rudiVoeller('Rudi Völler'),
  cesarePrandelli('Cesare Prandelli'),
  vicenteDelBosque('Vicente del Bosque'),
  luisEnrique('Luis Enrique'),
  ronaldKoeman('Ronald Koeman'),
  bertVanMarwijk('Bert van Marwijk'),
  herveRenard('Hervé Renard'),
  walidRegragui('Walid Regragui'),
  hectorCuper('Héctor Cúper'),
  hassanShehata('Hassan Shehata'),
  vahidHalilhodzic('Vahid Halilhodžić');

  final String displayName;

  const TrainerName(this.displayName);

  @override
  String toString() => displayName;
}