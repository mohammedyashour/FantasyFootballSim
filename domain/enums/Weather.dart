enum WeatherCondition {
  sunny('Sunny'),
  rainy('Rainy'),
  snowy('Snowy'),
  cloudy('Cloudy'),
  windy('Windy'),
  foggy('Foggy'),
  stormy('Stormy'),
  partlyCloudy('Partly Cloudy'),
  thunderstorm('Thunderstorm'),
  hail('Hail'),
  sleet('Sleet'),
  drizzle('Drizzle'),
  humid('Humid'),
  dry('Dry'),
  misty('Misty'),
  clear('Clear');

  final String displayName;

  const WeatherCondition(this.displayName);

  @override
  String toString() => displayName;
}
