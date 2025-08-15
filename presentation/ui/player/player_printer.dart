import '../../../domain/entities/player.dart';
import '../../io/output/output_writer.dart';
import '../../utils/terminal_utils.dart';

class PlayerPrinter {
  final OutputWriter output;

  PlayerPrinter(this.output);

  void printPlayer(Player player) {
    output.writeDivider();
    output.writeLine(
      StringCenter(
        '⚽️  Player Details  ⚽️',
      ).center(40).withStyle(TerminalColor.CYAN),
    );
    output.writeDivider();
    _printLine('🆔 Player Number', player.playerNumber.toString());
    _printLine('👤 Name', player.name);
    _printLine('📍 Position', player.position.name);
    _printLine('🌍 Nationality', player.nationality.name);
    _printLine('🎂 Age', player.age.toString());
    _printLine('🦶 Preferred Foot', player.preferredFoot.name);
    _printLine('💪 Power', player.power.toString());
    _printLine('⚡ Speed', player.speed.toString());
    _printLine('🏃 Stamina', player.stamina.toString());
    _printLine('🎯 Skill', player.skill.toString());
    _printLine('📏 Height (cm)', player.height.toStringAsFixed(1));
    _printLine('⚖️ Weight (kg)', player.weight.toStringAsFixed(1));
    _printLine('🩺 Health', _healthLevel(player.health));
    _printLine('🤕 Injured', player.isInjured ? 'Yes' : 'No');

    final teamName = player.team != null ? player.team!.name : 'Free Agent';
    _printLine('🏟️ Team', teamName);

    _printLine('⭐ Overall Rate', player.overallRate.toStringAsFixed(2));

    output.writeDivider();
  }

  void _printLine(String key, String value) {
    final coloredKey = key.padRight(16).withStyle(TerminalColor.YELLOW);
    final coloredValue = value.withStyle(TerminalColor.GREEN);
    output.writeLine('$coloredKey : $coloredValue');
  }

  String _healthLevel(int health) {
    if (health >= 90) return '🟢 Excellent';
    if (health >= 70) return '🟡 Good';
    if (health >= 50) return '🟠 Moderate';
    return '🔴 Poor';
  }
}

extension StringCenter on String {
  String center(int width) {
    final padSize = (width - length).clamp(0, width);
    final left = padSize ~/ 2;
    final right = padSize - left;
    return ' ' * left + this + ' ' * right;
  }
}
