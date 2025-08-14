import 'dart:io';

import '../../../domain/entities/referee.dart';
import '../../../domain/usecases/referee/create_referee_usecase.dart';
import '../../../domain/usecases/referee/get_all_referees_usecase.dart';
import '../../../domain/usecases/referee/get_referee_by_id_usecase.dart';
import '../../../domain/usecases/referee/random_referee_generator_usecase.dart';
import '../ui_action.dart';
import 'referee_printer.dart';

class RefereeUI {
  final CreateRefereeUseCase _createReferee;
  final GetAllRefereesUseCase _getAllReferees;
  final GetRefereeByIdUseCase _getRefereeById;
  final RandomRefereeGeneratorUseCase _randomRefereeGeneratorUseCase;

  late final List<UiAction> _actions;

  RefereeUI(
    this._createReferee,
    this._getAllReferees,
    this._getRefereeById,
    this._randomRefereeGeneratorUseCase,
  ) {
    _actions = [
      UiAction(name: '🧑‍⚖️ Create New Referee', action: _createRefereeHandler),
      UiAction(name: '👥 View All Referees', action: _viewAllReferees),
      UiAction(name: '🔍 View Referee Details', action: _viewRefereeDetails),
      UiAction(name: '🎲 Create Random Referee', action: _createRandomReferee),
      UiAction(name: '🚪 Exit', action: _exit),
    ];
  }

  void showMenu() {
    while (true) {
      print('\nReferee Management System:');
      for (int i = 0; i < _actions.length; i++) {
        print('${i + 1}. ${_actions[i].name}');
      }

      final choice = _getUserInput('Enter your choice: ');
      final index = int.tryParse(choice);

      if (index == null || index < 1 || index > _actions.length) {
        print('Invalid choice, please try again.');
        continue;
      }

      final action = _actions[index - 1].action;
      action();

      if (_actions[index - 1].name == '🚪 Exit') {
        break;
      }
    }
  }

  void _createRefereeHandler() {
    print('\n--- Create New Referee ---');
    final name = _getUserInput('Enter referee name: ');
    final experience =
        int.tryParse(_getUserInput('Enter experience years: ')) ?? 0;
    final strictness =
        double.tryParse(_getUserInput('Enter strictness (0-1): ')) ?? 0.0;

    final referee = _createReferee.call(
      name: name,
      experienceYears: experience,
      strictness: strictness,
    );

    print('\nReferee created successfully!');
    RefereePrinter.printReferee(referee);
  }

  void _viewAllReferees() {
    print('\n--- All Referees ---');
    final referees = _getAllReferees.call();
    RefereePrinter.printReferees(referees);
  }

  void _viewRefereeDetails() {
    final id = _getUserInput('Enter referee ID: ');
    final referee = _getRefereeById.call(id);

    if (referee != null) {
      RefereePrinter.printReferee(referee);
    } else {
      print('Referee not found');
    }
  }

  void _createRandomReferee() {
    print('\n--- Create Random Referee ---');
    final referee = _randomRefereeGeneratorUseCase();
    print('\nRandom referee created successfully!');
    RefereePrinter.printReferee(referee);
  }

  void _exit() {
    print('Exiting Referee Management...');
  }

  String _getUserInput(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync()?.trim() ?? '';
  }
  List<Referee> getAllReferees() {
    return _getAllReferees.call();
  }
}
