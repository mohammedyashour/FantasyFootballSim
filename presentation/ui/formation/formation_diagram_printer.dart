import '../../io/output/output_writer.dart';

class FormationDiagramPrinter {
  final OutputWriter _output;

  FormationDiagramPrinter(this._output);

  void printDiagram(List<String> positions) {
    final lines = _buildFormationLines(positions);
    for (final line in lines) {
      _output.writeLine(line);
    }
  }

  List<String> _buildFormationLines(List<String> positions) {
    final defense = positions.where((p) => _isDefender(p)).toList();
    final midfield = positions.where((p) => _isMidfielder(p)).toList();
    final attack = positions.where((p) => _isAttacker(p)).toList();

    return [
      ' ' * 10 + 'GK',
      ' ' * 8 + defense.join('  '),
      ' ' * 6 + midfield.join('    '),
      ' ' * 4 + attack.join('      '),
    ];
  }

  bool _isDefender(String position) {
    return position.startsWith('D') ||
        position.contains('B') ||
        position == 'CB' ||
        position == 'FB';
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
