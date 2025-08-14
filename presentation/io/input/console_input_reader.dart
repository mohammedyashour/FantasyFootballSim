import 'dart:io';

import '../../utils/terminal_utils.dart';
import '../output/output_writer.dart';
import 'input_reader.dart';

class ConsoleInputReader implements InputReader {
  final OutputWriter _output;

  ConsoleInputReader(this._output);

  @override
  String readString(String prompt, {bool required = true}) {
    while (true) {
      _printPrompt(prompt, required: required);
      final input = stdin.readLineSync()?.trim() ?? '';

      if (!required && input.isEmpty) return '';
      if (input.isNotEmpty) return input;

      _printError('Input cannot be empty');
    }
  }

  @override
  int readInt(
    String prompt, {
    int? min,
    int? max,
    int? defaultValue,
    bool required = true,
  }) {
    while (true) {
      _printPrompt(
        '$prompt${defaultValue != null ? ' [$defaultValue]' : ''}',
        required: required,
      );

      final input = stdin.readLineSync()?.trim();

      if (input == null || input.isEmpty) {
        if (defaultValue != null) return defaultValue;
        if (!required) return 0;
        _printError('Please enter a valid number');
        continue;
      }

      try {
        final value = int.parse(input);

        if (min != null && value < min) {
          _printError('Value must be at least $min');
          continue;
        }

        if (max != null && value > max) {
          _printError('Value must be at most $max');
          continue;
        }

        return value;
      } catch (e) {
        _printError('Invalid number format');
      }
    }
  }

  @override
  double readDouble(
    String prompt, {
    double? min,
    double? max,
    double? defaultValue,
    bool required = true,
  }) {
    while (true) {
      _printPrompt(
        '$prompt${defaultValue != null ? ' [$defaultValue]' : ''}',
        required: required,
      );

      final input = stdin.readLineSync()?.trim();

      if (input == null || input.isEmpty) {
        if (defaultValue != null) return defaultValue;
        if (!required) return 0.0;
        _printError('Please enter a valid decimal number');
        continue;
      }

      try {
        final value = double.parse(input);

        if (min != null && value < min) {
          _printError('Value must be at least $min');
          continue;
        }

        if (max != null && value > max) {
          _printError('Value must be at most $max');
          continue;
        }

        return value;
      } catch (e) {
        _printError('Invalid decimal format');
      }
    }
  }

  @override
  bool readBoolean(String prompt, {bool defaultValue = false}) {
    while (true) {
      _printBoolPrompt(prompt, defaultValue: defaultValue);
      final input = stdin.readLineSync()?.trim().toLowerCase();

      if (input == null || input.isEmpty) return defaultValue;
      if (input == 'y' || input == 'yes') return true;
      if (input == 'n' || input == 'no') return false;

      _printError('Please enter \'y\' or \'n\'');
    }
  }

  @override
  void waitForEnter([String? message]) {
    if (message != null) {
      _output.writeWithColor(
          '$message (Press Enter to continue) ',
          TerminalColor.CYAN);
    } else {
      _output.writeWithColor(
        'Press Enter to continue... ',
        TerminalColor.CYAN,
      );
    }

    stdin.readLineSync();
  }

  @override
  int chooseFromMenu(String header, List<String> options) {
    _output.writeHeader(header);

    for (int i = 0; i < options.length; i++) {
      _output.writeBullet('${i + 1}. ${options[i]}');
    }

    return readInt(
      'Enter your choice (1-${options.length})',
      min: 1,
      max: options.length,
    );
  }

  void _printError(String message) {
    _output.writeLineWithColor('❌ $message', TerminalColor.RED);
  }

  void _printPrompt(String prompt, {bool required = true}) {
    _output.writeWithColor(
      '$prompt${required ? ' *' : ''}: ',
      TerminalColor.BLUE,
    );
  }

  void _printBoolPrompt(String prompt, {bool defaultValue = false}) {
    _output.writeWithColor(
      '$prompt (y/n) [${defaultValue ? 'Y' : 'n'}]: ',
      TerminalColor.MAGENTA,
    );
  }
}
