import '../../../domain/repositories/player_repository.dart';
import '../../../domain/entities/player.dart';
import '../../io/input/console_input_reader.dart';
import '../../io/output/console_output_writer.dart';
import 'player_printer.dart';

class SelectPlayerUI {
  final ConsoleInputReader inputReader;
  final ConsoleOutputWriter outputWriter;
  final PlayerRepository playerRepository;

  SelectPlayerUI(this.inputReader, this.outputWriter, this.playerRepository);

  Player? start() {
    final players = playerRepository.getAll();

    if (players.isEmpty) {
      outputWriter.writeLine("⚠️ No existing players available.");
      return null;
    }

    outputWriter.writeLine("\nAvailable Players:");

    for (int i = 0; i < players.length; i++) {
      final p = players[i];
      outputWriter.writeLine("${i + 1}. ${p.name} - ${p.position.name}");
    }

    final printer = PlayerPrinter(outputWriter);

    while (true) {
      final choice = inputReader.readInt(
        "Select player by number (1-${players.length}):",
        min: 1,
        max: players.length,
      );

      final selectedPlayer = players[choice - 1];

      outputWriter.writeLine("\nYou selected:");
      printer.printPlayer(selectedPlayer);

      final confirm =
          inputReader.readString("Confirm selection? (y/n):").toLowerCase();
      if (confirm == 'y') {
        return selectedPlayer;
      } else {
        outputWriter.writeLine("Please choose again.");
      }
    }
  }
}
