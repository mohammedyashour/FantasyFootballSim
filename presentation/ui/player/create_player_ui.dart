import '../../../domain/entities/player.dart';
import '../../../domain/enums/nationality.dart';
import '../../../domain/enums/positions.dart';
import '../../../domain/repositories/player_repository.dart';
import '../../../domain/usecases/player/CreatePlayerUseCase.dart';
import '../../io/input/console_input_reader.dart';
import '../../io/output/output_writer.dart';
import '../Nationality/nationality_printer.dart';
import '../Positions/position_printer.dart';
import 'player_printer.dart';

class CreatePlayerUI {
  final CreatePlayerUseCase createPlayerUseCase;
  final ConsoleInputReader inputReader;
  final OutputWriter outputWriter;
  final PlayerRepository playerRepository;

  CreatePlayerUI(
    this.createPlayerUseCase,
    this.inputReader,
    this.outputWriter,
    this.playerRepository,
  );

  Player start() {
    outputWriter.writeHeader('🎮 Add New Player');
    outputWriter.writeLine('Please enter the following details:');

    String id = inputReader.readString("🆔 ID:");
    String name = inputReader.readString("👤 Name:");

    outputWriter.writeLine("📍 Choose Position (e.g., ST, CM, GK):");
    Position position = _readPosition();

    int power = inputReader.readInt("💪 Power (0-100):", min: 0, max: 100);
    int speed = inputReader.readInt("⚡ Speed (0-100):", min: 0, max: 100);
    int stamina = inputReader.readInt("🏃 Stamina (0-100):", min: 0, max: 100);
    int skill = inputReader.readInt("🎯 Skill (0-100):", min: 0, max: 100);

    Nationality nationality = _readNationality();
    int age = inputReader.readInt("🎂 Age:", min: 10, max: 60);

    outputWriter.writeLine("🦶 Preferred Foot (right(r), left(l), both(b)):");
    PreferredFoot preferredFoot = _readFoot();

    double height = inputReader.readDouble("📏 Height (e.g., 180.5):");
    double weight = inputReader.readDouble("⚖️ Weight (e.g., 75.0):");

    final player = createPlayerUseCase.call(
      id: id,
      name: name,
      position: position,
      power: power,
      speed: speed,
      stamina: stamina,
      skill: skill,
      nationality: nationality,
      age: age,
      preferredFoot: preferredFoot,
      height: height,
      weight: weight,
    );
    outputWriter.writeSuccess("Player created and saved successfully!");
    final printer = PlayerPrinter(outputWriter);
    printer.printPlayer(player);
    return player;
  }

  Position _readPosition() {
    PositionPrinter.printPositionsGridWithNumbers(outputWriter);
    while (true) {
      final selection = inputReader.readString(
        "Enter position number or name (e.g., ST, CM, GK): ",
      );

      final asInt = int.tryParse(selection);
      if (asInt != null && asInt >= 1 && asInt <= Position.values.length) {
        return Position.values[asInt - 1];
      }
      try {
        return Position.values.firstWhere(
          (n) => n.name.toLowerCase() == selection.toLowerCase(),
        );
      } catch (_) {
        outputWriter.writeError(
          "Invalid position. Please choose a valid option.",
        );
      }
    }
  }

  PreferredFoot _readFoot() {
    while (true) {
      final input = inputReader.readString("Enter foot:");
      switch (input.toLowerCase()) {
        case 'right':
          return PreferredFoot.right;
        case 'left':
          return PreferredFoot.left;
        case 'both':
          return PreferredFoot.both;
        case 'r':
          return PreferredFoot.right;
        case 'l':
          return PreferredFoot.left;
        case 'b':
          return PreferredFoot.both;
        default:
          outputWriter.writeWarning(
            "Invalid option. Type right(r) / left(l) / both(b).",
          );
      }
    }
  }

  Nationality _readNationality() {
    outputWriter.writeLine("\n🌍 Choose Nationality:");
    NationalityPrinter.printNationalitiesGridWithNumbers(outputWriter);
    while (true) {
      final selection = inputReader.readString(
        "Enter nationality number or name:",
      );
      final asInt = int.tryParse(selection);
      if (asInt != null && asInt >= 1 && asInt <= Nationality.values.length) {
        return Nationality.values[asInt - 1];
      }
      try {
        return Nationality.values.firstWhere(
          (n) => n.name.toLowerCase() == selection.toLowerCase(),
        );
      } catch (_) {
        outputWriter.writeError(
          "Invalid nationality. Please choose a valid option.",
        );
      }
    }
  }
}
