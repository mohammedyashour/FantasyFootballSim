import '../../../domain/entities/formation.dart';
import '../../io/output/output_writer.dart';
import 'formation_diagram_printer.dart';

class FormationComparator {
  final OutputWriter _output;
  final FormationDiagramPrinter _diagramPrinter;

  FormationComparator(this._output, this._diagramPrinter);

  void compare(Formation first, Formation second) {
    _output.writeHeader('Formation Comparison');
    _output.writeLine('${first.name.padRight(20)} vs ${second.name}');
    _output.writeLine('=' * 50);

    _output.writeBullet(
      'Attack: ${first.attackRating} vs ${second.attackRating}',
    );
    _output.writeBullet(
      'Defense: ${first.defenseRating} vs ${second.defenseRating}',
    );

    _output.writeHeader('Positional Differences');
    _output.writeLine('${first.name}: ${first.positions.join(' - ')}');
    _output.writeLine('${second.name}: ${second.positions.join(' - ')}');

    _output.writeHeader('Diagram Comparison');
    _output.writeLine('${first.name}:');
    _diagramPrinter.printDiagram(first.positions);
    _output.writeLine('\n${second.name}:');
    _diagramPrinter.printDiagram(second.positions);
  }
}
