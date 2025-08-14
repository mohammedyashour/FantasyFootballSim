import '../../../domain/enums/team_colors.dart';
import '../../io/input/console_input_reader.dart';
import '../../io/output/output_writer.dart';
import 'team_color_printer.dart';

class ColorSelectionUI {
  static List<TeamColor> selectColors(
    ConsoleInputReader inputReader,
    OutputWriter output, {
    int max = 3,
  }) {
    final colors = <TeamColor>[];

    final colorCount = inputReader.readInt(
      "🎨 How many team colors? (1-$max recommended)",
      min: 1,
      max: max,
    );

    output.writeLine("\nAvailable Colors:");
    TeamColorPrinter.printColorsGridWithNumbers(output, columns: 4);

    for (int i = 0; i < colorCount; i++) {
      while (true) {
        try {
          final colorIndex =
              inputReader.readInt(
                "Select color ${i + 1} (1-${TeamColor.values.length}):",
                min: 1,
                max: TeamColor.values.length,
              ) -
              1;

          final selectedColor = TeamColor.values[colorIndex];
          if (!colors.contains(selectedColor)) {
            colors.add(selectedColor);
            break;
          }
          output.writeWarning("This color is already selected!");
        } catch (e) {
          output.writeError("Invalid color selection. Please try again.");
        }
      }
    }
    return colors;
  }
}
