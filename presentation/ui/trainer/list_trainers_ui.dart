import '../../../domain/usecases/trainer/get_all_trainers_usecase.dart';
import '../../io/input/console_input_reader.dart';

class ListTrainersUI {
  final GetAllTrainersUseCase _getAllTrainersUseCase;
  final ConsoleInputReader _inputReader;

  ListTrainersUI(this._getAllTrainersUseCase, this._inputReader);

  void start() {
    final trainers = _getAllTrainersUseCase.call();

    if (trainers.isEmpty) {
      print("⚠️ No trainers available.");
      return;
    }

    print("\n🏋️ Available Trainers:");
    trainers.asMap().forEach((index, trainer) {
      print(
        "${index + 1}. ${trainer.name} — Experience: ${trainer.experience} years",
      );
    });

    print("\nPress any key to return...");
    _inputReader.readString("");
  }
}
