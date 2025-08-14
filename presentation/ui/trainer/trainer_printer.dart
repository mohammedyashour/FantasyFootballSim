import '../../../domain/entities/trainer.dart';
import '../../io/output/output_writer.dart';
import '../../utils/terminal_utils.dart';

class TrainerPrinter {
  final OutputWriter output;

  TrainerPrinter(this.output);

  void printDetails(Trainer trainer) {
    output.writeLine(
      "\n${'🎓 Trainer Details'.withStyle(TerminalColor.MAGENTA)}",
    );
    output.writeLine(
      "----------------------------------------".withStyle(TerminalColor.CYAN),
    );
    output.writeLine(
      "👤 Name:         ${trainer.name}".withStyle(TerminalColor.YELLOW),
    );
    output.writeLine(
      "🎂 Age:          ${trainer.age}".withStyle(TerminalColor.YELLOW),
    );
    output.writeLine(
      "🌍 Nationality:  ${trainer.nationality.name}".withStyle(
        TerminalColor.YELLOW,
      ),
    );
    output.writeLine(
      "📈 Experience:   ${trainer.experience}/100".withStyle(
        TerminalColor.YELLOW,
      ),
    );
    output.writeLine(
      "----------------------------------------".withStyle(TerminalColor.CYAN),
    );
  }
}
