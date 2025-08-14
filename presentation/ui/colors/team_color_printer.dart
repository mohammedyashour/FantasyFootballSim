import '../../../domain/enums/team_colors.dart';
import '../../io/output/output_writer.dart';

class TeamColorPrinter {
  static void printColorsGridWithNumbers(
    OutputWriter output, {
    int columns = 4,
  }) {
    final colors = TeamColor.values;

    for (int i = 0; i < colors.length; i++) {
      String colorName = colors[i].name.toLowerCase();
      output.write("${i + 1}. ${colorName}".padRight(15));

      if ((i + 1) % columns == 0) {
        output.writeLine('');
      }
    }

    if (colors.length % columns != 0) {
      output.writeLine('');
    }
  }
}
