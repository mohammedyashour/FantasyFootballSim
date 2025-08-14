import '../enums/Weather.dart';
import '../enums/team_city.dart';
import '../enums/turf_type.dart';

class Stadium {
  final String name;
  final TeamCity location;
  final int capacity;
  final int? attendance;
  final WeatherCondition? weather;
  final double? altitude;
  final TurfType? turfType;

  Stadium({
    required this.name,
    required this.location,
    required this.capacity,
    this.attendance,
    this.weather,
    this.altitude,
    this.turfType,
  });

  @override
  String toString() {
    return '''
🏟 Stadium: $name
📍 Location: ${location.displayName}
👥 Attendance: ${attendance ?? 'Unknown'} / $capacity
🪑 capacity: ${capacity} 
🌦 Weather: ${weather ?? 'Unknown'}
🗻 Altitude: ${altitude != null ? '${altitude}m' : 'Unknown'}
🌱 Turf Type: ${turfType?.displayName ?? 'Unknown'}
''';
  }
}
