import '../../../domain/entities/player.dart';
import '../../io/input/console_input_reader.dart';

class ListPlayersUI {
  final List<Player> players;
  final ConsoleInputReader _inputReader;

  ListPlayersUI(this.players, this._inputReader);

  void start() {
    if (players.isEmpty) {
      print("⚠️ No players available to list.");
      return;
    }

    print("\n📋 List of All Players:");
    players.asMap().forEach((index, player) {
      print(
        "${index + 1}. ${player.name} - Position: ${player.position.name} - Rating: ${player.overallRate.toStringAsFixed(2)}",
      );
    });

    _inputReader.waitForEnter("\nPress Enter to continue...");
  }
}
