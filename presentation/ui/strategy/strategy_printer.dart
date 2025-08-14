import '../../../domain/entities/strategy.dart';
import '../../../domain/enums/strategy_enums.dart';
import '../../../domain/usecases/get_all_strategies_usecase.dart';
import '../../../domain/usecases/get_strategy_matrix_usecase.dart';
import '../../io/input/input_reader.dart';
import '../../io/output/output_writer.dart';
import '../../utils/terminal_utils.dart';

class StrategyPrinter {
  final GetAllStrategiesUseCase _getAllStrategies;
  final GetStrategyMatrixUseCase _getStrategyMatrix;
  final OutputWriter _output;
  final InputReader _input;

  StrategyPrinter(
    this._getAllStrategies,
    this._getStrategyMatrix,
    this._output,
    this._input,
  );

  void showInteractiveMenu() {
    while (true) {
      _output.writeHeader('Football Strategy System');

      final strategies = _getAllStrategies.call();
      final strategyList = strategies.values.toList();

      _output.writeLine('Available Options:');
      for (int i = 0; i < strategyList.length; i++) {
        _output.writeBullet('${i + 1}. View ${strategyList[i].type} Strategy');
      }
      _output.writeBullet('${strategyList.length + 1}. Show Strategy Matrix');
      _output.writeBullet('0. Exit');

      final choice = _input.readInt(
        'Select an option',
        min: 0,
        max: strategyList.length + 1,
      );

      if (choice == 0) {
        _output.writeSuccess('Goodbye!');
        break;
      } else if (choice == strategyList.length + 1) {
        printStrategyMatrix();
      } else {
        _printStrategyDetails(strategyList[choice - 1]);
        _printMatchupAnalysis(strategyList[choice - 1], strategies);
      }

      _input.waitForEnter('Press Enter to continue');
    }
  }

  void printStrategyMatrix() {
    final matrix = _getStrategyMatrix.call();
    final strategies = matrix.keys.toList();

    _output.writeHeader('Strategy Interaction Matrix');
    _output.writeLine(
      'Positive values favor the attacker, negative favor defender',
    );

    _output.write('Attacker \\ Defender | ');
    for (final strategy in strategies) {
      _output.writeWithColor(
        _shortName(strategy).padLeft(5).padRight(7),
        TerminalColor.CYAN,
      );
    }
    _output.writeLine('');

    // Print matrix rows
    for (final attacker in strategies) {
      _output.writeWithColor(
        _shortName(attacker).padRight(18),
        TerminalColor.CYAN,
      );
      _output.write('| ');

      for (final defender in strategies) {
        final bonus = matrix[attacker]![defender]!;
        _output.writeWithColor(
          bonus.toString().padLeft(5),
          _getBonusColor(bonus),
        );
        _output.write('  ');
      }
      _output.writeLine('');
    }
  }

  void _printStrategyDetails(Strategy strategy) {
    _output.writeHeader(strategy.type.toString().split('.').last);
    _output.writeBullet('Description: ${strategy.description}');
    _output.writeBullet(
      'Base Bonus: ${strategy.baseBonus}',
      color: _getBonusColor(strategy.baseBonus),
    );
  }

  void _printMatchupAnalysis(
    Strategy strategy,
    Map<StrategyType, Strategy> allStrategies,
  ) {
    final matrix = _getStrategyMatrix.call();
    final currentType = strategy.type;

    _output.writeHeader('Matchup Analysis');

    allStrategies.forEach((type, s) {
      if (type != currentType) {
        final bonus = matrix[currentType]![type]!;
        final result = bonus > 0 ? 'ADVANTAGE' : 'DISADVANTAGE';
        final color = bonus > 0 ? TerminalColor.GREEN : TerminalColor.RED;

        _output.writeBullet(
          'Against ${_formatStrategyName(type)}: ${bonus.toString().padLeft(3)} ($result)',
          color: color,
        );
      }
    });
  }

  TerminalColor _getBonusColor(int bonus) {
    if (bonus > 10) return TerminalColor.GREEN;
    if (bonus > 5) return TerminalColor.LIGHT_GREEN;
    if (bonus > 0) return TerminalColor.YELLOW;
    if (bonus == 0) return TerminalColor.GREY;
    return TerminalColor.RED;
  }

  String _shortName(StrategyType type) {
    final name = type.toString().split('.').last;
    return name.substring(0, name.length > 4 ? 4 : name.length).toUpperCase();
  }

  String _formatStrategyName(StrategyType type) {
    return type.toString().split('.').last.padRight(15);
  }
}
