import '../../../domain/entities/formation.dart';
import '../../io/output/output_writer.dart';
import '../../utils/terminal_utils.dart';
import 'formation_diagram_printer.dart';

class FormationDetailsPrinter {
  final OutputWriter _output;
  final FormationDiagramPrinter _diagramPrinter;

  FormationDetailsPrinter(this._output, this._diagramPrinter);

  void printDetails(Formation formation) {
    _output.writeHeader(formation.name);
    _output.writeBullet('Type: ${formation.type.toString().split('.').last}');
    _output.writeBullet('Description: ${formation.description}');
    _output.writeBullet('Attack Rating: ${formation.attackRating}');
    _output.writeBullet('Defense Rating: ${formation.defenseRating}');

    _output.writeHeader('Positional Diagram');
    _diagramPrinter.printDiagram(formation.positions);

    _output.writeHeader('Strengths');
    _printStrengthsAndWeaknesses(formation);
  }

  void _printStrengthsAndWeaknesses(Formation formation) {
    if (formation.attackRating >= 8) {
      _output.writeBullet(
        '✅ Strong attacking presence',
        color: TerminalColor.GREEN,
      );
    }

    if (formation.defenseRating >= 8) {
      _output.writeBullet(
        '🛡️ Solid defensive structure',
        color: TerminalColor.BLUE,
      );
    }

    if (formation.positions.where(_isMidfielder).length >= 4) {
      _output.writeBullet('🎯 Midfield dominance', color: TerminalColor.CYAN);
    }

    if (formation.positions.where(_isAttacker).length <= 1) {
      _output.writeBullet(
        '⚠️ Limited attacking options',
        color: TerminalColor.YELLOW,
      );
    }
  }

  bool _isMidfielder(String position) {
    return position.startsWith('M') ||
        position.contains('M') ||
        position == 'CM' ||
        position == 'WM';
  }

  bool _isAttacker(String position) {
    return position.startsWith('S') ||
        position.startsWith('F') ||
        position.contains('W') ||
        position == 'CF';
  }
}
