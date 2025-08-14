import '../ui/ui_action.dart';
import 'terminal_utils.dart';

class MenuPrinter {
  void display(List<UiAction> actions,void Function(String) outputWriter) {
    for (var i = 0; i < actions.length; i++) {
      final num = (i + 1).toString().padLeft(2, '0');
      outputWriter(
        "$num. ${actions[i].name}".withStyle(
          TerminalColor.values[i % TerminalColor.values.length],
        ),
      );
    }
  }
}
