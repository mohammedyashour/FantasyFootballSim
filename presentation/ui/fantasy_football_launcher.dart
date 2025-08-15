import 'dart:io';

import '../io/input/console_input_reader.dart';
import '../io/output/console_output_writer.dart';
import '../utils/terminal_utils.dart';
import 'ui_action.dart';

class FantasyFootballLauncher {
  final ConsoleOutputWriter output;
  final ConsoleInputReader input;

  final void Function() onRefereeUi;
  final void Function() onStadiumUi;
  final void Function() onMatchUi;
  final void Function() onPlayerManagementUi;
  final void Function() onTrainerManagementUi;
  final void Function() onTeamManagementUi;
  final void Function() onFormationManagementUi;

  FantasyFootballLauncher({
    required this.output,
    required this.input,
    required this.onRefereeUi,
    required this.onStadiumUi,
    required this.onMatchUi,
    required this.onPlayerManagementUi,
    required this.onTeamManagementUi,
    required this.onTrainerManagementUi,
    required this.onFormationManagementUi,
  });

  void start() {
    final actions = <UiAction>[
      UiAction(name: "⚽ Simulate Match", action: onMatchUi),
      UiAction(name: "👥 Team Management", action: onTeamManagementUi),
      UiAction(name: "👟 Player Management", action: onPlayerManagementUi),
      UiAction(
        name: "🗺️ Formation and Strategy Management",
        action: onFormationManagementUi,
      ),
      UiAction(name: "👔 Trainer Management", action: onTrainerManagementUi),
      UiAction(name: "🏟️ Stadium Management", action: onStadiumUi),
      UiAction(name: "🧑‍⚖️ Manage Referees", action: onRefereeUi),
      UiAction(name: "🚪 Exit", action: _exitApp),
    ];

    while (true) {
      output.writeLine('='.padRight(35, '=').withStyle(TerminalColor.BLUE));
      output.writeLine(
        "\n🏈 Welcome to Fantasy Football Sim! 🎮\n".withStyle(
          TerminalColor.GREEN,
        ),
      );
      output.writeLine('='.padRight(35, '=').withStyle(TerminalColor.BLUE));

      for (var i = 0; i < actions.length; i++) {
        final num = (i + 1).toString().padLeft(2, '0');
        output.writeLine(
          "$num. ${actions[i].name}".withStyle(
            TerminalColor.values[i % TerminalColor.values.length],
          ),
        );
      }

      try {
        final choice = input.readInt(
          "\n👉 Enter your choice (1 to ${actions.length}): ".withStyle(
            TerminalColor.YELLOW,
          ),
          min: 0,
          max: actions.length,
        );

        if (choice == 0) {
          output.writeLine(
            "\n👋 Exiting Fantasy Football Sim... See you!".withStyle(
              TerminalColor.GREEN,
            ),
          );
          return;
        }

        final selected = actions[choice - 1];
        output.writeLine(
          "\n✨ You selected: ${selected.name}".withStyle(TerminalColor.CYAN),
        );
        selected.action();
      } catch (e) {
        output.writeLine("⚠️ ${e.toString()}".withStyle(TerminalColor.RED));
      }

      input.waitForEnter("\n🔄 Press Enter to return to menu...");
    }
  }

  void _exitApp() {
    output.writeLine(
      "\n👋 Exiting Fantasy Football Sim... Goodbye!".withStyle(
        TerminalColor.GREEN,
      ),
    );
    exit(0);
  }
}
