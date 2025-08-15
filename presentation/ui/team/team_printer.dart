import '../../../domain/entities/team.dart';
import '../../io/output/output_writer.dart';

class TeamPrinter {
  final OutputWriter _output;

  TeamPrinter(this._output);

  void printDetails(Team team) {
    _output.writeHeader('⚽ ${team.name.toUpperCase()}');
    _output.writeLine('🏙️ City: ${team.city}');
    _output.writeLine('📜 Motto: "${team.motto}"');
    _output.writeLine('🦁 Mascot: ${team.mascot}');
    _output.writeLine('🎨 Colors: ${team.teamColors?.join(', ')}');
    _output.writeLine(
      '🧑‍🏫 Trainer: ${team.trainer.name} (${team.trainer.experience} yrs)',
    );
    _output.writeLine('🧩 Formation: ${team.formation.name}');
    _output.writeLine('⚽ Strategy: ${team.strategy.displayName}');
    _output.writeLine('👥 Squad Size: ${team.players.length} players');
    _output.writeDivider();
  }
}
