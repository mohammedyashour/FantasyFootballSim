import '../../../domain/entities/trainer.dart';
import '../../../domain/usecases/trainer/select_trainer_usecase.dart';
import '../../io/input/console_input_reader.dart';
import '../../io/output/console_output_writer.dart';

class SelectTrainerUI {
  final SelectTrainerUseCase _selectTrainerUseCase;
  final ConsoleInputReader reader;
  final ConsoleOutputWriter writer;
  SelectTrainerUI(this._selectTrainerUseCase, this.reader, this.writer);

  Trainer? start() {
    if (_selectTrainerUseCase.existingTrainers.isEmpty) {
      writer.writeWarning(" No trainers available for selection.");
      return null;
    }

    writer.write("\n👔 Select Trainer");
    _printTrainersList();

    while (true) {
      final input = reader.readString("Enter trainer name to select:");

      final selectedTrainer = _selectTrainerUseCase.findTrainerByName(input);

      if (selectedTrainer != null) {
        writer.writeSuccess(" Trainer '${selectedTrainer.name}' selected.");
        return selectedTrainer;
      } else {
        writer.writeError("❌ Trainer not found. Please try again.");
      }
    }
  }

  void _printTrainersList() {
    writer.writeBullet("Available Trainers:");
    for (var i = 0; i < _selectTrainerUseCase.existingTrainers.length; i++) {
      final t = _selectTrainerUseCase.existingTrainers[i];
      writer.write("${i + 1}. ${t.name} (${t.experience} yrs exp)");
    }
  }
}
