import 'dart:io';

import '../../utils/terminal_utils.dart';
import 'output_writer.dart';

class ConsoleOutputWriter implements OutputWriter {
  @override
  void write(String text) => stdout.write(text);

  @override
  void writeLine(String text) => print(text);

  @override
  void writeWithColor(String text, TerminalColor color) {
    stdout.write(color.wrap(text));
  }

  @override
  void writeLineWithColor(String text, TerminalColor color) {
    print(color.wrap(text));
  }

  @override
  void writeHeader(String header, {TerminalColor color = TerminalColor.CYAN}) {
    final line = '=' * (header.length + 4);
    writeLineWithColor(line, color);
    writeLineWithColor('  $header  ', color);
    writeLineWithColor(line, color);
  }

  @override
  void writeBullet(String text, {TerminalColor color = TerminalColor.WHITE}) {
    writeLineWithColor(' • $text', color);
  }

  @override
  void writeError(String error) {
    writeLineWithColor('⛔ $error', TerminalColor.RED);
  }

  @override
  void writeSuccess(String success) {
    writeLineWithColor('✅ $success', TerminalColor.GREEN);
  }

  @override
  void writeWarning(String warning) {
    writeLineWithColor('⚠️ $warning', TerminalColor.YELLOW);
  }

  void writeSubHeader(String text) {
    final underline = '-' * text.length;
    writeLineWithColor('\n$text', TerminalColor.CYAN);
    writeLineWithColor(underline, TerminalColor.CYAN);
  }

  void writeBulletPoint(
    String text, {
    TerminalColor color = TerminalColor.WHITE,
  }) {
    writeLineWithColor(' • $text', color);
  }

  void writeDivider({String symbol = '-', int count = 50}) {
    writeLine(symbol * count);
  }
}
