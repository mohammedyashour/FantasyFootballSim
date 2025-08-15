import '../../io/input/console_input_reader.dart';
import '../../io/output/console_output_writer.dart';
import '../ui_action.dart';

class GameLauncher {
  final ConsoleInputReader input;
  final ConsoleOutputWriter output;

  GameLauncher(this.input, this.output);

  Future<void> start(List<UiAction> actions) async {
    while (true) {
      output.writeLine('\n⚽ Welcome to Football Simulator!');
      for (int i = 0; i < actions.length; i++) {
        output.writeLine('${i + 1}. ${actions[i].name}');
      }
      output.writeLine('0. ❌ Exit');

      final choice = input.readInt(
        '\n👉 Enter your choice: ',
        min: 0,
        max: actions.length,
      );

      if (choice == 0) {
        output.writeLine('\n👋 Exiting game...');
        break;
      }

      actions[choice - 1].action();
    }
  }
}
