enum TeamCity {
  cairo('Cairo'),
  london('London'),
  tokyo('Tokyo'),
  buenosAires('Buenos Aires'),
  casablanca('Casablanca'),
  istanbul('Istanbul'),
  doha('Doha'),
  riyadh('Riyadh'),
  dubai('Dubai'),
  mexicoCity('Mexico City'),
  newYork('New York'),
  paris('Paris'),
  berlin('Berlin'),
  rome('Rome'),
  madrid('Madrid'),
  moscow('Moscow'),
  beijing('Beijing'),
  seoul('Seoul'),
  singapore('Singapore'),
  sydney('Sydney'),
  losAngeles('Los Angeles'),
  toronto('Toronto'),
  saoPaulo('São Paulo'),
  lagos('Lagos'),
  nairobi('Nairobi'),
  johannesburg('Johannesburg');

  final String displayName;

  const TeamCity(this.displayName);

  @override
  String toString() => displayName;
}
