import '../../../domain/repositories/trainer_repository.dart';
import '../../../domain/enums/nationality.dart';
import '../../../domain/entities/trainer.dart';
import '../../../domain/usecases/trainer/create_trainer_usecase.dart';
import '../../io/input/console_input_reader.dart';
import '../../io/output/console_output_writer.dart';
import '../Nationality/nationality_printer.dart';
import 'trainer_printer.dart';

class CreateTrainerUI {
  final CreateTrainerUseCase createTrainerUseCase;
  final ConsoleInputReader reader;
  final ConsoleOutputWriter writer;
  final TrainerRepository? trainerRepository;

  CreateTrainerUI(
    this.createTrainerUseCase,
    this.reader,
    this.writer,
    this.trainerRepository,
  );

  Trainer start() {
    writer.writeSubHeader("👔 Add New Trainer");

    final name = reader.readString("👤 Trainer Name:");
    final age = reader.readInt("🎂 Age:", min: 18, max: 70);
    Nationality nationality = _readNationality();
    final experience = reader.readInt(
      "📈 Experience Level (0-100):",
      min: 0,
      max: 100,
    );

    final trainer = createTrainerUseCase.call(
      name: name,
      age: age,
      nationality: nationality,
      experience: experience,
    );

    writer.writeSuccess("\n Trainer created and saved successfully!");
    final trainerPrinter = TrainerPrinter(writer);
    trainerPrinter.printDetails(trainer);
    return trainer;
  }

  Nationality _readNationality() {
    writer.writeLine("\n🌍 Choose Nationality:");
    NationalityPrinter.printNationalitiesGridWithNumbers(writer);
    while (true) {
      final selection = reader.readString("Enter nationality number or name:");
      final asInt = int.tryParse(selection);
      if (asInt != null && asInt >= 1 && asInt <= Nationality.values.length) {
        return Nationality.values[asInt - 1];
      }
      try {
        return Nationality.values.firstWhere(
          (n) => n.name.toLowerCase() == selection.toLowerCase(),
        );
      } catch (_) {
        writer.writeError("Invalid nationality. Please choose a valid option.");
      }
    }
  }
}
