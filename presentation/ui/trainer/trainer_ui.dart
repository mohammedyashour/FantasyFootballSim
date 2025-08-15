import '../../../domain/entities/trainer.dart';
import '../../../domain/repositories/trainer_repository.dart';
import '../../../domain/usecases/trainer/create_trainer_usecase.dart';
import '../../../domain/usecases/trainer/random_trainer_generator_usecase.dart';
import '../../../domain/usecases/trainer/select_trainer_usecase.dart';
import '../../io/input/console_input_reader.dart';
import '../../io/output/console_output_writer.dart';
import '../../utils/terminal_utils.dart';
import '../ui_action.dart';
import 'create_trainer_ui.dart';
import 'trainer_printer.dart';

class TrainerUi {
  final CreateTrainerUseCase _createTrainerUseCase;
  final RandomTrainerGeneratorUseCase _randomTrainerGeneratorUseCase;
  final SelectTrainerUseCase _selectTrainerUseCase;
  final TrainerRepository _trainerRepository;
  final ConsoleInputReader _inputReader;
  final ConsoleOutputWriter _outputWriter;
  final TrainerPrinter _trainerPrinter;

  late final List<UiAction> _actions;

  TrainerUi({
    required CreateTrainerUseCase createTrainerUseCase,
    required RandomTrainerGeneratorUseCase randomTrainerGeneratorUseCase,
    required SelectTrainerUseCase selectTrainerUseCase,
    required TrainerRepository trainerRepository,
    required ConsoleInputReader inputReader,
    required ConsoleOutputWriter outputWriter,
  }) : _createTrainerUseCase = createTrainerUseCase,
       _randomTrainerGeneratorUseCase = randomTrainerGeneratorUseCase,
       _selectTrainerUseCase = selectTrainerUseCase,
       _trainerRepository = trainerRepository,
       _inputReader = inputReader,
       _outputWriter = outputWriter,
       _trainerPrinter = TrainerPrinter(outputWriter) {
    _initializeActions();
  }

  void _initializeActions() {
    _actions = [
      UiAction(
        name: '👟 Create New Trainer'.withStyle(TerminalColor.GREEN),
        action: _createTrainer,
      ),
      UiAction(
        name: '📋 View All Trainers'.withStyle(TerminalColor.CYAN),
        action: _viewAllTrainers,
      ),
      UiAction(
        name: '🔍 View Trainer Details'.withStyle(TerminalColor.MAGENTA),
        action: _viewTrainerDetails,
      ),
      UiAction(
        name: '🎲 Create Random Trainer'.withStyle(TerminalColor.YELLOW),
        action: _createRandomTrainer,
      ),
      UiAction(name: '🚪 Exit'.withStyle(TerminalColor.RED), action: _exit),
    ];
  }

  void showMenu() {
    while (true) {
      _outputWriter.writeHeader('Trainer Management System');

      for (int i = 0; i < _actions.length; i++) {
        _outputWriter.writeLine('${i + 1}. ${_actions[i].name}');
      }

      final choice = _getUserChoice();
      if (choice == null) continue;

      if (choice == _actions.length) {
        _actions.last.action();
        break;
      }

      _actions[choice - 1].action();
    }
  }

  int? _getUserChoice() {
    final input = _inputReader.readString(
      'Enter your choice (1-${_actions.length}): ',
    );
    final choice = int.tryParse(input);

    if (choice == null || choice < 1 || choice > _actions.length) {
      _outputWriter.writeError(
        'Invalid choice. Please enter a number between 1 and ${_actions.length}.',
      );
      return null;
    }

    return choice;
  }

  void _createTrainer() {
    final ui = CreateTrainerUI(
      _createTrainerUseCase,
      _inputReader,
      _outputWriter,
      _trainerRepository,
    );
    ui.start();
  }

  void _viewAllTrainers() {
    final trainers = _selectTrainerUseCase.getAllTrainers();

    _outputWriter.writeHeader('📋 All Trainers (${trainers.length})');

    if (trainers.isEmpty) {
      _outputWriter.write('No trainers available.');
    } else {
      trainers.forEach((trainer) {
        _outputWriter.writeLine('─' * 40);
        TrainerPrinter(_outputWriter).printDetails(trainer);
      });
      _outputWriter.writeLine('─' * 40);
    }

    _inputReader.waitForEnter();
  }

  void _viewTrainerDetails() {
    _outputWriter.writeHeader('🔍 Trainer Details');
    try {
      final trainers = _trainerRepository.getAll();
      if (trainers.isEmpty) {
        _outputWriter.writeError('No trainers available to view.');
        return;
      }

      for (int i = 0; i < trainers.length; i++) {
        _outputWriter.writeLine('${i + 1}. ${trainers[i].name}');
      }

      final choice = _inputReader.readString(
        'Select trainer (1-${trainers.length}): ',
      );
      final index = int.tryParse(choice);

      if (index == null || index < 1 || index > trainers.length) {
        _outputWriter.writeError('Invalid selection.');
        return;
      }

      _trainerPrinter.printDetails(trainers[index - 1]);
    } catch (e) {
      _outputWriter.writeError('Error viewing trainer: $e');
    }
    _inputReader.waitForEnter();
  }

  Trainer? _createRandomTrainer() {
    try {
      _outputWriter.writeHeader('🎲 Create Random Trainer');

      final trainer = _randomTrainerGeneratorUseCase();

      _outputWriter.writeSuccess('✅ Random trainer created successfully!');
      _outputWriter.writeLine('----------------------------------------');
      TrainerPrinter(_outputWriter).printDetails(trainer);
      _outputWriter.writeLine('----------------------------------------');

      final useTrainer = _inputReader.readBoolean(
        'Would you like to use this trainer for a team? (y/n)',
      );
      if (useTrainer) {
        return trainer;
      }

      _outputWriter.write(
        'Trainer "${trainer.name}" was created but not assigned to any team.',
      );
    } catch (e) {
      _outputWriter.writeError(
        '❌ Failed to create random trainer: ${e.toString()}',
      );
      _outputWriter.writeLine(
        'Please try again or contact support if the problem persists.',
      );
    }

    _inputReader.waitForEnter();
    return null;
  }

  void _exit() {
    _outputWriter.writeLine('\nExiting Trainer Management...');
  }
}
