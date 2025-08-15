import '../../utils/terminal_utils.dart';

abstract class OutputWriter {
  void write(String text);

  void writeLine(String text);

  void writeWithColor(String text, TerminalColor color);

  void writeLineWithColor(String text, TerminalColor color);

  void writeHeader(String header, {TerminalColor color = TerminalColor.CYAN});

  void writeBullet(String text, {TerminalColor color = TerminalColor.WHITE});

  void writeError(String error);

  void writeSuccess(String success);

  void writeWarning(String warning);
  void writeDivider({String symbol = '-', int count = 50});
}
