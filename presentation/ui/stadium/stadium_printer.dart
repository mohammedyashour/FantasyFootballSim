import '../../../domain/entities/stadium.dart';
import '../../io/output/output_writer.dart';
import '../../utils/terminal_utils.dart';

class StadiumPrinter {
  final OutputWriter output;

  StadiumPrinter(this.output);

  void printDetails(Stadium stadium) {
    output.writeLine("🏟️ ${'Stadium Details'.withStyle(TerminalColor.GREEN)}");
    output.writeLine("🔖 Name: ${stadium.name}");
    output.writeLine("📍 Location: ${stadium.location.displayName}");
    output.writeLine("👥 Capacity: ${stadium.capacity}");
    output.writeLine("🪑 Attendance: ${stadium.attendance ?? 'Unknown'}");
    output.writeLine("🌦 Weather: ${stadium.weather ?? 'Unknown'}");
    output.writeLine(
      "🗻 Altitude: ${stadium.altitude != null ? '${stadium.altitude}m' : 'Unknown'}",
    );
    output.writeLine(
      "🌱 Turf Type: ${stadium.turfType?.displayName ?? 'Unknown'}",
    );
  }

  void printList(List<Stadium> stadiums) {
    if (stadiums.isEmpty) {
      output.writeLine("⚠️ No stadiums available to list.");
      return;
    }

    output.writeLine(
      "\n📋 ${'List of All Stadiums'.withStyle(TerminalColor.YELLOW)}:",
    );
    stadiums.asMap().forEach((index, stadium) {
      output.writeLine(
        "${index + 1}. ${stadium.name} - ${stadium.location.displayName} (${stadium.capacity} capacity)",
      );
    });
  }
}
