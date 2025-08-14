import '../../../domain/enums/strategy_enums.dart';
import '../../../domain/usecases/formation/get_formations_usecase.dart';
import '../../../domain/usecases/formation/get_recommended_formations_usecase.dart';
import '../../io/input/input_reader.dart';
import '../../io/output/output_writer.dart';
import '../ui_action.dart';
import 'formation_comparator.dart';
import 'formation_details_printer.dart';

class FormationUI {
  final GetFormationsUseCase _getFormations;
  final GetRecommendedFormationsUseCase _getRecommendedFormations;
  final InputReader _input;
  final OutputWriter _output;
  final FormationDetailsPrinter _detailsPrinter;
  final FormationComparator _comparator;

  late final List<UiAction> _actions;

  FormationUI({
    required GetFormationsUseCase getFormationsUseCase,
    required GetRecommendedFormationsUseCase getRecommendedFormationsUseCase,
    required InputReader input,
    required OutputWriter output,
    required FormationDetailsPrinter detailsPrinter,
    required FormationComparator comparator,
  })  : _getFormations = getFormationsUseCase,
        _getRecommendedFormations = getRecommendedFormationsUseCase,
        _input = input,
        _output = output,
        _detailsPrinter = detailsPrinter,
        _comparator = comparator {
    _initializeActions();
  }

  void _initializeActions() {
    _actions = [
      UiAction(
        name: '📋 View All Formations',
        action: _handleAllFormations,
      ),
      UiAction(
        name: '⭐ View Recommended Formations',
        action: _handleRecommendedFormations,
      ),
      UiAction(
        name: '🔄 Compare Two Formations',
        action: _handleComparison,
      ),
      UiAction(
        name: '🚪 Back to Main Menu',
        action: _exit,
      ),
    ];
  }

  void showMenu() {
    while (true) {
      _output.writeHeader('Football Formation System');
      _displayMenu(_actions);

      final choice = _input.readInt(
        'Select an option (1-${_actions.length}):',
        min: 1,
        max: _actions.length,
      );

      _actions[choice - 1].action();

      if (choice == _actions.length) {
        break;
      }
    }
  }

  void _handleAllFormations() {
    final formations = _getFormations.call();
    _output.writeHeader('All Available Formations');

    formations.asMap().forEach((index, formation) {
      _output.writeBullet('${index + 1}. ${formation.name}');
    });

    final choice = _input.readInt(
      'Select formation to view details (0 to go back)',
      min: 0,
      max: formations.length,
    );

    if (choice != 0) {
      _detailsPrinter.printDetails(formations[choice - 1]);
      _input.waitForEnter("");
    }
  }

  void _handleRecommendedFormations() {
    _output.writeHeader('Recommended Formations');

    final strategyChoice = _input.chooseFromMenu(
      'Select your preferred strategy:',
      StrategyType.values.map((e) => e.displayName).toList(),
    );

    final selectedStrategy = StrategyType.values[strategyChoice - 1];
    final formations = _getRecommendedFormations.call(selectedStrategy);

    formations.asMap().forEach((index, formation) {
      _output.writeBullet('${index + 1}. ${formation.name}');
    });

    final formationChoice = _input.readInt(
      'Select formation to view details (0 to go back)',
      min: 0,
      max: formations.length,
    );

    if (formationChoice != 0) {
      _detailsPrinter.printDetails(formations[formationChoice - 1]);
      _input.waitForEnter("");
    }
  }

  void _handleComparison() {
    final formations = _getFormations.call();
    _output.writeHeader('Compare Formations');

    // Select first formation
    _output.writeLine('First formation:');
    formations.asMap().forEach((index, formation) {
      _output.writeBullet('${index + 1}. ${formation.name}');
    });
    final firstChoice = _input.readInt(
      'Enter first formation number',
      min: 1,
      max: formations.length,
    );

    // Select second formation
    _output.writeLine('Second formation:');
    formations.asMap().forEach((index, formation) {
      _output.writeBullet('${index + 1}. ${formation.name}');
    });
    final secondChoice = _input.readInt(
      'Enter second formation number',
      min: 1,
      max: formations.length,
    );

    _comparator.compare(
      formations[firstChoice - 1],
      formations[secondChoice - 1],
    );

    _input.waitForEnter("");
  }

  void _exit() {
    _output.writeLine('Returning to main menu...');
  }

  void _displayMenu(List<UiAction> actions) {
    actions.asMap().forEach((index, action) {
      _output.writeLine('${index + 1}. ${action.name}');
    });
  }
}