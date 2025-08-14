enum TerminalColor {
  RED('\x1B[31m'),
  GREEN('\x1B[32m'),
  YELLOW('\x1B[33m'),
  BLUE('\x1B[34m'),
  MAGENTA('\x1B[35m'),
  CYAN('\x1B[36m'),
  WHITE('\x1B[37m'),
  LIGHT_RED('\x1B[91m'),
  LIGHT_GREEN('\x1B[92m'),
  BLACK('\x1B[30m'),
  LIGHT_YELLOW('\x1B[93m'),
  LIGHT_BLUE('\x1B[94m'),
  LIGHT_MAGENTA('\x1B[95m'),
  LIGHT_CYAN('\x1B[96m'),
  LIGHT_WHITE('\x1B[97m'),
  GREY('\x1B[90m'),
  RESET('\x1B[0m');

  final String code;

  const TerminalColor(this.code);

  String wrap(String text) => '$code$text${TerminalColor.RESET.code}';
}

extension StringStyle on String {
  String withStyle(TerminalColor color) => color.wrap(this);

  String center(int width) {
    final padSize = (width - length).clamp(0, width);
    final left = padSize ~/ 2;
    final right = padSize - left;
    return ' ' * left + this + ' ' * right;
  }

  String removeStyle() {
    final ansiEscape = RegExp(r'\x1B\[[;?\d]*m');
    return replaceAll(ansiEscape, '');
  }
}

void printTable(List<String> headers, List<List<dynamic>> rows) {
  const keyCol = 'Key';
  const valueCol = 'Value';

  final keyWidth = [
    keyCol,
    ...headers,
  ].map((e) => e.length).reduce((a, b) => a > b ? a : b);
  final valueWidth = [
    valueCol.length,
    ...rows.expand((row) => row).map((e) => e.toString().length),
  ].reduce((a, b) => a > b ? a : b);

  final topBorder = '╔${'═' * (keyWidth + 2)}╦${'═' * (valueWidth + 2)}╗';
  final midBorder = '╠${'═' * (keyWidth + 2)}╬${'═' * (valueWidth + 2)}╣';
  final bottomBorder = '╚${'═' * (keyWidth + 2)}╩${'═' * (valueWidth + 2)}╝';

  print(topBorder.withStyle(TerminalColor.MAGENTA));
  print(
    '║ ${keyCol.padRight(keyWidth)} ║ ${valueCol.padRight(valueWidth)} ║'
        .withStyle(TerminalColor.CYAN),
  );
  print(midBorder.withStyle(TerminalColor.MAGENTA));

  for (var i = 0; i < rows.length; i++) {
    final row = rows[i];
    for (var j = 0; j < headers.length; j++) {
      final valueStr = j < row.length ? row[j].toString() : '-';
      print(
        '║ ${headers[j].padRight(keyWidth)} ║ ${valueStr.padRight(valueWidth)} ║'
            .withStyle(TerminalColor.YELLOW),
      );
    }
    if (i != rows.length - 1) print(midBorder.withStyle(TerminalColor.MAGENTA));
  }

  print(bottomBorder.withStyle(TerminalColor.MAGENTA));
}
