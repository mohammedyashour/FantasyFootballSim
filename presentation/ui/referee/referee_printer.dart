import '../../../domain/entities/referee.dart';
import '../../io/output/output_writer.dart';
import '../../utils/terminal_utils.dart';

class RefereePrinter {
  static void printReferee(Referee referee, OutputWriter writer) {
    writer.writeLineWithColor('🧑‍⚖️  Referee Details', TerminalColor.CYAN);
    writer.writeDivider(symbol: '=', count: 24);
    writer.writeLine('🆔 ID         : ${referee.id}');
    writer.writeLine('👤 Name       : ${referee.name}');
    writer.writeLine('🏅 Experience : ${referee.experienceYears} years');
    writer.writeLine('⚡ Strictness : ${referee.strictness}');
    writer.writeDivider(symbol: '=', count: 24);
  }

  static void printReferees(List<Referee> referees, OutputWriter writer) {
      if (referees.isEmpty) {
        writer.writeError('🚫 No referees found!');
        return;
      }
      writer.writeLineWithColor('\n📋 All Referees', TerminalColor.CYAN);
      writer.writeDivider(symbol: '-', count: 24);
      for (var referee in referees) {
        printReferee(referee, writer);
      }
      writer.writeDivider(symbol: '-', count: 24);
    }
  }

