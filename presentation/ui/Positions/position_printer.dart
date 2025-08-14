import '../../../domain/enums/positions.dart';
import '../../io/output/output_writer.dart';

class PositionPrinter {
  static void printPositionsGridWithNumbers(
    OutputWriter output, {
    int columns = 4,
  }) {
    final values = Position.values;
    for (int i = 0; i < values.length; i++) {
      final name = values[i].name;
      final label = '${i + 1}. $name'.padRight(18);
      output.write(label);
      if ((i + 1) % columns == 0) {
        output.writeLine('');
      }
    }
    if (values.length % columns != 0) {
      output.writeLine('');
    }
  }
}
