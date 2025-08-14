import '../../../domain/entities/stadium.dart';
import '../../../domain/usecases/stadium/create_stadium_usecase.dart';
import '../../../domain/usecases/stadium/get_all_stadiums_usecase.dart';
import '../../../domain/usecases/stadium/get_stadium_by_id_usecase.dart';
import '../../../domain/usecases/stadium/random_stadium_generator_usecase.dart';
import '../../../domain/enums/team_city.dart';
import '../../../domain/enums/turf_type.dart';
import '../../../domain/enums/Weather.dart';
import '../../io/input/console_input_reader.dart';
import '../../io/output/output_writer.dart';
import '../../utils/menu_printer.dart';
import '../ui_action.dart';
import 'stadium_printer.dart';

class StadiumUI {
  final CreateStadiumUseCase _createStadium;
  final GetAllStadiumsUseCase _getAllStadiums;
  final GetStadiumByIdUseCase _getStadiumById;
  final RandomStadiumGeneratorUseCase _randomStadiumGenerator;
  final ConsoleInputReader _input;
  final OutputWriter _output;
  final StadiumPrinter _stadiumPrinter;
  final menuPrinter = MenuPrinter();

  late final List<UiAction> _actions;

  StadiumUI({
    required CreateStadiumUseCase createStadium,
    required GetAllStadiumsUseCase getAllStadiums,
    required GetStadiumByIdUseCase getStadiumById,
    required RandomStadiumGeneratorUseCase randomStadiumGenerator,
    required ConsoleInputReader input,
    required OutputWriter output,
  })
      : _createStadium = createStadium,
        _getAllStadiums = getAllStadiums,
        _getStadiumById = getStadiumById,
        _randomStadiumGenerator = randomStadiumGenerator,
        _input = input,
        _output = output,
        _stadiumPrinter = StadiumPrinter(output) {
    _initializeActions();
  }

  void _initializeActions() {
    _actions = [
      UiAction(
        name: '🏟️ Create Stadium',
        action: _createStadiumHandler,
      ),
      UiAction(
        name: '📋 List All Stadiums',
        action: _listAllStadiums,
      ),
      UiAction(
        name: '🔍 Get Stadium By Name',
        action: _getStadiumByName,
      ),
      UiAction(
        name: '🎲 Create Random Stadium',
        action: _createRandomStadium,
      ),
      UiAction(
        name: '🚪 Back',
        action: _exit,
      ),
    ];
  }

  void showMenu() {
    while (true) {
      _output.writeHeader('Stadium Management');
      menuPrinter.display(_actions, (text) => _output.writeLine(text));

      final choice = _input.readInt(
        'Enter your choice (1-${_actions.length}):',
        min: 1,
        max: _actions.length,
      );

      _actions[choice - 1].action();

      if (choice == _actions.length) {
        break;
      }
    }
  }

  void _createStadiumHandler() {
    _output.writeHeader('🏟️ Create New Stadium');

    final name = _input.readString('Name:');

    final cityIndex = _input.chooseFromMenu(
      'Select City:',
      TeamCity.values.map((e) => e.displayName).toList(),
    );
    final location = TeamCity.values[cityIndex - 1];

    final capacity = _input.readInt('Capacity:', required: true);
    final attendance = _input.readInt(
        'Attendance (optional):', required: false, max: capacity, min: 0);
    final altitude = _input.readDouble(
        'Altitude meters (optional):', required: false);

    final turfIndex = _input.chooseFromMenu(
      'Select Turf Type:',
      TurfType.values.map((e) => e.displayName).toList(),
    );
    final turfType = TurfType.values[turfIndex - 1];

    final weatherIndex = _input.chooseFromMenu(
      'Select Weather (optional):',
      WeatherCondition.values.map((e) => e.name).toList(),
    );
    final weather = WeatherCondition.values[weatherIndex - 1];

    final stadium = _createStadium(
      name: name,
      location: location,
      capacity: capacity,
      attendance: attendance,
      altitude: altitude,
      turfType: turfType,
      weather: weather,
    );

    _output.writeSuccess(' Stadium created successfully!');
    _stadiumPrinter.printDetails(stadium);
  }

  void _listAllStadiums() {
    _output.writeHeader('📋 All Stadiums');
    final stadiums = _getAllStadiums();
    _stadiumPrinter.printList(stadiums);
    _input.waitForEnter();
  }

  void _getStadiumByName() {
    _output.writeHeader('🔍 Find Stadium');
    final name = _input.readString('Enter stadium name:');
    final stadium = _getStadiumById(name);

    if (stadium == null) {
      _output.writeError('Stadium not found');
    } else {
      _stadiumPrinter.printDetails(stadium);
    }
    _input.waitForEnter();
  }

  void _createRandomStadium() {
    _output.writeHeader('🎲 Random Stadium');
    final stadium = _randomStadiumGenerator();
    _output.writeSuccess('Random stadium created!');
    _stadiumPrinter.printDetails(stadium);
    _input.waitForEnter();
  }

  void _exit() {
    _output.writeLine('Returning to previous menu...');
  }


  List<Stadium> getAllStadiums() {
    return _getAllStadiums();
  }
}