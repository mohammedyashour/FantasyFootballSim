import 'dart:io';

import '../../utils/terminal_utils.dart';
import '../ui_action.dart';

class MainMenuLauncher {
  final List<UiAction> uiActions;

  MainMenuLauncher(this.uiActions);

  start() {
    while (true) {
      _printHeader();

      for (var i = 0; i < uiActions.length; i++) {
        print(
          '${(i + 1).toString().padLeft(2, '0')}. ${uiActions[i].name}'
              .withStyle(_randomColor()),
        );
      }

      stdout.write(
        '\n👉 Enter your choice (0 to Exit): '.withStyle(TerminalColor.YELLOW),
      );
      final input = stdin.readLineSync()?.trim();
      final choice = int.tryParse(input ?? '');

      if (choice == null || choice < 0 || choice > uiActions.length) {
        print(
          '⚠️ Invalid input. Please try again.'.withStyle(TerminalColor.RED),
        );
        continue;
      }

      if (choice == 0) {
        print('\n👋 Exiting... Goodbye!'.withStyle(TerminalColor.GREEN));
        return;
      }

      final action = uiActions[choice - 1];
      print('\n✨ You selected: ${action.name}'.withStyle(TerminalColor.CYAN));
      action.action();

      stdout.write('\n🔄 Press Enter to return to the menu...');
      stdin.readLineSync();
    }
  }

  void _printHeader() {
    stdout.write('\x1B[2J\x1B[0;0H');
    print('''
===================================
⚽  ${'FOOTBALL SIMULATOR 2024'.withStyle(TerminalColor.GREEN)}
===================================
''');
  }

  TerminalColor _randomColor() {
    final colors =
        TerminalColor.values.where((c) => c != TerminalColor.RESET).toList();
    colors.shuffle();
    return colors.first;
  }
}
